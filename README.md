# Loan Default Risk Prediction

Statistical analysis and predictive modelling of consumer loan default risk, using Python for data preprocessing and predictive modelling, and R for exploratory statistical analysis.

## Dataset

`data/finance_loan_default_dataset_2026.csv` — 50,000 individual loan records (2018–2024), including demographic, employment, credit, and loan information, with a binary `loan_default` outcome variable.

## Project Structure

```
├── loan_default_analysis.ipynb   # Python: preprocessing, feature engineering, predictive model
├── r_analysis.R                  # R: descriptive statistics, visualisation, hypothesis testing
├── data/
│   ├── finance_loan_default_dataset_2026.csv   # Original dataset
│   └── cleaned_loan_data.csv                   # Cleaned dataset (output of the Python notebook)
└── charts/                       # Generated charts (PNG)
```

## Methodology

**Python (preprocessing & modelling)**
- Missing value treatment via median imputation (`annual_income`, `credit_score`, `loan_amount`)
- Outlier treatment using the IQR method (capping rather than removal)
- Feature engineering: `Income_Band` (Low/Medium/High) and `Credit_Risk` (Poor/Fair/Good/Excellent)
- Date processing to extract loan issue year and default trend over time
- Logistic regression model (80/20 train/test split, standardised features)

**R (exploratory & inferential analysis)**
- Descriptive statistics (mean, median, standard deviation)
- Data visualisation: bar chart, histogram, boxplot, line chart
- Chi-Square test of independence (employment status vs. default)
- Logistic regression (credit score vs. default)

## Key Results

| Metric | Value |
|---|---|
| Overall default rate | 24.83% |
| Model accuracy | 79.73% |
| ROC-AUC | 0.7883 |
| Precision (default class) | 67.07% |
| Recall (default class) | 36.09% |

**Top predictors of default:** credit score, interest rate, DTI ratio, employment status, annual income.

**Chi-Square test:** significant association between employment status and default (X² = 3946.4, df = 4, p < .001).

## How to Run

**Python:**
```bash
pip install pandas numpy matplotlib scikit-learn
jupyter notebook loan_default_analysis.ipynb
```

**R:**
```r
source("r_analysis.R")
```

## Author

Ali Danish Alvi
