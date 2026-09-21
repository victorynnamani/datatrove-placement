-- =====================================================================
-- Task 5: SQL Advanced (CTEs & Window Functions)
-- =====================================================================

-- 1. CTE vs subquery
-- =====================================================================

-- CTE version: computes each customer's total per region, then each
-- region's total, then uses ROW_NUMBER to pick the single top customer
-- per region before dividing their revenue by the region total.
WITH customer_totals AS (
    SELECT region, customer_id, SUM(total_amount) AS customer_revenue
    FROM orders
    GROUP BY region, customer_id
),
region_totals AS (
    SELECT region, SUM(total_amount) AS region_revenue
    FROM orders
    GROUP BY region
),
top_customer_per_region AS (
    SELECT region, customer_id, customer_revenue,
           ROW_NUMBER() OVER (PARTITION BY region ORDER BY customer_revenue DESC) AS rn
    FROM customer_totals
)
SELECT t.region, t.customer_id,
       ROUND(t.customer_revenue, 2) AS top_customer_revenue,
       ROUND(r.region_revenue, 2) AS region_revenue,
       ROUND(100.0 * t.customer_revenue / r.region_revenue, 2) AS pct_of_region
FROM top_customer_per_region t
JOIN region_totals r ON t.region = r.region
WHERE t.rn = 1
ORDER BY pct_of_region DESC;

-- Subquery version: finds each customer's top spend per region by
-- matching their total against the MAX customer total within that same
-- region, computed inline via a correlated subquery instead of a named
-- CTE step. The region total is also recomputed separately in a second
-- subquery rather than reused from a named block.
SELECT
    ct.region, ct.customer_id,
    ROUND(ct.customer_revenue, 2) AS top_customer_revenue,
    ROUND((SELECT SUM(total_amount) FROM orders o2 WHERE o2.region = ct.region), 2) AS region_revenue,
    ROUND(100.0 * ct.customer_revenue /
        (SELECT SUM(total_amount) FROM orders o2 WHERE o2.region = ct.region), 2) AS pct_of_region
FROM (
    SELECT region, customer_id, SUM(total_amount) AS customer_revenue
    FROM orders
    GROUP BY region, customer_id
) ct
WHERE ct.customer_revenue = (
    SELECT MAX(customer_revenue) FROM (
        SELECT customer_id, SUM(total_amount) AS customer_revenue
        FROM orders o3 WHERE o3.region = ct.region
        GROUP BY customer_id
    )
)
ORDER BY pct_of_region DESC;

-- Read: both agree, Wales's top customer contributes 6.58% of regional
-- revenue, the highest of any region. The CTE version reads better
-- since each named block states one idea, while the subquery repeats
-- the same region-sum logic twice and relies on an equality match
-- against MAX, which would silently return more than one row if two
-- customers ever tied for the top spot.


-- =====================================================================
-- 2. Ranking windows
-- =====================================================================

-- Numbers each region's orders 1, 2, 3, ... in date order by resetting
-- the count at the start of every new region (the PARTITION BY).
SELECT region, order_id, order_date,
       ROW_NUMBER() OVER (PARTITION BY region ORDER BY order_date) AS order_seq
FROM orders
ORDER BY region, order_seq;

-- Ranks customers by total spend within their own region. RANK() and
-- DENSE_RANK() only produce different numbers where two customers tie
-- on total_spend, which is what this query is built to expose.
WITH customer_totals AS (
    SELECT region, customer_id, SUM(total_amount) AS total_spend
    FROM orders
    GROUP BY region, customer_id
)
SELECT region, customer_id, ROUND(total_spend, 2) AS total_spend,
       RANK() OVER (PARTITION BY region ORDER BY total_spend DESC) AS rnk,
       DENSE_RANK() OVER (PARTITION BY region ORDER BY total_spend DESC) AS dense_rnk
FROM customer_totals
ORDER BY region, total_spend DESC;

-- Read: London's two customers tied at £521.12 both get rank 8 under
-- either function, but the next row gets RANK 10 (it skips two
-- positions for the two tied rows) versus DENSE_RANK 9 (it never
-- skips). RANK answers "what position in a strict ordering",
-- DENSE_RANK answers "how many distinct spend levels sit above this one".

