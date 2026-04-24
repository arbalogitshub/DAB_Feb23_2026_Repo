# 🧮 Midterm Cafe Sales Analysis Report 

## 📌 Objective
State what exploratory data analysis and business query analysis questions the Queries can answer.

---

## 📊 Exploratory Data Analysis

<b>Exploratory Data Analysis Query #1</b>
- How many records will need to be filtered out?
- Inner Query obtains all records where missing cost is TRUE 
- Outer Query gets row counts based on the inner query

```sql
SELECT 
COUNT(*) AS 'Count of Records to be Filtered Out?'
FROM (
    SELECT    *
    FROM cafe_sales
    WHERE missing_total_cost <> 0
);
```
Sample Result: 
<img width="330" height="62" alt="exploratory data analysis m" src="https://github.com/user-attachments/assets/860200c7-a6bc-4cf3-a023-1b58870240d1" />

<b>Exploratory Data Analysis Query #2</b>
- What food categories made more revenue : Food or Drinks ? 
- Obtained the item_type, number of transactions made for the item_type, and sum of total_cost for each item_type

```sql
SELECT
     item_type AS 'Food Type',
     COUNT(transaction_id) AS 'Number of Transactions',
     SUM(quantity_purchased) AS 'Total Quantity Sold',
     PRINTF("$%.2f", SUM(total_cost)) AS 'Total Revenue'
 FROM cafe_sales
WHERE missing_total_cost <> 1
GROUP BY item_type
ORDER BY SUM(quantity_purchased) DESC;
);
```
Sample Result: 
<img width="610" height="103" alt="exploratory data analysis 1 " src="https://github.com/user-attachments/assets/db615418-2524-4e1f-88e2-064dc2b68014" />

<b>Exploratory Data Analysis Query #3</b>
- What is the maximum total cost per month? 
- Obtained the item_type, number of transactions made for the item_type, and sum of total_cost for each item_type
- What is the minimum total cost per month? 
- What is the average total cost per month?
- missing total counts and missing dates are filtered out
 
```sql
SELECT
     item_type AS 'Food Type',
     COUNT(transaction_id) AS 'Number of Transactions',
     SUM(quantity_purchased) AS 'Total Quantity Sold',
     PRINTF("$%.2f", SUM(total_cost)) AS 'Total Revenue'
 FROM cafe_sales
WHERE missing_total_cost <> 1
GROUP BY item_type
ORDER BY SUM(quantity_purchased) DESC;
);
```
Sample Result: 
<img width="520" height="332" alt="exploratory data analysis 3 " src="https://github.com/user-attachments/assets/55136982-250d-4624-b9b0-c366c7cd1d54" />

<b> Summary of Types of Exploratory Data Analysis Utilized</b> 
- Utilized Aggregate functions with GROUPBYs
- Utilized WHERE clause to filter out certain data
- Utilized ORDER BY to view query results in organized manner.
---
## :briefcase: Business Query Analysis 

<b>Business Insights Queries #1 Cohort Analysis: Performance by Location </b>
- What's the total revenue per location ? 
- What's the average total cost per location? 
- Provide proportion of revenue from each location

```sql
SELECT 
    location,
    COUNT(*) AS number_of_transactions,
    PRINTF("$%.2f",SUM(total_cost))AS total_revenue,
    PRINTF("$%.2f",AVG(total_cost)) AS avg_cost_per_transaction,
    ROUND(
        SUM(total_cost) * 100.0 / SUM(SUM(total_cost)) OVER (), 
        2
    ) AS revenue_percentage
FROM cafe_sales
WHERE missing_total_cost <> 1
GROUP BY location;
```
Sample Result: 

<img width="815" height="106" alt="business query 1" src="https://github.com/user-attachments/assets/793c2f1c-077e-4cf8-b329-e6b6de6fa401" />

<b>Business Insights Queries #2 Monthly Time Series Analysis</b>
- Use CTE to create a monthly time series analysis 
- Obtain monthly total revenue, number of transaction per month, and monthly cumulative revenue
- Missing total counts and missing dates are filtered out 

```sql
SELECT 
    location,
    COUNT(*) AS number_of_transactions,
    PRINTF("$%.2f",SUM(total_cost))AS total_revenue,
    PRINTF("$%.2f",AVG(total_cost)) AS avg_cost_per_transaction,
    ROUND(
        SUM(total_cost) * 100.0 / SUM(SUM(total_cost)) OVER (), 
        2
    ) AS revenue_percentage
FROM cafe_sales
WHERE missing_total_cost <> 1
GROUP BY location;
```
Sample Result: 

<img width="656" height="333" alt="business query 2" src="https://github.com/user-attachments/assets/f4ee6e38-f87c-4944-9bd6-84fa6aac73e6" />

<b>Business Insights Queries #3 Identify Most Popular Item </b>
- Use multiple CTE to identify most popular item per month based on total revenue
- Missing total counts and missing dates are filtered out 

```sql
WITH monthly_item_sales AS (
    SELECT 
        transaction_month AS month,
        item,
        SUM(total_cost) AS total_revenue
    FROM cafe_sales
    WHERE missing_date <> 1 AND missing_total_cost <> 1
    GROUP BY month, item
),
ranked_items AS (
    SELECT 
        month,
        item,
        total_revenue,
        RANK() OVER (
            PARTITION BY month
            ORDER BY total_revenue DESC
        ) AS rank_in_month
    FROM monthly_item_sales
)
SELECT 
    month,
    item,
    total_revenue
FROM ranked_items
WHERE rank_in_month = 1
ORDER BY month
```
Sample Result: 

<img width="323" height="332" alt="business query 3" src="https://github.com/user-attachments/assets/61ccaab3-a7bb-4fcf-b63a-5bf85a9e5ea8" />

<b> Summary of Types of Business Query Analysis Utilized</b> 
- Time-Series Analysis 
- Cohort Analysis 
- Product Rankings based on total revenue.

### 🔎 :mag_right: Top Business Insights 
- Data Quality needs some improvement
    - Location column: Majority of transactions and Most contirbuted to overall cafe total revenue.
    - Missing Dates data had to be filtered out for the sake of analysis 
- No consistent growth trend, January starts very strong but has a very hard dive in sales in Feburary. Sales over the month fail to surpass the total revenue occurred in January.
- Weakest months at start (Feburary 2023) and end of year (December 2023), possibly due to post-holiday slowdowns and year-end slumps.
- Majority of year salads were the top seller of the month all except for July 

### Pargraph
The analysis highlights several important insights that can directly inform business decisions. First, data quality requires improvement—particularly in the location column, which, despite containing the majority of transactions and contributing the most to overall café revenue, may not be fully reliable due to inconsistencies. Additionally, missing date values had to be excluded, which suggests that strengthening data collection processes should be a priority to ensure more accurate future analysis. From a performance standpoint, there is no consistent growth trend throughout the year: January begins with strong sales, but February experiences a sharp decline, and no subsequent month surpasses January’s revenue. This pattern indicates a need to investigate what drove January’s success—such as promotions, seasonality, or customer behavior—and determine how to replicate it in other months. The weakest periods, February and December, may reflect post-holiday slowdowns and end-of-year fatigue, signaling opportunities for targeted promotions or campaigns during these dips to stabilize revenue. Lastly, salads dominate as the top-selling item for most of the year, except in July, suggesting a strong and consistent customer preference. This insight can guide menu optimization, inventory planning, and marketing strategies, while also prompting further analysis into why July deviates—potentially revealing seasonal shifts in demand that the business can better capitalize on.


