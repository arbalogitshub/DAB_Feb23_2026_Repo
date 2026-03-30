/* 
1.Basic Selection: Retrieve titles, release dates from all songs released in 2022,
  Order release date by newest - oldest 

Use strftime('%Y') to extract year portion of release_date for WHERE clause
*/
SELECT 
    title AS 'Song Title', 
    release_date AS "Release Date"
FROM songs
WHERE strftime('%Y',release_date) = '2022' 
ORDER BY release_date DESC;

2.Filtering: Find all songs with popularity score > 80 and a duration less than 240 seconds

SELECT 
    title AS 'Song Title',
    popularity_score AS 'Popularity Score',
    duration_seconds 'Song Duration in Seconds'
FROM songs
WHERE 
    popularity_score > 80 AND 
    duration_seconds <240
ORDER BY popularity_score DESC, duration_seconds DESC;

-- 3. Pattern Matching: Find all artists whose names start with "The" 
SELECT 
    artist_id AS 'ID',
    artist_name AS 'Artist',
    genre AS 'Music Genre',
    country AS 'Artist Country',
    active_since AS 'Active Since'
FROM artists
WHERE artist_name LIKE ('The%');

-- 4. Multiple Conditions: Find all premium customers who joined in 2022
SELECT 
    customer_id AS 'ID',
    first_name || ' ' || last_name  AS 'Customer Name',
    join_date AS  'Join Date',
    premium_member AS 'Premium Member'
FROM customers
WHERE  
    strftime('%Y',join_date) = '2022' AND 
    premium_member != 'FALSE'
ORDER BY join_date;

/*
5. Calculations and Aliasing: Calculate the total duration in minutes of all songs in database
and display the result with an appropiate column name.
*/
SELECT 
    ROUND(SUM(duration_seconds)/60.00,2) AS 'Total Song Duration in Minutes'
FROM songs;

-- 6. Advanced Filtering: Find the top 5 most expensive song purchases in database
SELECT * FROM purchases ORDER BY price DESC LIMIT 5;

/* 
7. Using Multiple Tables Seperately: 
Retrieve all purchase records for highly popular songs
(popularity score greater than 90)
*/
SELECT *
FROM purchases
WHERE song_id IN (
            -- Subquery: Get IDs of songs with popularity score > 90
           SELECT song_id
           FROM songs
           WHERE popularity_score > 90
       )
;

-- 8. Range Checking: Find all purchases made from Jan1st 2023 - March 31st, 2023,
SELECT * FROM purchases 
WHERE purchase_date BETWEEN '2023-01-31' AND '2023-03-31'
ORDER BY purchase_date;

-- 9.Advanced Filtering with ORDER BY:  Identify the songs with the highest popularity scores (above 90).
SELECT
    song_id AS 'Song ID',
    title AS 'Song Title',
    popularity_score AS 'Popularity Score'
FROM songs 
WHERE popularity_score > 90
ORDER BY popularity_score DESC;


    
    


    
    
 
