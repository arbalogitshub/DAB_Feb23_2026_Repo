# Analyzing Sales Data and Making Business Recommendations with Excel

## Description
In this workshop assignment, I work with a car sales dataset (car_sales_final.xlsx) provided by the Upright Data Analytics bootcamp, 
the main purpose of this project is to utilize the fundamental skills in Excel to perform the following: 

* Clean and prepare sales data for analysis
* Create visualizations to communicate findings effectively
* Develop business recommendations from your data insights
* Present your analysis to stakeholders

All documentat

## Prerequisites
* Excel Online or Excel
* car_sales_final.xlsx file

Note: This README will only contain snippets of tables, to view full table please review the "Documentation" worksheet in the file. 

## Data Exploration (Pre-cleaned Data)
Before cleaning the data, for best practice data analysts usually explore the data. I always create a copy of the original data set just to have as a backup copy in case of unexpected events.

### Review the Original Data 
I usually prefer to start reviewig the columns and rows in our data set. In a seperate sheet (tab)  I wanted to explore the columns' data, and their data types, I 
obtained the columns' name, a sample of their data, the data type (Excel uses numbers to displya the data type), a customized column created with nested IF statements
to translate our data_type to plain English and a notes column. Below is a sample of how I documented the columns' data. 

| car_sales_columns  | sample_data      |  data_type    |  data_type_translation | notes                  |
|--------------------|------------------|---------------|------------------------|------------------------| 
| VIN                | 1HGBH41JXMN109186|     2         |         text           | This is our identifeir column|
| Make               | Nissan           |     2         | text                   | vehicle make                 | 

Next I would obtain the number of rows in the dataset, I used =COUNT(A2:A139) on the VIN column to identify 139 total rows in our dataset. 

## Data Cleaning 
After reviewing the dataset, we can see we have the following: duplicated column values in VIN column, inconsistent formatting in multiple columns, and missing data values. The next few steps will be identifying and cleaning those issues before we start performing any analysis on the data.

### Identify and Handling Duplicates 
I utilized conditional formatiing that highlights duplicate values on our VIN column, and for a practice, I created a pivot table on the data, where I used the VIN column as the rows 
and for values, I utilized, COUNT of VIN to count the number of occurences each VIN has in the dataset. From there I used a COUNTIF() function to count the number of VINs that occurred more than once
and then based on that I identified two VINs that occurred more than once in the dataset. 

|<b>Duplicated VINs <b>| Occurences |
|----------------------|----------------------|
|2T1BURHE0JC054321     | 2|
|1HGBH41JXMN109186     | 2|

Since the available data is based on cars sold in 2024, I reviewed the duplicated VIN records. For VIN 1HGBH41JXMN109186, both rows contained identical information across all columns, so I removed one of the duplicates.

However, for VIN 2T1BURHE0JC054321, the duplicate rows were largely similar but differed in the vehicle’s model year, sale date, and price. Because it was not possible to determine which record was correct, I created a helper column called Data_Quality_Flag to label these entries as "VIN_conflict_model_year."

Due to the conflicting model year values (2021 vs. 2022) across otherwise identical records, I ultimately decided to exclude VIN 2T1BURHE0JC054321 from the dataset.

### Identify and Handling Missing Values 
We use COUNT() on VIN column to identify the number of rows we have in the dataset, next we use COUNTBLANK for the rest of the columns to identify how many missing values occur I neach column of the data set. So far, we have Model_Year, Customer_Name, Color, and Dealer Name to have 1 missing column, while Engine Size has 22 columuns (roughly 16% of the data in the column is missing.

Earlier I mention that I used COUNT() on the VIN column to identify our rows as our row count. Next I used COUNTBLANK() for each and every column in the dataset. For each column, I obtained the number of non-empty values per column minus the number of blank cells per column. I then used the results and divided that by the number of rows to obtain the percent of missing per column. 

To see the complete detailed table, please view Documentation sheet in project final.
|<b>Column <b>         | Missing Data Peercentage |
|----------------------|--------------------------|
|Customer_Name         | 1%|
|Dealer_Name                 | 1%|
|Model Year                 | 1%|
|Engine_Size                | 16%|

<b>Methods utlized to replace missing values for the following columns</b>: 
* <b>Customer_Name</b>: I replaced the missing values with "Name Unidentified".
* <b>Model_Year</b>: I replaced the missing value with an outlier "9999"
* <b>Dealer_Name</b>: Observed that dealer names are dependent on the vehicle make (e.g., Jeep → “Jeep Nation,” BMW → “BMW Elite”). For records with missing dealer names, I imputed the value based on the vehicle make; in this case, the Nissan entry was assigned the corresponding Nissan dealer name.
* <b>Engine_Size</b>: Most missing values (21 out of 22) corresponded to electric vehicles, with one associated with a hydrogen vehicle. Since these vehicle types do not have a conventional engine displacement, I imputed the missing values with 0 to indicate non-applicability. For this column, 0 = non-applicable for EV/hydrogen, not literal engine size


  




