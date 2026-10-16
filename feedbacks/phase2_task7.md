# Feedback — Phase 2, Task 7: Statistics & Experimentation (Reading)

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Good work, Victory. Your explanations of confidence intervals, Type I and Type II errors, and bootstrapping are clear and mostly in your own words. I especially like that you connect uncertainty to the small number of Clothing orders rather than treating a 50% return rate as conclusive.

**Grade indication:** Complete for the awareness task, with one important revision to the proposed NorthStar question. The reading summaries are solid; sharpen the proposed test so it is something the available data and design can actually support.

## What you did well

- **Confidence intervals are explained accurately.** You correctly distinguish the repeated-sampling interpretation of a 95% interval from the claim that a particular interval has a 95% probability of containing the true value.
- **You connect sample size to uncertainty.** Clothing's 50% return rate is a useful example of why a rate based on few orders can have substantial uncertainty.
- **The error types and multiple testing point are clear.** You explain false positives, false negatives and why repeatedly testing outcomes can mislead.
- **The bootstrap explanation includes an important limitation.** Resampling can show how an estimate varies, but it cannot fix a tiny or biased original sample.
- **Your reflection gives a meaningful next step.** You want to improve at choosing statistical methods and turning results into decisions, which is a useful direction for the next phase.

## Thing to fix

### Make the NorthStar test question testable with the available data

You ask whether Scotland's December revenue shortfall is real or normal month-to-month variation, and propose comparing it with Scotland's usual monthly variation. The dataset covers only one year, so there is just one December observation and only a small number of monthly observations overall. Assuming December is an ordinary month also ignores possible seasonality. That is not enough to support a reliable significance test of whether December was unusual.

A stronger example would be a controlled discount test: randomly assign eligible customers to a 10% discount or the usual offer, define the outcome and observation window before starting, and compare the groups after enough customers have completed that window. You could use returns per eligible customer as the primary outcome and track revenue or margin as a guardrail. Keep the conclusion limited to the difference the experiment can establish.

Also tighten the p-value wording: a small p-value is evidence against the null under the test's assumptions; it is not the probability that the null is true, proof that a real effect exists, or proof of causation by itself.

## Smaller note

- You selected three topics for the required three takeaways, which is fine. Since the prompt also includes A/B testing and Bayesian thinking as reading topics, one short mention of either in your takeaways would show a little more breadth, but it is not a blocker.

---

— Promise  
Head of Analytics, DataTrove
