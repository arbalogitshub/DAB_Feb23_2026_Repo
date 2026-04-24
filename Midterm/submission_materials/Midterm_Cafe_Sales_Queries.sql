-- Foreword: We need to filter out rows where missing_total_cost = 1. 
-- Queries involving date, we will filter out missing dates 
--This is to maintain  accuracy for our SQL Query Analysis


-- Exploratory Data Analysis Query #1
-- How many records will need to be filtered out?
-- Inner Query obtains all records where missing cost is TRUE 
-- Outer Query gets row counts based on the inner query
SELECT 
COUNT(*) AS 'Count of Records to be Filtered Out?'
FROM (
    SELECT    *
    FROM cafe_sales
    WHERE missing_total_cost <> 0
);

-- Exploratory Data Analysis Query #2
-- What food categories made more revenue : Food or Drinks ? 
-- Obtained the item_type, number of transactions made for the item_type, and sum of total_cost for each item_type.
SELECT
     item_type AS 'Food Type',
     COUNT(transaction_id) AS 'Number of Transactions',
     SUM(quantity_purchased) AS 'Total Quantity Sold',
     PRINTF("$%.2f", SUM(total_cost)) AS 'Total Revenue'
 FROM cafe_sales
WHERE missing_total_cost <> 1
GROUP BY item_type
ORDER BY SUM(quantity_purchased) DESC;

-- Exploratory Data Analysis Query #3
-- What is the maximum total cost per month? 
-- What is the minimum total cost per month? 
-- What is the average total cost per month?
-- missing total counts and missing dates are filtered out 
SELECT 
transaction_month AS 'Month',
PRINTF("$%.2f",MAX(total_cost))  AS 'MAX Total Cost' ,
PRINTF("$%.2f",MIN(total_cost))  AS 'MIN Total Cost' ,
PRINTF("$%.2f",AVG(total_cost))  AS 'AVG Total Cost' 
FROM cafe_sales 
WHERE missing_total_cost <> 1 AND missing_date <> 1
GROUP BY transaction_month
ORDER BY transaction_date;


-- Business Insights Queries # 1 
-- Cohort Analysis: Performance by Location
-- What's the total revenue per location ? 
-- What's the average total cost per location? 
-- Provide proportion of revenue from each location
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


-- Business Insights Queries # 2
-- Use CTE to create a monthly time series analysis 
-- obtain monthly total revenue, number of transaction per month, and monthly cumulative revenue
-- missing total counts and missing dates are filtered out 
WITH monthly_time_series AS (
    SELECT 
        transaction_month AS month,
        COUNT(*) AS number_of_transactions,
        PRINTF("$%.2f",SUM(total_cost))  AS monthly_revenue,
        SUM(SUM(total_cost)) OVER (ORDER BY STRFTIME('%Y-%m', transaction_date)) AS cumulative_revenue
    FROM cafe_sales
    WHERE missing_date <> 1 AND missing_total_cost<> 1 
    GROUP BY month
) 
SELECT 
    month,
    number_of_transactions,
    monthly_revenue,
    PRINTF("$%.2f",cumulative_revenue) AS cumulative_revenue
FROM monthly_time_series;

-- Business Insights Queries # 3
-- Use multiple CTE to identify most popular item per month based on total revenue
-- missing total counts and missing dates are filtered out 
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



    