# Phase 2, Task 7

# Statistics and Experimentation Reading Submission

## Three things I learned

1. A confidence interval puts a range around an estimate, and the 95% describes the method, not one interval. If I repeated the sampling many times, about 95% of the intervals built this way would contain the true value. This matters for NorthStar, because Clothing's 50.0% return rate rests on very few orders, so its interval would be wide, and a wide interval tells me the sample is too small to be sure.

2. Testing many things until one gives p < 0.05 is called p-hacking, and it misleads even when you don't mean it to. Every extra test is another chance for a false positive, which is a Type I error, while a Type II error is a false negative, where a real effect goes unnoticed. This is why the metric should be fixed before looking at the results. A/B testing builds in this discipline, because the groups, the metric and the end date are all chosen before the test starts.

3. The bootstrap lets me treat my own sample as a stand-in for the wider population, resampling it with replacement many times to see how much an estimate wobbles. It needs no complicated formulas, though it cannot rescue a sample that is tiny or biased.

## One NorthStar question

### Does a 10% discount change how many orders customers return?

NorthStar's data covers one year, so a test of whether Scotland's December shortfall was unusual would rest on a single December, with seasonality ignored. A controlled experiment is a better fit. 

I would randomly assign eligible customers to a 10% discount or the usual offer, and fix the primary outcome (returns per eligible customer) and the observation window (for example, 60 days) before starting. Revenue per customer would be a guardrail, to check that any change in returns does not come with lower revenue (margin would be better, but the data has no cost field). With only about 290 customers a year, I would calculate the sample size needed first, as the test may need several months.

I would report the difference between the groups with a confidence interval. A small p-value is evidence against the null hypothesis of no difference, under the test's assumptions. It is not the probability that the null is true, and it is not proof of an effect or of causation on its own. Random assignment lets me attribute a difference to the discount, but only for this discount, these customers and this period.

## One thing I want to revisit after the placement

I want to revisit applying statistical calculations to data for interpretation and decision making after the placement. I want to be able to analyse data properly, using the right methods, so that I arrive at accurate conclusions people can base decisions on. I also want to get better at visualising and interpreting data for real life use.