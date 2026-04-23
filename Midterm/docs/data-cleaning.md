# 🧹 Data Cleaning Report

## 📌 Objective
Explain what cleaning was required and why.

---
## :white_check_mark: What Has Been Completed Already.
- Review the following information in docs/data-cleaning.md 
- Renamed raw cafe sales columns.
- Obtain count of missing data (blanks).
- Obtain counts of unknown or invalid data ("UNKNOWN" or "ERROR").
- Identified Duplicated Rows (None were found).



## 🔄 Cleaning Steps

### 1. Rename Columns 
- Replaced spaces with "_".
- All column names are now lowercase in dataset.
- A few columns were renamed to avoid confusion example: "Total Price" renamed to "total_cost" and "Quantity" to "quantity_purchased"
---

### 2. Removing Duplicate
- Method used: None
- Columns were duplicated are concerning: transaction_id
- Number of duplicates found: 0
  - Utilized conditional formatting to highlight duplicates in column
  - Verified no duplicates were found using Excel formula : = COUNTA(UNIQUE($A$2:$A$10001))
---
### 3. Handling Missing Values
- To view missing data values counts and missing data proportions , please review: docs/data-exploration.md
- Recall total row count: 10000

##### Missing Categorical Data Methods
- **Columns affected**: `location`, `payment_method`, `item`

- **Initial cleaning step**:  
  Replaced `"ERROR"` and `"UNKNOWN"` entries with blanks to standardize missing values.  
  *(Note: formula used — `=IF(ISBLANK(A1), NULL, A1)`)*

- **Imputation strategies**:

  - **`location`**  
    39.61% (n = 3,265) of values were missing or invalid. Since no other columns provided reliable indicators to distinguish between `"Take-away"` and `"In-store"`, all missing values were labeled as `"Unknown"`.

  - **`payment_method`**  
    31.78% (n = 3,178) of values were missing or invalid. Because no supporting data could accurately infer the correct category, missing values were labeled as `"Unknown"`.

  - **`item`**  
    Missing values were first cross-referenced with a secondary menu worksheet using `price` as a key:  
    `=IF(ISBLANK(B2), IFERROR(INDEX(menu!A:A, MATCH(F2, menu!B:B, 0)), ""), B2)`  

    For remaining blanks:  
    - If `price_per_unit = $3`, values were labeled `"Cake or Juice"`  
    - If `price_per_unit = $4`, values were labeled `"Sandwich or Smoothie"`  

    This approach uses `price` as a proxy to group possible items rather than assigning a single specific item, helping reduce the risk of incorrect assumptions.  

    If both `price` and related fields (`quantity_purchased`, `total_cost`) were missing, the item was labeled as `"Unknown"`.
 
 ##### Missing Numeric Data Methods
- **Columns affected**: `price_per_unit`, `quantity_purchased`, `total_cost`

- **Initial cleaning step**:  
  Replaced `"ERROR"` and `"UNKNOWN"` entries with blanks to standardize missing values.  
  *(Note: formula used — `=IF(ISBLANK(A1), NULL, A1)`)*

- **Imputation strategies**:

  - 





---

### 4. Standardizing Formats

- **Dates**: `transaction_date`
  - Converted `transaction_date` from `"MM/DD/YYYY"` format to `"YYYY-MM-DD"` format since I will later import the clean data file into SQLite Studio.

- **Text categories**: `item`, `item_type`, `payment_method`, `location`, `transaction_weekday`, `transaction_month`
  - All text values in these categories are converted to title format (first letter capitalized, remaining letters until a space are lowercase).

- **Numeric conversions**: `price_per_unit`, `total_cost`
  - Numeric format is `#.##` (two decimal places).
  
---

### 5. Feature Engineering

<img width="989" height="241" alt="image" src="https://github.com/user-attachments/assets/0f59ddb2-a876-4189-8ecc-9b63e84a6d30" />
---

### 6. Outlier Handling (if applicable)
- Method used:
- Impact on dataset:

---

## 📊 Final Cleaned Dataset Summary
- Final rows:
- Final columns:
- Key changes made:


---

## ⚠️ Assumptions
- Assumption 1
- Assumption 2

---

## 🧠 Notes
Any challenges or decisions worth mentioning.
