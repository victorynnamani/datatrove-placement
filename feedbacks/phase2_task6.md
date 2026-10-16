# Feedback — Phase 2, Task 6: The NorthStar Monthly Report

**Reviewer:** Promise Ekeh, Head of Analytics  
**Submitted by:** Victory Nnamani

---

## Overall

Strong work, Victory. The report tells a coherent story about December's revenue increase, category movement, regional performance and the higher return rate. You connect the findings to specific actions, and you are careful not to overstate the small return-rate samples. The charts are clear and the Wales note is a good example of explaining a scale choice rather than hiding it.

**Grade indication:** Pass with merit. Fix the report length and chart-label requirements, then regenerate the report from a clean notebook run. The analysis and business interpretation are already strong.

## What you did well

- **The comparison is grounded in the brief.** December 2024 is compared with November 2024, with revenue, order value and customer counts available to support the headline.
- **The category analysis finds the drivers and drag.** You identify Food & Drink, Beauty and Electronics as contributors to the increase, and Sports as the only category to decline.
- **The regional target analysis is thoughtful.** You use the specified 5% target, flag Scotland and East as misses, and explain why Wales's very small November base makes its large percentage uplift misleading.
- **The report interprets, rather than just describes.** The recommendations follow from the findings, including investigating the Sports decline, reviewing Clothing returns and checking in with Scotland.
- **You handle uncertainty responsibly.** You describe small category and region return-rate counts as directional signals, not confirmed effects.
- **The analysis includes a useful independent check.** You compare the November and December revenue totals from pandas with totals queried from the SQLite database.

## Things to fix

### 1. Bring the exported report within the page limit (must-fix)

The PDF is six pages, while the brief asks for a 3–5 page report. The sixth page appears to contain only a small amount of overflow. Tighten the layout or adjust the page break so the complete report, including the cover, fits within five pages without making the text difficult to read.

### 2. Add explicit labels for both chart axes (must-fix)

The charts have clear titles and the numeric axes are labelled, but not every chart labels both axes explicitly. For example, Chart 1 needs a month label on the x-axis; Chart 2 needs a product-category label; Chart 3 needs a region label; and Chart 4 needs a product-category label. Add these in the notebook and regenerate the chart images and PDF.

### 3. Re-run the notebook before regenerating the final report

The notebook has saved outputs, but its cells are marked as not executed. Run it from the top in a clean kernel, verify the pandas and SQL totals still agree, and regenerate the PDF and charts from that run. This will make the report's numbers traceable to a current, reproducible analysis rather than relying on stored outputs alone.

## Smaller notes

- Keep the one-page chart captions concise; the current "what" and "so what" framing is effective and should be preserved while adjusting the layout.
- The day-of-week discussion is appropriately cautious. Keep the distinction between an observed December difference and a repeatable business pattern clear.

---

— Promise  
Head of Analytics, DataTrove
