-- Create cafe_sales table 
-- 10,000 Rows 
-- 26 Rows will be filtered out, due to being incomplete transaction sale.

CREATE TABLE IF NOT EXISTS  cafe_sales 
(
    transaction_id      INTEGER NOT NULL, 
    item    TEXT,
    item_type         TEXT,
    quantity_purchased        REAL,
    missing_quantity    INTEGER, -- 1= true, 2 = false
    price_per_unit    REAL,
    missing_price INTEGER, -- 1= true, 2 = false
    total_cost    REAL,
    missing_total_cost    INTEGER, -- 1= true, 2 = false
    payment_method    TEXT,
    location    TEXT,
    transaction_date    TEXT, -- YYYY-MM-DD format
    transaction_weekday TEXT ,
    transaction_month    TEXT,
    missing_date INTEGER-- 1= true, 2 = false
);


-- Data Validation using COUNT(*)
SELECT 
COUNT(*) FROM cafe_sales;

