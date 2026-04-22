# 📊 Data Exploration Report

## 📌 Objective
Explore café sales data to understand structure, quality issues, and initial patterns.

---

## 📂 Dataset Overview
- Rows: 10,000
- Columns: 8

- File format:CSV
- Original Source:
- Source File Name: "dirty_cafe_sales.csv"
   - Renamed to "cafe_sales_raw.csv" [placeholder](placeholder)

---

## 🧾 Column Descriptions
[Kaggle Cafe Sales Column Description Source](https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training)

<b> Cafe Sales Columns Details</b>
<img width="1417" height="265" alt="image" src="https://github.com/user-attachments/assets/ee6f3c3c-dcb0-47a9-a2cc-b78c04043200" />


---

## 🔍 Initial Observations

### 🧮 Missing Values and Invalid Entries Calculation Method
- Data Missing in Cafe Sales were identifed as blanks, "ERROR" or "UNKNOWN". Invalid Entries are counted as missing values in this scenario.
- Total row count = 10,000
- In Excel, The following formulas were applied to each column.
   - To Count Blanks : =COUNTBLANK(A$2:A$10001) Counts Blanks
   - To count "ERROR" values: = COUNTIFS(A$2:A$10001,"ERROR") 
   - To count "UNKNOWN" values: = COUNTIFS(A$2:A$10001,"UNKNOWN")
   - Utilize values from the previous formulas and create a sum of values = SUM(A$10004,A$10006,A$10008) 
   - Use total row count and subtract from sum to obtain non-missing valid values count = 10000- A$10010 
   - Use total missing value or invalid data counts divided by total row count to obtain missing data percentage: =A$10010/10000 
    
### 🔍 Missing Value or Invalid Value Results 
  |Column Name | Count of Missing or Invalid Data| Percentage of Missing or Invalid Data|
  |------------|----------------------|---------------------------|
  | Transaction ID | 0 | 0%|
  |  Item | 969 | 9.69% |
  |  Quantity | 479 | 4.79% |
  |  Price per Unit | 533| 5.33%|
  | Total Spent | 502 | 5.01%|
  | Payment Method | 3178 | 31.78%|
  | Location | 3961 | 39.61%|
  | Date | 460 | 4.60%|

### 🔍 Reviewing Menu Items and their Prices 
- Our cafe sales contains items sold and the price per item.  
- Menu Items in Cafe:
  |Menu Item | Price for Item|
  |------------|----------------------|
  |Cookie| $1.00|
  |Tea| $1.50|
  |Coffee| $2.00 |
  |Cake| $3.00 |
  |Juice| $3.00|
  |Sandwhich| $4.00|
  |Smoothie| $4.00 |
  |Salad| $5.00|

  Menu Items and Prices Source: [Kaggle Cafe Sales](https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training/code)
  *Prices written in the menu table will just appear as a decimal in the csv file.*
  

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
- Missing Values: Multiple colummns contained blanks.
- Invalid Entries: Multiple columns contained values such "ERROR", "UNKNOWN". They were counted as Missing Values in this case.
- Price consistency: Prices for menu are consistent but may have missing values or invalid values.
---

## 🧠 Notes
Any additional thoughts before cleaning.

