##############################################################
# DTS 204
# Lab Assessment: Palmer Penguins Dataset
# By Victory Nnamani
##############################################################

# ---- Load required libraries ----
# palmerpenguins: gives us the penguins dataset itself
# dplyr: used for the pipe operator (%>%) and data wrangling
# ggplot2: used for all the plots in Task 5
# corrplot: used to draw the correlation heatmap in Task 3
library(palmerpenguins)
library(dplyr)
library(ggplot2)
library(corrplot)

# ---- Load dataset ----
# data() pulls the built-in penguins dataset into the environment.
# We copy it into penguins_df so the original stays untouched,
# in case we need to compare against it later.
data(penguins)
penguins_df <- penguins

##############################################################
# TASK 1: DATA EXPLORATION AND PREPROCESSING
##############################################################

cat("\n==================== TASK 1: DATA EXPLORATION ====================\n")

# ---- 1. First six rows ----
# head() with n = 6 shows exactly what the lab asks for: a quick
# look at the structure and the type of values in each column.
cat("\n---- 1.1 First Six Rows of the Dataset ----\n")
print(head(penguins_df, 6))

# ---- 2. Check for missing values ----
# colSums(is.na(...)) counts how many NAs sit in each column.
cat("\n---- 1.2 Missing Values per Column ----\n")
print(colSums(is.na(penguins_df)))

# Missing values exist in bill_length_mm, bill_depth_mm,
# flipper_length_mm, body_mass_g (2 each) and sex (11 rows).
# These add up to about 3% of the 344 total rows, and they are
# not concentrated in one species or island, so the safest and
# simplest fix is to drop the incomplete rows rather than guess
# (impute) values for them. Imputing here would risk quietly
# distorting the summary statistics and every test that follows.
#
# na.omit() removes any row that has at least one NA in any
# column, giving us a "complete cases only" version of the data.
penguins_clean <- penguins_df %>% na.omit()

cat("\n---- 1.2b Rows Remaining After Removing Incomplete Cases ----\n")
cat("Original rows:", nrow(penguins_df), "\n")
cat("Clean rows:   ", nrow(penguins_clean), "\n")

# ---- 3. Summary statistics for numerical variables ----
# We only compute summary stats for the four numerical columns
# the lab asks about: bill length, bill depth, flipper length,
# and body mass. Categorical columns like species/island/sex
# don't have a mean or median in the usual sense.
num_vars <- c("bill_length_mm", "bill_depth_mm",
              "flipper_length_mm", "body_mass_g")

# For each variable we compute: mean, median, min, max, the
# range (max - min), and the standard deviation (sd).
summary_stats <- sapply(penguins_clean[num_vars], function(x) {
  c(mean   = mean(x),
    median = median(x),
    min    = min(x),
    max    = max(x),
    range  = max(x) - min(x),
    sd     = sd(x))
})

cat("\n---- 1.3 Summary Statistics (Numerical Variables) ----\n")
print(round(t(summary_stats), 2))

##############################################################
# TASK 2: HYPOTHESIS TESTING
##############################################################

cat("\n\n==================== TASK 2: HYPOTHESIS TESTING ====================\n")

# ---- i. Two-Sample t-Test: Adelie vs Gentoo body mass ----
# H0: There is no significant difference in mean body mass
#     between Adelie and Gentoo penguins.
# H1: There is a significant difference.
#
# We subset body_mass_g separately for each species using
# logical indexing (penguins_clean$species == "Adelie" etc.),
# then feed both vectors into t.test(). By default t.test()
# in R runs Welch's t-test, which does NOT assume the two
# groups have equal variances, a safer default when we haven't
# checked that assumption first.
cat("\n---- 2.1 Two-Sample t-Test: Adelie vs Gentoo Body Mass ----\n")

adelie_mass <- penguins_clean$body_mass_g[penguins_clean$species == "Adelie"]
gentoo_mass <- penguins_clean$body_mass_g[penguins_clean$species == "Gentoo"]

cat("Adelie: n =", length(adelie_mass),
    "| mean =", round(mean(adelie_mass), 2),
    "| sd =", round(sd(adelie_mass), 2), "\n")
cat("Gentoo: n =", length(gentoo_mass),
    "| mean =", round(mean(gentoo_mass), 2),
    "| sd =", round(sd(gentoo_mass), 2), "\n\n")

