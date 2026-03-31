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

## 🛠️ Setup Instructions

### Prerequisites
- SQLite3 or any SQL database system
- Basic SQL knowledge

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/arbalogitshub/DAB_Feb23_2026_Repo.git
cd DAB_Feb23_2026_Repo/SQL/sql_online_music_store
