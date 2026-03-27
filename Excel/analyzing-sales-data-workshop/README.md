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

Next I would obtain the number of rows in the dataset, I used =COUNT(A2:A139) on the VIN column to identify 138 total rows (headers not included) in our dataset. 

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
Now we have 137 total rows (non header rows).

### Identify and Handling Missing Values 
We use COUNT() on VIN column to identify the number of rows we have in the dataset, next we use COUNTBLANK for the rest of the columns to identify how many missing values occur I neach column of the data set. So far, we have Model_Year, Customer_Name, Color, and Dealer Name to have 1 missing column, while Engine Size has 22 columuns (roughly 16% of the data in the column is missing.

Earlier I mention that I used COUNT() on the VIN column to identify our rows as our row count. Next I used COUNTBLANK() for each and every column in the dataset. For each column, I obtained the number of non-empty values per column minus the number of blank cells per column. I then used the results and divided that by the number of rows to obtain the percent of missing per column. 

To see the complete detailed table, please view Documentation sheet in project final.
|<b>Column <b>         | Missing Data Peercentage |
|----------------------|--------------------------|
|Customer_Name         | 1%|
|Dealer_Name                 | 1%|
|Model_Year                 | 1%|
|Color             | 1%|
|Engine_Size                | 16%|

<b>Methods utlized to replace missing values for the following columns</b>: 
* <b>Customer_Name</b>: I replaced the missing values with "Name Unidentified".
* <b>Model_Year</b>: I replaced the missing value, 0 = non-applicable for Model_Year, not literal the literal year 0. 
* <b>Dealer_Name</b>: Observed that dealer names are dependent on the vehicle make (e.g., Jeep → “Jeep Nation,” BMW → “BMW Elite”). For records with missing dealer names, I imputed the value based on the vehicle make; in this case, the Nissan entry was assigned the corresponding Nissan dealer name.
* Color: I replaced the missing value with "Color Unidentified".
* <b>Engine_Size</b>: Most missing values (21 out of 22) corresponded to electric vehicles, with one associated with a hydrogen vehicle. Since these vehicle types do not have a conventional engine displacement, I imputed the missing values with 0 to indicate non-applicability. For this column, 0 = non-applicable for EV/hydrogen, not literal engine size.

### Data Formatting: 
Several columns required data formatting such as the following: 
* Customer_Name, Dealer_Name, Make, Dealer_Region, Vehicle_Category: I utilized =PROPER(TRIM()) formula and included a nIF statement when formatting Make and Dealer_Name and correct spelling mistakes. 
* Sale_Price_Segment: I made several changes:
  * I replaced "Over $130K" with "At least $130K or More" my reason is because we didn't have a sales_price_segment for any sales that may occur to be $130K so I decided to change it to include $130 and up for the revised_Price_Segement
  * We had values such as "Under $25,000", "Under $25,001", I replaced the two values with "Under $25K"
  * For the "$25KÂ–$39.9K", "$40KÂ–$59.9K" "$60KÂ–$89.9K" and "$90KÂ–$129.9K I made sure to remove "Â"
* Fuel_Type: I utilized = PROPER(TRIM()) and corrected any spelling mistakes.
* Sales_Price: I formatted the data to U.S. currency (decimals included).

## Data Analysis & Visualization 

### Analytical Summaries 

<b>Pivot Table: Total Sales by Vehicle Category</b>

<img width="456" height="169" alt="image" src="https://github.com/user-attachments/assets/fd7da180-81c2-4e42-af69-a24dacf67d94" />

The highest sales per vehicle category in 2024 were the SUVs ($2,433,600), while the lowest sales were from Vans ($199,501).


<b>Pivot Table: Quarter Total Sales Per Quarter/ Total Sales per Month</b>

<img width="431" height="433" alt="image" src="https://github.com/user-attachments/assets/8ae32b2e-32ac-4457-9a64-72b57e3d6040" />

The following insights can be drawn the the table above: 
* The highest monthly sales in 2024 occurred in December ($895,000), while the lowest were in January ($24,500).
* The fourth quarter (Q4) recorded the highest quarterly sales ($2,181,300), while the first quarter (Q1) had the lowest ($554,600).
* The second half of 2024 (Q3 + Q4) generated approximately 2.13× more revenue than the first half (Q1 + Q2), highlighting a strong back-half performance.
This pattern shows strong seasonality, with sales increasing significantly toward the end of the year.


<b>Pivot Table: Regions	Total Sales per Region </b>

<img width="432" height="145" alt="image" src="https://github.com/user-attachments/assets/4efd8fb0-e91e-4aa4-81dc-09665c9d1011" />

The highest sales per dealership region in 2024 was the Western region ($2,373,601), while the lowest were from the Midwestern region ($1,248,001)

<b>Key Automotive Metrics:</b>
* Total Vehicle Sales: $6,154,502.00
* Average Selling Price by Model: $46,028.48
* Average Selling Price by Make: $48,675.19
* Best Selling Vehicle Category: SUV ($2,433,600)
* Lowest Seeling Vehicle Category: Van ($199,501)

### Car Sales Visualizations 
<b> Bar Chart Total Sales by Make </b> 

<img width="800" height="499" alt="image" src="https://github.com/user-attachments/assets/23ac6bc0-70c4-47ea-8a0d-08ed645237b5" />

* Bar Chart shows that Tesla made the most sales ($1,160,500).
* Honda ($554,300) had made the least amount of sales.

<b> Line Chart 2024 Quarterly Sales Trend </b>
 
 <img width="798" height="452" alt="image" src="https://github.com/user-attachments/assets/eec9f81a-81a1-4bde-adfd-6e22b286dfad" />

 * Overall we can see sales increasing, especially in the second half (Q3 + Q4) of 2024.

<b> Pie Chart: Market Share by Vehicle Make </b> 

<img width="752" height="452" alt="image" src="https://github.com/user-attachments/assets/79fc526c-14d4-4f48-b35e-bfa0f3555a09" />

For Vehicle Category, most of the sales were attributed to the SUV. 

<b> Complex Chart </b> 
This chart shows the realtionship between a vehicle's mileage and its sales price.

<img width="828" height="529" alt="image" src="https://github.com/user-attachments/assets/ebf4fb7f-43a4-47c6-b914-82c8788fb33f" />

This chart shows the relationship between a vehicle’s mileage and its sales price after removing extreme outliers.
<img width="828" height="499" alt="image" src="https://github.com/user-attachments/assets/0a9df673-8b14-4900-adce-78dc669fa234" />

Both Charts show that there is a mild negative realtionship between mileage and vehicle price. To make the first graph clearer, I focused on the most representative data points. I removed sales prices that were unusually high or low (outliers), which were identified using a standard statistical method (the Interquartile Range) to ensure the remaining data better reflects typical trends. Despite removing the outliers, the chart still shows that mileage alone is not a strong predictor of pricing. 

## Business Recommdendations 

### Identify Key Trends 
<b>Which vehicle makes and models are performing best/worst? </b> 
* Best Performing Make/Model: Tesla Roadster 2.0 ($199,900).
* Worst Performing Make/Model: Chevloret Spark ($16,500).

<b> Are there seasonal patterns in car buying behavior?</b>
* Yes, In the second half of 2024 Quarters 3 and 4 accumalted a total of $4,191,301 while the first half only accumalted $1,963,201, this shows a strong seasonal pattern where sales increase near the end of the year.

### Spot Patterns Across Vehicle Categories
<b> Are certain vehicle types (SUVs, sedans, electric vehicles) growing faster? </b> 
* SUVs were the top sold vehicles in 2024 with ($2,433,600).

<b> Is there a shift in consumer preferences for certain fuel types? </b> 
* Overall, we can see customers having a preference for Gasoline type vehicles.
<img width="432" height="145" alt="image" src="https://github.com/user-attachments/assets/47abb929-fed6-4932-a2ed-5a6014e060a2" />

<b> Are premium models performing differently than economy models? </b> 
Yes,

### Actionable Automotive Business Recommendations
#### Inventory optimization strategies based on sales patterns
<b>Supporting Data:</b> 
* SUVs generated $2.43 million (best category sales).
* Vans generated only $199K (worst category sales) .
* Strong Quarter 3 - Quarter 4 demand surge (2.13x higher than first half of 2024).

<b>Recommendations:</b> 
* Increase SUV inventory prior to the start of the third quarter.
* Reduce van inventory due to low demand.
* With higher sales in quarters 3 and 4, increase inventory/stock prior near the end of the second quarter.

#### Pricing recommendations for specific vehicle segments
<b>Supporting Data:</b> 
* Average selling price ranges from $46K - $48K.
* Premium model (Tesla Roadster 2.0) perofrms strongly at $199K
* Weak Correlation between vehicle mileage and sales price meaning prices are not strongly driven by car mileage.
* Strong Quarter 3 - Quarter 4 demand surge (2.13x higher than first half of 2024).

<b>Recommendations:</b> 
* Maintain pricing for high demand vehicles of expensive brands (e.g. Tesla), Data showed strong sales despite the high price.
* Low-performing sales such as Vans should obtain small discounts to asisst in clearing the inventory
* Don't emphazie vehicle mileage as a primary indicator for pricing, consider other factors such as fuel type, make, model, year.

#### Marketing campaign focus areas based on high-potential vehicle categories
<b>Supporting Data:</b> 
* SUVs = highest revenue category
* Tesla = top-performing brand ($1.16M)
* Gasoline vehicles still dominate preference

<b>Recommendations:</b> 
* Allocate most of marketing budget to SUVs, highlight practicality, family use and versatility.
* Run premium brand campaign ads around Tesla and similar high end vehicles, focus on inoovation, performance and status
* Segment campaigns by fuel types: Gas types for reliability & familiarity, Electric Vehicles for cost savings & sustainability.

#### Seasonal promotion strategies aligned with buying patterns
<b>Supporting Data:</b> 
* Quarter 4: $2.18M (best quarter in sales) 
* December: $895K Best Selling Month
* Quarter 1: Weakest Quarterly Sales

<b>Recommendations:</b> 
* Increase or Implement aggressive promitions in Quarter 4 via holiday sales events, year end clearance sales
* Have invetory ready no later Quarter 3
* Compensate Quarter 1 sales with disounts, trade in bonueses, or deals 

#### Sales team resource allocation based on regional performance
<b>Supporting Data:</b> 
* West region = $2.37M (best performing region)
* Midwest = $1.25M (worst performing region)

<b>Recommendations:</b> 
* Allocate top-performing car sales person to the Western region for maximum revenue opporunity
* Increase staffing during third and fourth quarters in higher performing regions to match demand
  surge.
* Introduce performance-basd incentives for region and season.

  ### Key TakeAway:
  1. Invest more on SUVs since they are the best selling vehicle category
  2. Exploit Quarter 4 season the highest sales period
  3. Keep premium pricing for high end supports since demand supports it
  4. Cut losses on vans
  5. Allocate resources to western region during peak months.



  