-- Splits every customer into 4 equal-sized buckets by spend, ordered
-- highest to lowest, so bucket 1 is the top-spending quarter of
-- customers and bucket 4 is the lowest-spending quarter.
WITH customer_totals AS (
    SELECT customer_id, SUM(total_amount) AS total_spend
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, ROUND(total_spend, 2) AS total_spend,
       NTILE(4) OVER (ORDER BY total_spend DESC) AS spend_quartile
FROM customer_totals
ORDER BY total_spend DESC;

-- Read: quartile 1 ranges £2,471.90 to £6,260.59; quartile 4 ranges
-- £36.12 to £859.61, roughly a 7x gap between the top and bottom quarters.


-- =====================================================================
-- 3. Aggregating windows
-- =====================================================================

-- Adds up total_amount for each region as orders are processed in date
-- order, so each row shows the cumulative revenue up to and including
-- that order (the explicit frame: from the first row in the partition
-- through the current row).
SELECT region, order_id, order_date, total_amount,
       ROUND(SUM(total_amount) OVER (
           PARTITION BY region ORDER BY order_date
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ), 2) AS running_total
FROM orders
ORDER BY region, order_date;

-- Divides each order's value by the full-year total for its region
-- (the window has no ORDER BY, so it always sums the whole partition,
-- not a running subset), showing what share of that region's annual
-- revenue any single order represents.
SELECT region, order_id, total_amount,
       ROUND(100.0 * total_amount / SUM(total_amount) OVER (PARTITION BY region), 3)
           AS pct_of_region_total
FROM orders
ORDER BY region, pct_of_region_total DESC;

-- Read: Wales's largest single order (£1,865.00) alone makes up 5.31%
-- of the region's entire annual revenue.


-- =====================================================================
-- 4. Lag/lead
-- =====================================================================

-- Aggregates revenue by region and month, then LAG() pulls in each
-- month's own value from the row directly before it in the same
-- region's sequence, which is what makes the month-over-month %
-- calculation possible in one pass.
WITH monthly_region_revenue AS (
    SELECT region, strftime('%Y-%m', order_date) AS order_month,
           SUM(total_amount) AS revenue
    FROM orders
    GROUP BY region, order_month
)
SELECT region, order_month, ROUND(revenue, 2) AS revenue,
       ROUND(LAG(revenue) OVER (PARTITION BY region ORDER BY order_month), 2)
           AS prev_month_revenue,
       ROUND(
           100.0 * (revenue - LAG(revenue) OVER (PARTITION BY region ORDER BY order_month))
           / LAG(revenue) OVER (PARTITION BY region ORDER BY order_month),
       2) AS mom_growth_pct
FROM monthly_region_revenue
ORDER BY region, order_month;

-- Read: January shows NULL for prev_month_revenue in every region,
-- since there's no prior month in the data to compare to.

-- Reuses the same growth calculation as above, then sorts every
-- region-month by growth ascending and keeps only the single worst row.
WITH monthly_region_revenue AS (
    SELECT region, strftime('%Y-%m', order_date) AS order_month,
           SUM(total_amount) AS revenue
    FROM orders
    GROUP BY region, order_month
),
with_growth AS (
    SELECT region, order_month, revenue,
           LAG(revenue) OVER (PARTITION BY region ORDER BY order_month) AS prev_month_revenue,
           100.0 * (revenue - LAG(revenue) OVER (PARTITION BY region ORDER BY order_month))
               / LAG(revenue) OVER (PARTITION BY region ORDER BY order_month) AS mom_growth_pct
    FROM monthly_region_revenue
)
SELECT region, order_month, ROUND(revenue, 2) AS revenue,
       ROUND(prev_month_revenue, 2) AS prev_month_revenue,
       ROUND(mom_growth_pct, 2) AS mom_growth_pct
FROM with_growth
WHERE mom_growth_pct IS NOT NULL
ORDER BY mom_growth_pct ASC
LIMIT 1;

-- Read: the worst region-month is North, July 2024, at negative
-- 83.83% (£13,661.03 down to £2,209.10). Individual regions swing
-- harder than the whole business since they have far fewer orders
-- per month to average out.


-- =====================================================================
-- 5. Multi-step CTE
-- =====================================================================

-- Step 1 sums spend and counts orders per customer per region. Step 2
-- ranks customers inside their own region by that spend. The final
-- SELECT then just filters down to rank 3 or better.
WITH customer_region_stats AS (
    SELECT region, customer_id,
           SUM(total_amount) AS total_spend,
           COUNT(*) AS order_count
    FROM orders
    GROUP BY region, customer_id
),
ranked_customers AS (
    SELECT region, customer_id, total_spend, order_count,
           RANK() OVER (PARTITION BY region ORDER BY total_spend DESC) AS spend_rank
    FROM customer_region_stats
)
SELECT region, spend_rank, customer_id,
       ROUND(total_spend, 2) AS total_spend, order_count
FROM ranked_customers
WHERE spend_rank <= 3
ORDER BY region, spend_rank;

-- Read: 24 rows in total, 8 regions times 3 customers each. North's
-- top customer, CUST-0160, leads with £3,854.04 across 5 orders.


-- =====================================================================
-- 6. Reflection (≤ 150 words)
-- =====================================================================

-- =====================================================================
-- 6. Reflection (≤ 150 words)
-- =====================================================================

-- SQL over pandas: query 5 (top 3 customers per region by spend) is a
-- good fit for SQL because the database already has everything I need,
-- one query gives me the answer, and it will still be correct next
-- month without me having to re-run any Python.
-- pandas over SQL: query 4 told me North's revenue dropped 83.83% in
-- July 2024, but not why. To dig into that I'd rather use pandas,
-- pull North's July orders into a dataframe and plot them, since
-- exploring and visualizing data like that is easier in pandas than
-- in SQL.