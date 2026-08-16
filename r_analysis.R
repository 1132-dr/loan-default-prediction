# ============================================================
# Loan Default Risk - R Statistical Analysis
# ============================================================

# Load cleaned dataset (produced by the Python notebook)
df <- read.csv("data/cleaned_loan_data.csv")

# ------------------------------------------------------------
# 1. Descriptive Statistics
# ------------------------------------------------------------
summary(df[c("age","annual_income","credit_score","loan_amount",
             "interest_rate","dti_ratio")])

sapply(df[c("age","annual_income","credit_score","loan_amount",
            "interest_rate","dti_ratio")], sd, na.rm = TRUE)

table(df$Income_Band)
table(df$Credit_Risk)
table(df$loan_default)

# ------------------------------------------------------------
# 2. Data Visualisation
# ------------------------------------------------------------

# Chart 1: Bar chart - default rate by loan purpose
default_by_purpose <- aggregate(loan_default ~ loan_purpose, data = df, FUN = mean)
default_by_purpose$loan_default <- default_by_purpose$loan_default * 100

png("charts/chart1_bar_default_by_purpose.png", width = 2400, height = 1800, res = 300)
par(mar = c(8, 5, 2, 2))
barplot(default_by_purpose$loan_default,
        names.arg = default_by_purpose$loan_purpose,
        ylab = "Default Rate (%)", col = "steelblue", las = 2, cex.names = 0.8)
mtext("Loan Purpose", side = 1, line = 6.5)
dev.off()

# Chart 2: Histogram - credit score distribution
png("charts/chart2_histogram_credit_score.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 2, 2))
hist(df$credit_score, main = "", xlab = "Credit Score", ylab = "Frequency",
     col = "steelblue", breaks = 30)
dev.off()

# Chart 3: Boxplot - income by employment status
png("charts/chart3_boxplot_income_by_employment.png", width = 2400, height = 1800, res = 300)
par(mar = c(9, 6, 2, 2))
boxplot(annual_income ~ employment_status, data = df, col = "steelblue",
        las = 2, xlab = "", ylab = "")
mtext("Employment Status", side = 1, line = 7)
mtext("Annual Income", side = 2, line = 4)
dev.off()

# Chart 4: Line chart - default trend by year
default_by_year <- aggregate(loan_default ~ Loan_Year, data = df, FUN = mean)
default_by_year$loan_default <- default_by_year$loan_default * 100

png("charts/chart4_line_default_trend_by_year.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 2, 2))
plot(default_by_year$Loan_Year, default_by_year$loan_default, type = "o",
     xlab = "Year", ylab = "Default Rate (%)", col = "steelblue", lwd = 2, pch = 16)
dev.off()

# ------------------------------------------------------------
# 3. Hypothesis Testing - Chi-Square Test
# ------------------------------------------------------------
contingency_table <- table(df$employment_status, df$loan_default)
print(contingency_table)

chi_test <- chisq.test(contingency_table)
print(chi_test)

# ------------------------------------------------------------
# 4. Relationship Analysis - Logistic Regression
# ------------------------------------------------------------
model <- glm(loan_default ~ credit_score, data = df, family = "binomial")
summary(model)
