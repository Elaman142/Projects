# Customer Churn Prediction

A machine learning project that predicts which telecom customers are likely to cancel their service, built as part of my Data Science portfolio.

![Python](https://img.shields.io/badge/Python-3.8+-blue?style=flat-square&logo=python)
![scikit-learn](https://img.shields.io/badge/scikit--learn-1.3+-orange?style=flat-square&logo=scikit-learn)
![Jupyter](https://img.shields.io/badge/Notebook-Google%20Colab-F9AB00?style=flat-square&logo=googlecolab)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat-square)

---

## Overview

Customer churn is a costly problem for any subscription-based business. Losing a customer is not just a lost invoice — it represents the cost of acquisition, onboarding, and lost lifetime value. This project builds an end-to-end ML pipeline to identify at-risk customers before they leave, giving the business a window to act.

**Core question:** Given a customer's contract type, billing history, and service usage — will they churn?

---

## Results

| Model | AUC Score |
|---|---|
| Logistic Regression | 0.840 |
| Random Forest | 0.825 |

Logistic Regression outperformed Random Forest and was selected as the final model.

### Confusion Matrix — Logistic Regression

| | Predicted: No Churn | Predicted: Churn |
|---|---|---|
| **Actual: No Churn** | 920 | 115 |
| **Actual: Churn** | 169 | 205 |

### Recall Comparison

| Model | Churners Detected | Churners Missed |
|---|---|---|
| Logistic Regression | 55% | 45% |
| Random Forest | 49% | 51% |

Logistic Regression identified 6.1% more churners than Random Forest — roughly 61 additional at-risk customers per 1,000.

---

## Why Recall and not Accuracy?

Accuracy alone is misleading in churn problems. A model that predicts "No Churn" for everyone would achieve 73% accuracy on this dataset — and be completely useless.

What actually matters is recall: of all the customers who were going to leave, how many did the model catch? Missing a churner means losing them with no chance to intervene. Flagging a loyal customer by mistake costs a discount call. The asymmetry is clear — recall is the metric that aligns with the real business cost.

From a practical standpoint:
- Logistic Regression identifies roughly 548 out of every 1,000 churners
- Random Forest identifies roughly 487 out of every 1,000 churners

At scale, that gap translates directly into retained revenue.

---

## Key Findings

- TotalCharges is the strongest individual predictor — customers with higher cumulative spend tend to stay longer
- MonthlyCharges above a certain threshold correlates with higher churn risk
- Tenure is strongly inversely related to churn — the longer a customer has been around, the less likely they are to leave
- Month-to-month contract customers churn at roughly 3x the rate of customers on annual contracts

---

## Visualizations

![Churn Analysis](churn_analysis.png)
![Recall Comparison](recall_comparison.png)
![Model Results](churn_results.png)

---

## Project Structure

```
churn-prediction/
│
├── churn_prediction.ipynb    # Full pipeline with markdown explanations
├── churn_analysis.png        # EDA charts
├── recall_comparison.png     # Recall breakdown by model
├── churn_results.png         # ROC curves, confusion matrix, feature importance
├── requirements.txt
└── README.md
```

---

## How to Run

Open the notebook directly in Google Colab. The dataset is pulled automatically — no manual download needed.

```python
url = "https://raw.githubusercontent.com/IBM/telco-customer-churn-on-icp4d/master/data/Telco-Customer-Churn.csv"
df = pd.read_csv(url)
```

Run the cells in order. Each section includes markdown context explaining the reasoning behind each step.

---

## Stack

- Python 3.8+
- pandas
- scikit-learn
- matplotlib / seaborn
- numpy

---

## Pipeline

```
1. Load Data       — IBM Telco Customer Churn (7,043 customers, 21 features)
2. EDA             — Churn distribution, contract analysis, charge patterns
3. Preprocessing   — Fix data types, encode categoricals, scale features
4. Train           — Logistic Regression and Random Forest
5. Evaluate        — AUC-ROC, Recall, Confusion Matrix, Classification Report
6. Visualize       — ROC curves, recall pie charts, feature importance
```

---

## Dataset

IBM Telco Customer Churn — 7,043 customers, 21 features, 26.5% churn rate.
Source: [Kaggle](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)

---

## What I Learned

Working through this project clarified a few things that are easy to miss when just reading about ML:

- Real datasets have messy edges — TotalCharges was stored as a string with whitespace values hiding missing data
- Choosing the right metric matters more than choosing the right model — a well-tuned Logistic Regression beat Random Forest because the evaluation was aligned to the actual business problem
- Translating model output into business language (retained customers, revenue impact) is just as important as the technical work

---

## Author

**Elaman Ulloa**
[![GitHub](https://img.shields.io/badge/GitHub-Elaman142-black?style=flat-square&logo=github)](https://github.com/Elaman142)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Elaman%20Ulloa-blue?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/elaman-ulloa-a5765b263/)

---

*Built as part of my Data Science portfolio — Matsuo Lab ML program*
