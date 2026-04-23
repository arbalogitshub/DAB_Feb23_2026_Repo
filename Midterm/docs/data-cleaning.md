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
- A few columns were renamed to avoid confusion example: "Total price_per_unit" renamed to "total_cost" and "Quantity" to "quantity_purchased"
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

  - **`item`**<br>
  31.78% (n = 3,178) of values were missing or invalid. 
    Missing values were first cross-referenced with a secondary menu worksheet using `price_per_unit` as a key:  
    `=IF(ISBLANK(B2), IFERROR(INDEX(menu!A:A, MATCH(F2, menu!B:B, 0)), ""), B2)`  

    For remaining blanks:  
    - If `price_per_unit = $3`, values were labeled `"Cake or Juice"`  
    - If `price_per_unit = $4`, values were labeled `"Sandwich or Smoothie"`  

    This approach uses `price_per_unit` as a proxy to group possible items rather than assigning a single specific item, helping reduce the risk of incorrect assumptions.  

    If both `price_per_unit` and related fields (`quantity_purchased`, `total_cost`) were still missing, the item was labeled as `"Unknown"`.
 
 ##### Missing Numeric Data Methods
- **Columns affected**: `price_per_unit_per_unit`, `quantity_purchased`, `total_cost`
- **Assumptions**:
  Blanks in numeric data columns does not = 0 and will not be replaced by 0.
- **Initial cleaning step**:  
  Replaced `"ERROR"` and `"UNKNOWN"` entries with blanks to standardize missing values.  
  *(Note: formula used — `=IF(ISBLANK(A1), NULL, A1)`)*

- **Imputation strategies**:

  -  **`price_per_unit`**
    3.33% (n = 333) of values were missing or invalid. 
    Missing values were first cross-referenced with a secondary menu worksheet using `item` as a key:  
    `=IF(ISBLANK(F2), IFERROR(INDEX(menu2!A:A, MATCH(F2, menu!B:B, 0)), ""), F2)`

    For remaining blanks:  
    - If `price_per_unit` could not be determined due to `quantity_purchased` , `total_cost` , `item`, `price_per_unit` being blank, then `price_per_unit` was left blank. 
    - If `price_per_unit_per_unit`, can be determined, then filled in we imputed based on the other columns: `quantity_purchased` , `total_cost` , `item`
    - If `item` is `"Unknown"` and `quantity_purchased` , `total_cost` were left missing, then `price_per_unit` was left blank.

 -  **`quantity_purchased`**<br>
   4.79% (n = 479) of data was missing or invalid.
   Missing values were first filled in if I knew the values found in `total_cost` and `price_per_unit`.  I then did `total_cost/price_per_unit` to obtain `quantity_purchased`.

 For remaining blanks: 
 - For any reason `quantity_purchased` remained blank if `total_cost` and `price_per_unit` were also blank.
  
 -  **`total_cost`**<br>
  5.02% (n = 502) of data was missing or invalid.
   Missing values were first filled in if I knew the values found in `quantity_purchased` and `price_per_unit`.  I then did `total_cost * price_per_unit` to obtain `quantity_purchased`.

 For remaining blanks: 
 - For any reason `quantity_purchased` remained blank if `total_cost` and `price_per_unit` were also blank.
  
 ##### Missing Date Data Methods
- **Columns affected**: `transaction_date`
- **Assumptions**:
  Blanks dates are left as blank dates 
- **Initial cleaning step**:  
  Replaced `"ERROR"` and `"UNKNOWN"` entries with blanks to standardize missing values.  
  *(Note: formula used — `=IF(ISBLANK(A1), NULL, A1)`)*

**Imputation strategies**:
  - **`transaction_date`**  
    4.6% (n = 460) of values were missing or invalid. Since no other columns provided information to help us deduce the missing date, I made the choice of leaving transaction_date blank
---

### 4. Standardizing Formats

- **Dates**: `transaction_date`
  - Converted `transaction_date` from `"MM/DD/YYYY"` format to `"YYYY-MM-DD"` format since I will later import the clean data file into SQLite Studio.

- **Text categories**: `item`, `item_type`, `payment_method`, `location`, `transaction_weekday`, `transaction_month`
  - All text values in these categories are converted to title format (first letter capitalized, remaining letters until a space are lowercase).

- **Numeric conversions**: `price_per_unit_per_unit`, `total_cost`
  - Numeric format is `#.##` (two decimal places).
  
---

### 5. Feature Engineering

- `missing_total_cost`: IF missing_quantity OR missing_price = 1 THEN 1 ELSE 0 
- `missing_quantity`: `=IF(ISBLANK(J2), 1, 0)`
- `missing_price`: `=IF(ISBLANK(J2), 1, 0)`
- `missing_date`: `=IF(ISBLANK(J2), 1, 0)`
- `transaction_weekday`: `=TEXT(A1, "dddd")`
- `transaction_month`: `=TEXT(A1, "mmmm")`
- `item_type`: `=IF(OR(A1="Cookie", A1="Sandwich", A1="Cake", A1="Salad"), "Food", IF(OR(A1="Juice", A1="Tea", A1="Coffee", A1="Smoothie"), "Drink", "Unknown"))`

`transaction_weekday` and `transaction_month` have missing data, were intentionally left blank.

New Features, Value Counts, 
<img width="708" height="385" alt="image" src="https://github.com/user-attachments/assets/7614d4ba-21c0-4f78-a299-37f7073770e7" />

---

## 📊 Final Cleaned Dataset Summary
- Final rows: 10,0000
- Final columns: 15
- Key changes made:
  - No rows eliminated.
  - 7 new columns added to the dataset.
    - 3 columns are new columns made for analytical purposes.
    - 4 columns created to flag for missing data in several columns.
---

## ⚠️ Assumptions
- columns that start with "missing%" are numeric in file but are treated like boolean values 1 = TRUE, 0 = FALSE.
- For analytical and visual purposes, We will filter out certain rows, n counts will be changed

---

## 🧠 Notes
- Next time, Create a new feature that flags missing columns first... saves a lot of time.
- We may need to VIEW in SQL to reuse for filtering data 