t_test_result <- t.test(adelie_mass, gentoo_mass)
print(t_test_result)

# Interpretation: if the p-value is below 0.05, we reject H0.
# Here p is astronomically small, so Gentoo penguins are
# significantly heavier than Adelie penguins on average.

# ---- ii. One-Sample Proportion Test: proportion of males ----
# H0: Proportion of males = 50%
# H1: Proportion of males != 50%
#
# table() counts how many "male" and "female" entries exist in
# the sex column. prop.test() then checks whether the observed
# proportion of males is significantly different from 0.5,
# using a chi-squared test with a continuity correction (this
# is the standard, more conservative approach for proportions
# based on small-ish counts).
cat("\n---- 2.2 One-Sample Proportion Test: Proportion of Male Penguins ----\n")

sex_table <- table(penguins_clean$sex)
print(sex_table)

n_male  <- sex_table["male"]
n_total <- sum(sex_table)

cat("\nProportion male:", round(n_male / n_total, 4), "\n\n")

prop_test_result <- prop.test(n_male, n_total, p = 0.5)
print(prop_test_result)

# Interpretation: the p-value here is far above 0.05, so we
# fail to reject H0. The male/female split is not significantly
# different from 50/50.

##############################################################
# TASK 3: CORRELATION ANALYSIS
##############################################################

cat("\n\n==================== TASK 3: CORRELATION ANALYSIS ====================\n")

# ---- 1. Correlation matrix ----
# cor() computes the Pearson correlation coefficient between
# every pair of the four numerical variables.
cat("\n---- 3.1 Correlation Matrix ----\n")
corr_matrix <- cor(penguins_clean[num_vars])
print(round(corr_matrix, 3))

# ---- 2. Visualize with a heatmap ----
# corrplot() turns the correlation matrix into a color-coded
# grid. method = "color" fills each cell with a color scaled
# to the correlation strength, type = "upper" only shows the
# upper triangle since the matrix is symmetric (no need to
# show every value twice), and addCoef.col prints the actual
# numbers on top of the colors for precision.
cat("\n---- 3.2 Correlation Heatmap (see Plots pane) ----\n")
corrplot(corr_matrix, method = "color", type = "upper",
         addCoef.col = "black", tl.col = "black",
         title = "Correlation Heatmap of Penguin Measurements",
         mar = c(0, 0, 2, 0))

# Interpretation: flipper length and body mass are the most
# strongly correlated pair (around 0.87), a strong positive
# relationship. Bill depth is negatively correlated with both
# flipper length and body mass, which turns out to be a
# species-mixing effect (Gentoo are long-flippered, heavy, and
# shallow-billed all at once) rather than a real trade-off
# within a single bird.

##############################################################
# TASK 4: REGRESSION MODELING
##############################################################

cat("\n\n==================== TASK 4: REGRESSION MODELING ====================\n")

# ---- i. Simple Linear Regression ----
# lm() fits a straight-line model predicting body_mass_g from
# flipper_length_mm alone.
cat("\n---- 4.1 Simple Linear Regression: body_mass_g ~ flipper_length_mm ----\n")

simple_model <- lm(body_mass_g ~ flipper_length_mm, data = penguins_clean)
print(summary(simple_model))

# Interpretation: the coefficient on flipper_length_mm tells us
# how many extra grams of body mass we expect per extra
# millimetre of flipper length. The R-squared value tells us
# what share of the variation in body mass this one variable
# explains (here, about 76%), which is a strong result for a
# single predictor.

# ---- ii. Multiple Linear Regression ----
# Now we add bill_length_mm and bill_depth_mm as extra
# predictors, to see whether they add real explanatory power
# on top of flipper length.
cat("\n---- 4.2 Multiple Linear Regression: body_mass_g ~ flipper + bill_length + bill_depth ----\n")

multi_model <- lm(body_mass_g ~ flipper_length_mm + bill_length_mm + bill_depth_mm,
                   data = penguins_clean)
print(summary(multi_model))

# ---- Compare the two models ----
# anova() compares the simple and multiple models directly to
# test whether the extra variables significantly improve the
# fit. AIC() (Akaike Information Criterion) gives a second way
# to compare them: a lower AIC means a better trade-off between
# model fit and model complexity.
cat("\n---- 4.3 Model Comparison: Simple vs Multiple Regression ----\n")
print(anova(simple_model, multi_model))
print(AIC(simple_model, multi_model))

