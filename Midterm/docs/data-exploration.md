# 📊 Data Exploration Report

## 📌 Objective
Briefly describe what you are trying to understand from the raw dataset.

Example:
Explore café sales data to understand structure, quality issues, and initial patterns.

---

## 📂 Dataset Overview
- Rows: 10,000
- Columns: 8

- File format:CSV
- Original Source:
- Source File Name: "dirty_cafe_sales.csv"
   - Renamed to "cafe_sales_raw.csv" [placeholder](placeholder)
-

---

## 🧾 Column Descriptions
[Cafe Sales Column Description Source](https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training)

| Column Name | Type | Description |
|-------------|------|-------------|
|       Transaction ID      | string     |  A unique identifier for each transaction. Always present and unique.          |
|Item| string| The name of the item purchased. May contain missing or invalid values (e.g., "ERROR").|
|Quantity| int | The quantity of the item purchased. May contain missing or invalid values.|
| Price Per Unit | decimal| The price of a single unit of the item. May contain missing or invalid values.|
|Total Spent | decimal | The total amount spent on the transaction. Calculated as Quantity * Price Per Unit.|
| Payment_Method | string | The method of payment used. May contain missing or invalid values (e.g., None, "UNKNOWN").| 
| Location | string | The location where the transaction occurred. May contain missing or invalid values.| 
|Transaction Date| date | The date of the transaction. May contain missing or incorrect values.|
---

## 🔍 Initial Observations
 
- Missing values found in:
  <br>Recall: Data row count is 10,000</br>
  |Column Name | Count of Missing Data| Percentage of Missing Data|
  |------------|----------------------|---------------------------|
  | Transaction ID | 0 | 0%|
  |  Item | 969 | 9.69% |
  |  Quantity | 479 | 4.79% |
  |  Price per Unit | 533| 5.33%|
  | Total Spent | 502 | 5.01%|
  | Payment Method | 3178 | 31.78%|
  | Location | 3961 | 39.61%|
  | Date | 460 | 4.60%|
- Duplicate rows: Not Applicable 
- Strange or unexpected values:
- Unique Values for Categorical Columns:
  

---

## 📊 Basic Statistics
- Summary statistics (mean, median, etc.)
- Key distributions
- Value counts for categorical variables

---

## 📈 Early Insights
- Observation 1
- Observation 2
- Observation 3

---

## ⚠️ Data Quality Issues
- Issue 1
- Issue 2
- Issue 3

---

## 🧠 Notes
Any additional thoughts before cleaning.
