## DTS 204:

### Lab Assessment: Palmer Penguins Analysis

* Dataset: penguins (Palmer Penguins Dataset)
* Context: The penguins dataset contains data on penguin species observed on three islands in the Palmer Archipelago, Antarctica.
* Loading: The dataset can be loaded in R via the palmerpenguins package.

### Variables Include:

* species – penguin species (Adelie, Chinstrap, Gentoo)
* island – island name
* bill_length_mm – bill length in mm
* bill_depth_mm – bill depth in mm
* flipper_length_mm – flipper length in mm
* body_mass_g – body mass in grams
* sex – penguin sex

---

### 1. Objective

This project will test your understanding of:

* Hypothesis testing
* Statistical inference
* Regression modeling
* Correlation analysis
* Data visualization

You will analyze the penguins dataset and interpret your results in a report format, including your code, outputs, and explanations.

---

### 2. Lab Questions and Instructions

#### Task 1: Data Exploration and Preprocessing

1. Load the penguins dataset.
2. Display the first six rows of the dataset.
3. Check for missing values. If any exist, describe how you would handle them.
4. Generate summary statistics (mean, median, range, standard deviation) for all numerical variables.

#### Task 2: Hypothesis Testing

##### i. Two-Sample t-Test

* Compare the mean body_mass_g of Adelie penguins and Gentoo penguins.
* Null Hypothesis (H0): There is no significant difference in mean body mass between Adelie and Gentoo penguins.
* Alternative Hypothesis (H1): There is a significant difference.
* Report the p-value and your conclusion.

##### ii. One-Sample Proportion Test

* Determine if the proportion of male penguins is significantly different from 50%.
* Null Hypothesis (H0): Proportion of males = 50%
* Alternative Hypothesis (H1): Proportion of males != 50%
* Report the p-value and your conclusion.

#### Task 3: Correlation Analysis

1. Compute the correlation matrix for numerical variables: bill_length_mm, bill_depth_mm, flipper_length_mm, and body_mass_g.
2. Visualize the correlation matrix using a heatmap.
3. Identify and discuss variables that are highly correlated (positive or negative).

#### Task 4: Regression Modeling

##### i. Simple Linear Regression

* Build a regression model to predict body_mass_g based on flipper_length_mm.
* Report the regression equation and interpret the coefficients.
* Assess model fit (e.g., R-squared value).

##### ii. Multiple Linear Regression

* Predict body_mass_g using flipper_length_mm, bill_length_mm, and bill_depth_mm.
* Compare performance with the simple regression model.
* Interpret the significance of each predictor variable.

#### Task 5: Visualization

1. Create a scatter plot of body_mass_g vs. flipper_length_mm with the regression line.
2. Create a boxplot showing the distribution of body_mass_g across different species.
3. Plot a histogram of body_mass_g with a normal curve overlay.

#### Task 6: Reporting Results

* Write a report including:
* Clear hypotheses, methods, and results
* Interpretations of all findings in non-technical terms
* Discussion of assumptions and limitations



---

### Submission Requirements

1. Submit an R script (.R) containing all code for your analysis.
2. Submit a well-documented PDF report with:

* Tables
* Charts
* Interpretations

3. Ensure the report is well-structured and clear.

---

### Evaluation Criteria

| Section | Weight |
| --- | --- |
| Data Exploration and Preprocessing | 10% |
| Hypothesis Testing | 20% |
| Correlation Analysis | 20% |
| Regression Modeling | 30% |
| Visualization | 10% |
| Report Quality | 10% 