# Interpretation: R-squared barely moves (0.762 to 0.764) when
# we add the two extra predictors, and neither bill_length_mm
# nor bill_depth_mm is statistically significant on its own.
# This tells us flipper length is doing almost all of the work,
# and the simpler model is the more practical choice since it
# is just as predictive and far easier to explain.

##############################################################
# TASK 5: VISUALIZATION
##############################################################

cat("\n\n==================== TASK 5: VISUALIZATION ====================\n")

# ---- 1. Scatter plot with regression line ----
# geom_point() draws the raw data, geom_smooth(method = "lm")
# overlays the fitted regression line from Task 4 along with a
# shaded confidence band (se = TRUE).
cat("\n---- 5.1 Scatter Plot: Body Mass vs Flipper Length (see Plots pane) ----\n")

print(
  ggplot(penguins_clean, aes(x = flipper_length_mm, y = body_mass_g)) +
    geom_point(alpha = 0.6, color = "#4C72B0") +
    geom_smooth(method = "lm", color = "red", se = TRUE) +
    labs(title = "Body Mass vs Flipper Length with Regression Line",
         x = "Flipper Length (mm)", y = "Body Mass (g)") +
    theme_minimal()
)

# ---- 2. Boxplot of body mass by species ----
# geom_boxplot() shows the median, interquartile range, and
# outliers of body_mass_g for each species side by side, which
# makes it easy to see whether species differ visually before
# ever running a formal test.
cat("\n---- 5.2 Boxplot: Body Mass by Species (see Plots pane) ----\n")

print(
  ggplot(penguins_clean, aes(x = species, y = body_mass_g, fill = species)) +
    geom_boxplot() +
    labs(title = "Body Mass Distribution by Species",
         x = "Species", y = "Body Mass (g)") +
    theme_minimal() +
    theme(legend.position = "none")
)

# ---- 3. Histogram with normal curve overlay ----
# geom_histogram() bins body_mass_g into 20 bins and shows
# density (not raw counts) on the y-axis so it lines up on the
# same scale as the normal curve. stat_function() draws a
# theoretical normal distribution using the sample's own mean
# and standard deviation, so we can visually check how close
# (or far) the real data is from a perfect bell curve.
cat("\n---- 5.3 Histogram with Normal Curve Overlay (see Plots pane) ----\n")

print(
  ggplot(penguins_clean, aes(x = body_mass_g)) +
    geom_histogram(aes(y = after_stat(density)), bins = 20,
                   fill = "#4C72B0", color = "white", alpha = 0.7) +
    stat_function(fun = dnorm,
                  args = list(mean = mean(penguins_clean$body_mass_g),
                              sd = sd(penguins_clean$body_mass_g)),
                  color = "red", linewidth = 1) +
    labs(title = "Distribution of Body Mass with Normal Curve",
         x = "Body Mass (g)", y = "Density") +
    theme_minimal()
)

# Interpretation: the histogram is not a clean single bell
# curve. It looks slightly bimodal, because three species with
# different typical body masses (Adelie, Chinstrap, Gentoo) are
# all mixed into the one column. This is a useful reminder that
# a single normal curve cannot fully describe a dataset that is
# really made up of separate subgroups.

##############################################################
# TASK 6: SUMMARY
##############################################################

cat("\n\n==================== TASK 6: SUMMARY ====================\n")
cat("
1. Gentoo penguins are significantly heavier than Adelie penguins
   (Welch t-test, p < 0.001).
2. The male/female split is not significantly different from 50/50
   (prop.test, p = 0.913).
3. Flipper length alone explains about 76% of the variation in body
   mass (simple linear regression, R-squared = 0.762).
4. Adding bill length and bill depth barely improves the model
   (R-squared = 0.764), and neither variable is significant on its
   own, so the simpler model is the more practical choice.
5. Bill depth's negative correlation with flipper length and body
   mass reflects species differences (Gentoo are long-flippered,
   heavy, and shallow-billed), not a real trade-off within one bird.
\n")

##############################################################
# END OF SCRIPT
##############################################################
