# Week 5 Workshop: SQL Online Music Store

A comprehensive SQL analysis project for a music streaming database, demonstrating various query techniques including filtering, joins, subqueries, and aggregations.

## Background
You've been hired as a data analyst for an online music store. The company has a database with information about their music catalog, customer purchases, and streaming statistics. 
Your task is to use SQL queries to extract meaningful insights from this data.

## 📋 Database Schema

The database consists of four main tables:
- **artists**: Artist details (artist_id, artist_name, genre, country, active_since)
- **songs**: Contains song information (song_id, title, artist_id, album, release_date, duration_seconds, popularity_score)
- **customers**: User information (customer_id, first_name, last_name, email, join_date, premium_member)
- **purchases**: Transaction records (purchase_id, customer_id, song_id, purchase_date, price)
- **streams**: Music streaming records (stream_id, customer_id, song_id, stream_date, stream_time)

## 🚀 Queries Included

### Basic Queries
1. **Basic Selection**: Retrieve 2022 songs ordered by release date (newest first).
2. **Filtering**: Find popular songs (>80 popularity) under 4 minutes (240 seconds).
3. **Pattern Matching**: Find all artists whose names start with "The".
4. **Multiple Conditions**: Find all remium customers who joined in 2022.
5. **Calculations and Aliasing**: Calculate the total duration (in minutes) of all songs in the database and display the result with an appropriate column name.
6. **Advanced Filtering**: Find the top 5 most expensive song purchases in the database.
7. **Using Multiple Tables Separately**:irst, find all song_ids from songs with a popularity score above 90. Then, use those song_ids to find purchases of those songs.
8. **Range Checking**: Find all purchases made between January 1, 2023 and March 31, 2023.
9. **Popularity Ranking**: Identify the songs with the highest popularity scores (above 90).
10. **Combined Query**: Popular short songs by artists starting with "The"

### Discussion Questions 
Question 1: In our database design, we separated purchases and streams into different tables. What are the benefits of this approach versus having a single "user_interactions" table?

- **Speed** : If we have have combined table that contains all data from purchases and streams table, Queries would take longer to run, more data = slower queries. In a real scenario, there would be billions of rows of streams and millions of purchase rows, if you wanted to write a query to pull only purchases from that user_interactions table, the data will have to deal with loading and filtering massive amounts of irrelevant data, causing a slowdown.

- **Schema Evolution** : Purchase data will often complex relationships such as (invoices,, payment methods, refunds, etc.) that eveolve differently from streaming data (that could have fields such as:  last stream,  playback, device info etc). With seperate tables we add new columns that are more specific to the purchase table without affecting the stream table. If we wanted to add more purchase related columns to a unified table then all "stream" rows would automatically have a NULL value for the newly addded purchases realted column and vice versa. That would create more unneccessary messy data.

- **Different Patterns**: Purchase data are often infrequent, transactional while streaming data have an incredibly high volumne per user. Streaming data are more focused on a time series and we only append data, we don't need to go back to stream to change certain data like purchases whenever they have a refund. In seperate tables, we can optimize for the two differnent patterns in seperated tables for better performance where as in a single table we would have to optimize for both patterns which would result in an suboptimal performance.

Question 2: Based on the provided data model, what business questions could music executives answer using SQL queries that we haven't covered in our exercise?
  	
   **For each artist, how many customers purchased their songs, How much money did each artist make from song purchases?**
   ```sql
-- For each artist, how many customers purchased their songs, How much money did each artist make from song purchases?
SELECT
    a.artist_name AS 'Artist',
    COUNT(p.purchase_id) AS 'Number of Customer Purchases',
    SUM(p.price) AS 'Total Amount'
FROM artists AS a 
LEFT JOIN songs AS s ON a.artist_id = s.artist_id 
LEFT JOIN purchases AS p ON s.song_id =p.song_id
GROUP BY a.artist_name
ORDER BY SUM(p.price) DESC;
   ```
