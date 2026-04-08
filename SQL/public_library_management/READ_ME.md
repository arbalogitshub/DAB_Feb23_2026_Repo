# Week 6 Workshop: SQL Public Library Management

A comprehensive SQL analysis project for a public library system, demonstrating various query techniques including filtering, joins, subqueries, and aggregations.

## Background
You've been hired as a data analyst for a public library system. The city's library network has multiple branches and serves thousands of patrons who borrow books regularly. The library director wants to better understand patron behavior, optimize the book collection, and improve services across all branches. Your task is to use SQL queries to extract meaningful insights from their database.


## 📋 Database Schema
The database consists of six tables:
- **branches**: Library Branch details (branch_id, branch_name, address, city, phone)
- **patrons**: Contains patron information (patron_id, first_name, last_name, email, address, city, registration_date, branch_id)
- **genres**: Genre information (genre_id, genre_name, description)
- **authors**: Author information (author_id, first_name, last_name, birth_year, country)
- **books**: Book information (book_id, title, author_id, genre_id, isbn, publication_year, copies_owned)
- **loans**: Book loan information (loan_id, book_id, patron_id, branch_id, checkout_date, due_date, return_date)


 ## Repo Structure
| File | Description |
|------|-------------|
| `library_management_tasks.sql` | SQL Queries that answer the Questions to Part 1 and Part 2 |
| `library_database_tables` | CREATE tables Queries for the library database|
| `READ_ME` | Information about the assigment, database schema, and repo structure of public_library_management repo.|
| `/library_management_data/` | CSV files containing the data used for this assignment|
|`Discussion_Questions` | A md file containing responses to the discussion questions


## 🚀 Queries Included (Please view SQL file to review answers)

### Part 1: Basic SQL Operations and JOIN Queries 
1. **Basic Selection**: Retrieve the titles and publication years of all books published after 2000, by publication year (newest first).
2. **Filtering**: Find all books with more than 5 copies owned in the fiction genre (genre_id = 1).
3. **Pattern Matching**: List all books whose titles contain the word "History".
4. **JOIN Operations**: Display loan information (loan_id, checkout_date, due_date) along with patron details (first_name, last_name, email) for all loans made in January 2023.
5. **Multi-table JOIN**: Show book details (title, author's full name, genre_name) for each loan, along with the checkout_date and due_date.
6. **Self-JOIN**: Find pairs of patrons who live in the same city. Show both patrons names and their city.
7. **Multi-table JOIN with filtering**: Find all fiction books (genre_id = 1) that have been borrowed, along with the patron name and the branch where they were borrowed from.

### Part 2: Aggregation and GROUP BY Operations
8. **COUNT aggregation**: Count the number of books in each genre category.
9. **Multiple aggregations**: Calculate the average, minimum, and maximum loan duration (days between checkout and return) for each library branch. Include only returned books.
10. **Conditional aggregation**: Find patrons with overdue books (due_date < CURRENT_DATE and return_date = ' '), along with the count of overdue books they have.
11. **Time-based analysis**: Analyze monthly borrowing trends. Show the year, month, number of loans, and number of unique patrons for each month.
