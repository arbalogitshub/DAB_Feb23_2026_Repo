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
Prior to cleaning and analyzing the car sales dataset, I create a copy of data set for "backup" and then I create an empty sheet where I doucment my data cleaning process.

### Review the Original Data 
I usually prefer to start reviewig the columns and rows in our data set. In a seperate sheet (tab)  I wanted to explore the columns' data, and their data types, I 
obtained the columns' name, a sample of their data, the data type (Excel uses numbers to displya the data type), a customized column created with nested IF statements
to translate our data_type to plain English and a notes column. Below is a sample of how I documented the columns' data. 

| car_sales_columns  | sample_data      |  data_type    |  data_type_translation | notes                  |
|--------------------|------------------|---------------|------------------------|------------------------| 
| VIN                | 1HGBH41JXMN109186|     2         |         text           | This is our identifeir column|
| Make               | Nissan           |     2         | text                   | vehicle make                 | 

Next I would obtian the number of rows in the dataset, I used =COUNT(A2:A139) on the VIN column to identify 139 total rows in our dataset. 

### Identify Duplicates 
I utilized conditional formatiing that highlights duplicate values on our VIN column, and for a practice, I created a pivot table on the data, where I used the VIN column as the rows 
and for values, I utilized, COUNT of VIN to count the number of occurences each VIN has in the dataset. From there I used a COUNTIF() function to count the number of VINs that occurred more than once
and then based on that I identified two VINs that occurred more than once in the dataset. 

|<b>Duplicated VINs <b>| Occurences |
|----------------------|----------------------|
|2T1BURHE0JC054321     | 2|
|1HGBH41JXMN109186     | 2|

