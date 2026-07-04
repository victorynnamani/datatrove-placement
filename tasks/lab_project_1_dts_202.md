## DTS 202: Data Engineering

### Lab Assessment: Student Performance Analysis

* Dataset: Student Performance Dataset (UCI Machine Learning Repository – Portuguese Secondary School Students)
* Objective: Apply data engineering techniques to preprocess a real-world educational dataset and train, evaluate, and compare multiple classification models to determine student academic performance.

---

### Problem Statement

The Student Performance Dataset from the UCI Machine Learning Repository contains academic, demographic, and social data related to Portuguese secondary school students. The dataset presents typical data engineering challenges such as categorical variables, feature transformation, and data quality management.

This lab assessment focuses on applying data engineering principles to clean and prepare the dataset, followed by building and comparing three classification models—Logistic Regression, Decision Tree, and Random Forest—to predict whether a student will pass or fail. The comparison highlights trade-offs between model accuracy, interpretability, and computational complexity.

---

### Objectives

By the end of this lab project, students will be able to:

1. Perform exploratory data analysis (EDA) on a publicly available dataset.
2. Apply data cleaning techniques to improve data quality.
3. Engineer and transform features suitable for predictive modeling.
4. Prepare a structured dataset for machine learning workflows.
5. Train, evaluate, and compare the performance of three classification models using standard evaluation metrics.

---

### Instructions

#### 1. Data Exploration

* Load Dataset: Load the Student Performance Dataset from the UCI Machine Learning Repository using Python (Pandas).
* Initial Inspection: Display the first five (5) records of the dataset.
* Structure Analysis: Examine the dataset structure, data types, and size.
* Data Quality: Identify missing or inconsistent values.
* Summary Statistics: Generate descriptive statistics for numerical features.
* Visualization: Visualize relationships between selected features and the target variable (Pass/Fail).

#### 2. Data Cleaning

* Numerical Imputation: Impute missing numerical values using mean or median where applicable.
* Categorical Imputation: Impute missing categorical values using the mode.
* Deduplication: Remove duplicate records.
* Outlier Management: Detect and handle outliers in numerical features such as absences and final grades using boxplots or IQR methods.
* Documentation: Document all cleaning steps clearly.

#### 3. Feature Engineering

* Grade Category: Categorize final grades into Low, Medium, and High performance groups.
* Attendance Status: Convert absence counts into Regular or Irregular attendance categories.
* Study Load Feature: Create a composite feature by combining weekly study time and the number of past failures.
* Target Variable: Create a binary Pass/Fail variable based on final grades.

#### 4. Data Transformation

* Categorical Encoding: Encode categorical variables using label encoding or one-hot encoding.
* Feature Scaling: Scale numerical features using Min-Max Scaling or Standard Scaling.
* Readiness Check: Ensure the final dataset is fully numeric and ready for modeling.

#### 5. Model Preparation and Comparison

* Data Splitting: Split the dataset into training and testing sets (70% training, 30% testing).
* Model Training: Train the following classification models:
* Logistic Regression
* Decision Tree Classifier
* Random Forest Classifier


* Model Evaluation: Evaluate each model using:
* Accuracy score
* Confusion matrix
* Classification report (precision, recall, F1-score)


* Comparative Analysis: Compare the models based on:
* Predictive performance
* Model interpretability
* Computational complexity


* Selection: Identify the best-performing model and justify your choice using evaluation results.

---

### Report Submission Guidelines

Students must submit a structured lab report containing the following sections:

1. Title Page
* Course title
* Lab assessment title
* Student name and registration number
* Date of submission


2. Introduction
* Overview of the UCI Student Performance Dataset
* Objectives of the lab


3. Methodology
* Data exploration and cleaning steps
* Feature engineering and transformation
* Description of the three classification models


4. Results and Discussion
* Performance metrics for each model
* Comparative analysis of model results
* Visualizations supporting the comparison


5. Conclusion
* Summary of findings
* Best-performing model and justification
* Recommendations for future improvements



---

### Expected Learning Outcomes

Upon completion of this lab assessment, students will demonstrate the ability to:

* Apply the data engineering lifecycle end-to-end.
* Prepare datasets effectively for machine learning.
* Train and evaluate multiple classification models.
* Perform comparative model analysis.
* Make data-driven decisions based on evaluation metrics.
