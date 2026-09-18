-- =========================================================================
-- Phase 2, Task 4: SQL Fundamentals
-- NorthStar Goods
--
-- Schema was created by hand with CREATE TABLE below. The two source CSVs
-- were then loaded into these tables using DBeaver's Import Data wizard
-- (right-click each table -> Import Data -> CSV -> target existing table),
-- not by letting the import auto-generate a schema.
-- =========================================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS regions;

CREATE TABLE regions (
    region              TEXT PRIMARY KEY,
    regional_manager    TEXT NOT NULL,
    country             TEXT NOT NULL,
    launch_date         DATE NOT NULL
);

CREATE TABLE orders (
    order_id            TEXT PRIMARY KEY,
    order_date          DATE NOT NULL,
    customer_id         TEXT NOT NULL,
    region               TEXT NOT NULL,
    product_category     TEXT NOT NULL,
    quantity             INTEGER NOT NULL,
    unit_price            REAL NOT NULL,
    discount_pct           INTEGER NOT NULL,
    payment_method           TEXT NOT NULL,
    total_amount              REAL NOT NULL,
    returned                   TEXT NOT NULL,
    FOREIGN KEY (region) REFERENCES regions(region)
);

-- Row counts after loading: regions = 8, orders = 999


-- =========================================================================
-- 1. SELECT / WHERE / ORDER BY / LIMIT
-- =========================================================================

-- 1a. Top 20 orders by total_amount
SELECT order_id, region, total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 20;
-- Read: highest single order is £1,974.00 (North); top 20 span roughly
-- £1,700-£1,974.

-- 1b. London orders after 2024-06-01 with discount_pct > 10
SELECT order_id, order_date, region, discount_pct, total_amount
FROM orders
WHERE region = 'London'
  AND order_date > '2024-06-01'
  AND discount_pct > 10
ORDER BY order_date;
-- Read: 9 qualifying orders, all at exactly 15% or 20% discount.


-- =========================================================================
-- 2. Aggregation
-- =========================================================================

-- 2a. Total revenue
SELECT ROUND(SUM(total_amount), 2) AS total_revenue
FROM orders;
-- Read: £513,619.05 total revenue across 999 orders.

-- 2b. Unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM orders;
-- Read: 290 unique customers.

-- 2c. Min/max/avg basket size
SELECT MIN(quantity) AS min_basket,
       MAX(quantity) AS max_basket,
       ROUND(AVG(quantity), 2) AS avg_basket
FROM orders;
-- Read: quantity ranges 1-10, average 5.51.


-- =========================================================================
-- 3. GROUP BY / HAVING
-- =========================================================================

-- 3a. Revenue per region, descending
SELECT region, ROUND(SUM(total_amount), 2) AS revenue
FROM orders
GROUP BY region
ORDER BY revenue DESC;
-- Read: North leads at £89,670.44, Wales trails at £35,158.23.

-- 3b. Categories with revenue > £10,000
SELECT product_category, ROUND(SUM(total_amount), 2) AS revenue
FROM orders
GROUP BY product_category
HAVING SUM(total_amount) > 10000
ORDER BY revenue DESC;
-- Read: all 7 categories clear £10,000; Sports highest at £83,058.95.

-- 3c. Regions with more than 100 orders
SELECT region, COUNT(*) AS order_count
FROM orders
GROUP BY region
HAVING COUNT(*) > 100
ORDER BY order_count DESC;
-- Read: 6 of 8 regions clear 100 orders; Scotland and Wales don't.


-- =========================================================================
-- 4. JOIN
-- =========================================================================

-- 4a. Inner join orders to regions
SELECT o.order_id, o.region, r.regional_manager, o.total_amount
FROM orders AS o
INNER JOIN regions AS r ON o.region = r.region
LIMIT 5;

-- 4a continued: confirm row count unchanged
SELECT
    (SELECT COUNT(*) FROM orders) AS orders_row_count,
    (SELECT COUNT(*) FROM orders AS o
     INNER JOIN regions AS r ON o.region = r.region) AS inner_join_row_count;
-- Read: both are 999 -- the join matched every order, proving Task 2's
-- casing fix worked.

-- 4b. Left join after deleting one regions row, to observe the NULLs.
-- Wrapped in a transaction so the delete can be rolled back afterwards.
BEGIN TRANSACTION;

DELETE FROM regions WHERE region = 'Wales';

SELECT o.order_id, o.region, r.regional_manager
FROM orders AS o
LEFT JOIN regions AS r ON o.region = r.region
WHERE o.region = 'Wales'
LIMIT 5;

SELECT COUNT(*) AS orders_with_null_manager
FROM orders AS o
LEFT JOIN regions AS r ON o.region = r.region
WHERE r.regional_manager IS NULL;
-- Read: 71 orders (exactly the Wales count) now show NULL, confirming a
-- left join keeps unmatched rows instead of silently dropping them.

ROLLBACK;
-- Restores the Wales row so the saved database still has all 8 regions.


-- =========================================================================
-- 5. Subqueries
-- =========================================================================

-- 5a. Best region by revenue (subquery)
SELECT region, total_revenue
FROM (
    SELECT region, SUM(total_amount) AS total_revenue
    FROM orders
    GROUP BY region
) AS region_totals
ORDER BY total_revenue DESC
LIMIT 1;
-- Read: North, £89,670.44.

-- 5b. Orders above the overall average total_amount
SELECT order_id, region, total_amount
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
ORDER BY total_amount DESC
LIMIT 10;

SELECT COUNT(*) AS above_average_count
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders);
-- Read: 408 of 999 orders (about 41%) sit above average.