**Obtain the number of music streams per genre.**
```sql
-- count the number streams of music per genre 
SELECT 
    a.genre AS 'Music Genre',
    COUNT(st.stream_id) AS 'Stream Count'
FROM artists AS a 
LEFT JOIN songs AS s ON a.artist_id = s.artist_id 
LEFT JOIN streams AS st ON s.song_id = st.stream_id
GROUP BY a.genre
ORDER BY COUNT(st.stream_id) DESC ;
 ``` 
**What's the most popular time of day customers stream their music?** 
 ```sql
-- What time of day does each customers stream their music the most? 
WITH cte1 AS  (
    SELECT 
        stream_id,
        customer_id,
        song_id,
        stream_date,
        stream_time,
        CASE 
             WHEN CAST(strftime('%H',  stream_time) AS INTEGER) BETWEEN 5 AND 11 THEN 'Morning'
             WHEN CAST(strftime('%H',  stream_time) AS INTEGER) BETWEEN 12 AND 13 THEN 'Noon'
             WHEN CAST(strftime('%H',  stream_time) AS INTEGER) BETWEEN 14 AND 16 THEN 'Afternoon'
             WHEN CAST(strftime('%H',  stream_time) AS INTEGER) BETWEEN 17 AND 20 THEN 'Evening'
             WHEN CAST(strftime('%H',  stream_time) AS INTEGER) BETWEEN 21 AND 23 THEN 'Night'
             ELSE 'Late Night'
         END AS  time_of_day
      FROM streams 
      ORDER BY customer_id
),
 -- Get Counts of streams and rank the counts 
cte2 AS (
    SELECT 
        customer_id,
        time_of_day,
        COUNT(*) AS  stream_count,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) AS rank
    FROM cte1
    GROUP BY customer_id, time_of_day
),

--  Find the most popular time of day to stream music for each customer
cte3 AS (
SELECT 
    customer_id,
    time_of_day,
    stream_count
FROM cte2
WHERE rank = 1
ORDER BY customer_id
) 

-- Find the most popular time of day to stream music overall.
SELECT 
    time_of_day AS 'Time of Day',
    COUNT(*) AS 'Count'
FROM cte3 
GROUP BY time_of_day
ORDER BY Count(*) DESC
 ```

5.	How would you extend this schema to track more detailed user behavior, such as when users skip songs or how much of a song they listen to before skipping?
I would consider in creating a another table, streams_detailed_interactions where we could have columns such the following:

- interaction_id (INTEGER PRIMARY KEY),
- stream_id (FOREGIN KEY REFERENCES stream_id FROM streams),
- customer_id(FOREGIN KEY REFERENCES customer_id FROM customers),
- song_id (FOREGIN KEY REFERENCES song_id FROM songs),
- song_duration_in_seconds (FOREGIN KEY REFERENCES song_id FROM songs),
- song_streamed_duration (INTEGER),
- song_interaction (TEXT) -> Categorical (Full Stream, Skip) 

Question 4:	For tasks 1-3, how could you combine them into a single, more complex query that finds popular short songs by artists whose names start with "The"?
   ```sql
   SELECT 
    a.artist_name AS 'Artist',
    s.title AS 'Song Title',
    s.popularity_score AS 'Popularity Score',
    s.duration_seconds AS 'Song Duration in Seconds'
FROM artists AS a
JOIN songs AS s ON a.artist_id = s.artist_id
WHERE 
    a.artist_name LIKE ('The%') 
    AND s.popularity_score > 80
ORDER BY s.popularity_score DESC, s.duration_seconds DESC;
 ```
  	
## 🛠️ Setup Instructions

### Prerequisites
- SQLite3 or any SQL database system
- Basic SQL knowledge

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/arbalogitshub/DAB_Feb23_2026_Repo.git
cd DAB_Feb23_2026_Repo/SQL/sql_online_music_store
