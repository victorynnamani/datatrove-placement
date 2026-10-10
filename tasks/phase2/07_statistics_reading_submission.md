# Phase 2, Task 7

# Statistics and Experimentation Reading Submission

## Three things I learned

1. A confidence interval puts a range around an estimate, and the 95% describes the method, not one interval. If I repeated the sampling many times, about 95% of the intervals built this way would contain the true value. This matters for NorthStar, because Clothing's 50.0% return rate rests on very few orders, so its interval would be wide, and a wide interval tells me the sample is too small to be sure.

2. Testing many things until one gives p < 0.05 is called p-hacking, and it misleads even when you don't mean it to. Every extra test is another chance for a false positive, which is a Type I error, while a Type II error is a false negative, where a real effect goes unnoticed. This is why the metric should be fixed before looking at the results.

3. The bootstrap lets me treat my own sample as a stand-in for the wider population, resampling it with replacement many times to see how much an estimate wobbles. It needs no complicated formulas, though it cannot rescue a sample that is tiny or biased.

## One NorthStar question

### Was Scotland's December shortfall real, or normal month-to-month variation? 
This needs a significance test. 
To test whether it's real, I would compare it with how much Scotland's monthly revenue normally varies, assuming December is an ordinary month, and I would treat a small p-value as evidence that something real changed, although the test could not say why. 

## One thing I want to revisit after the placement

I want to revisit applying statistical calculations to data for interpretation and decision making after the placement. I want to be able to analyse data properly, using the right methods, so that I arrive at accurate conclusions people can base decisions on. I also want to get better at visualising and interpreting data for real life use.