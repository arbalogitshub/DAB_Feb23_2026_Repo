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
- Naming Convention: All lowercase values, spaces were replaced by "_"
---

### 2. Removing Duplicate
- Method used: None
- Columns were duplicated are concerning: transaction_id
- Number of duplicates found: 0
  - Utilized conditional formatting to highlight duplicates in column
  - Verified no duplicates were found using Excel formula : = COUNTA(UNIQUE($A$2:$A$10001))
---
### 3. Handling Missing Values
- To view missing data values counts, please review: docs/data-cleaning.md
- Columns affected:
- Strategy used (drop, fill, impute):

---

### 4. Standardizing Formats
- Dates:
- Text categories:
- Numeric conversions:


---

### 5. Feature Engineering
- New columns created:
- Why they were added:

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
