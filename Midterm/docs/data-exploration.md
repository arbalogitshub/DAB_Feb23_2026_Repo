# 📊 Data Exploration Report (Pre Cleaning) 

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
⚠️ Original column names in Kaggle dataset have been altered/renamed for this project. Renamed columns will be referenced from here on out.
[Kaggle Cafe Sales Column Description Source](https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training)

<b> Cafe Sales Columns Details</b>
<img width="1579" height="265" alt="image" src="https://github.com/user-attachments/assets/3afa0aee-834c-4735-b403-10da7a2d10f8" />


---

## 🔍 Initial Observations
- Shape: 10K rows, 8 columns 
- Data contains missing values (blanks) and invalid entries ("ERROR") and unknown entries ("UNKNOWN)
   - Blanks are the true missing data since there is no value.
   - "ERROR" is treated as invalid entry due to the transaction logging system.
   - "UNKNOWN" is treated as a data value is well unknown; however, depending on other columns, there is a possiblity, we could figure out the unknown data value.

### 🧮 Identifying Missing Data Methods
- I will only consider only considering blanks as missing data.
- In Excel, The following formulas were applied to each column.
   - To Count Blanks : = COUNTBLANK(A$2:A$10001)
   - To Count Non-Blank Data: = COUNTA($A$2:$A$10001)
      - ⚠️ Non-Blank Data Count includes values with "ERROR" or "UNKNOWN"
   - To obtain Percentages of Non-Missing Data: Count Non-Blanks / Total Row Count
   - To obtain Percentages ofMissing Data: Count Blanks / Total Row Count

### 🔍 Missing Value Identification Results 		
<img width="954" height="265" alt="image" src="https://github.com/user-attachments/assets/a06c2a1f-0004-4a0a-98af-8a7a21fa508e" />


### Identifying Invalid and Unknown Data. 

### 🧮 Identifying Invalid and Unknown Data Methods
- "ERROR" AND "UNKNOWN" are considered to be invalid or unknown data.
- In Excel, The following formulas were applied to each column.
   - To count "ERROR" values: = COUNTIFS(A$2:A$10001,"ERROR") 
   - To count "UNKNOWN" values: = COUNTIFS(A$2:A$10001,"UNKNOWN")
   - To obtain Percentages of ERROR values : Count ERROR values / Count of Non-Missing Data
   - To obtain Percentages of UNKNOWN values : Count UNKNOWN values / Count of Non-Missing Data

### 🔍 Invalid and Unknown Data Results
- ⚠️ Non-Missing Data Counts exclude blanks.
- ⚠️ Valid Data Counts does not include counts of ERROR or UNKNOWN values.
- ⚠️ Valid Data Percent does not include proportion of ERROR or UNKNOWN values.
- ⚠️ Proportions were caluclated with only non-missing data.
<img width="793" height="697" alt="image" src="https://github.com/user-attachments/assets/96e26dbd-d935-468a-9d69-112fad8d8efd" />



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
  <br>*Prices written in the menu table will just appear as a decimal in the csv file.*
---

## 📊 Basic Exploration (Pre-Cleaning) 
- Pivot Table Value Counts for Categorical Columns:
- Item column value counts:
  | Item | Value Counts|
  |------------|----------------------|
  |Juice| 1171|
  |Coffee| 1165|
  |Salad| 1148|
  |Cake| 1139|
  |Sandwhich| 1131|
  |Smoothie| 1096|
  |Cookie| 1092|
  |Tea| 1089|
  |UNKNOWN|344|
  |ERROR|292|
  |blanks| 333|
- Payment_Method column value counts:
  | Payment_Method | Value Counts|
  |------------|----------------------|
  |Digital Wallet| 2291|
  |Credit Card| 2273|
  |Cash| 2258|
  |ERROR| 306|
  |UNKNOWN| 293|
  |blanks| 2579|
- Location column value counts:
  | Item | Value Counts|
  |------------|----------------------|
  |Takeaway| 3022|
  |In-store| 3017|
  |ERROR| 358|
  |UNKNOWN| 338|
  |blanks|3265|

---



---

## ⚠️ Data Quality Issues
- Missing Values: Multiple colummns contained blanks.
- Invalid Entries: Multiple columns contained values such "ERROR", "UNKNOWN". They were counted as Missing Values in this case.
- Price consistency: Prices for menu are consistent but may have missing values or invalid values.
- Date Formatting: transaction_date we need to make sure that transaction_date is in DATE data type, and reformat that column.

## Data Cleaning Plan 
- For Full details please review data-cleaning.md
---

#  📊 Data Exploration  (Post-Cleaning) 

## 🧾 Updated Column Descriptions

<img width="1975" height="541" alt="image" src="https://github.com/user-attachments/assets/b254cc44-76c3-4124-b5f2-a5c0b64f18de" />



## 🧠 Notes
- Need to reformat and rename columns.
- Initially renamed columns to make 
