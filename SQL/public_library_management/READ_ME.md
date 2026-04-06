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

## 🚀 Queries Included

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

## Discussion Questions
**Question 1)** In our library database, we track which branch a book was borrowed from, but books can exist at multiple branches. How would you modify the schema to track the actual inventory at each branch?

We can create either a new table called inventory where we could have information such as the following:
- copy_id: A unique serial number dedicated to the individual copy of a book. This can be served as our primary key
- book_id: This is the id number for a book (not an indivisual copy of a book) This can serve as the FOREIGN KEY to the books table.
- branch_id: This tells us which branch has this individual copy this could serve as our FOREIGN KEY to the branches table.
- status: status of a specific copy statuses such as the following:
  - 'Available' - Book is able to be checked out.
  - 'Loaned' - Books is loaned out.
  - 'Replacement Required' - Book is severely damaged or lost. 

Besides adding the new table we can make modifications to the other tables: 
- Books Table
  - Remove copies_owned from table
- Loans Table
  - Remove book_id from loans table, replace it with copy_id (FOREIGN KEY to inventory)

**Question 2)** Based on the provided data model, what business questions could library administrators answer using SQL queries that we haven't covered in our exercise?



**Question 3)** How would you extend this schema to track additional patron interactions, such as reserved books, late fees, or participation in library programs?
- Create a new table called reservations with the following information:
    - reservation_id int PRIMARY KEY,
    - patron_id, FOREIGN KEY to patrons table 
    - loan_id int FOREIGN KEY to loans table 
    - book_id int FOREIGN KEY to books table 
    - reserve_date TEXT (YYYY-MM-DD format): date of when book was reserved
    - expire_date TEXT (YYYY-MM-DD format): data of when reservation expires
- Create new table called fees which is about fee information like how much, why fee, fee payment status
  - fee_id integer primary key
  - loan_id integer foreign key to loans(loan_id)
  - patron_id integer foreing key to patrons (patron)
  - fee_amount decimal(10,2) : cost of fee to pay
  - fee_date TEXT (YYYY-MM-DD format): date of when fee has been charged
  - fee_status VARCHAR(55): textr value default 'unpaid'
  - fee_reason TEXT: reason for fee
- Create another table called payments. Information about the payments:
  - payment_id int PRIMARY KEY,
  - patron_id int FOREIGN KEY REFERENCES patrons (patron_id)
  - fee_id int FOREIGN KEY REFERENCES fees (fee_id)
  - amount decimal(10,2)
  - payment_date TEXT (YYYY-MM-DD format): Date of when fee was paid
  - payment_method VARCHAR(25) (cash, credit, check, debit)
  - reciept_number VARCHAR(25)
  - notes TEXT
 
  - Create another table called programs, 

**Question 4)** For tasks 1-3, how could you combine them into a single, more complex query that finds recent history books with multiple copies?

```sql
-- Discussion Question 4) Combine tasks 1-3 

-- All titles, published years after 2000 order by publication year newewst to oldest
-- Books with more than 5 copies owned in fiction genre_id = 1
-- All books with the word 'History' in title
SELECT 
    title,
    publication_year,
    copies_owned
FROM books 
WHERE 
     title LIKE ('%History%') 
     AND publication_year > 2000
     AND copies_owned > 5;
```

**Question 5)** What performance considerations should be kept in mind when running complex joins and aggregations on large library datasets?

- Select only the required columns, utilize proper JOIN types and filter the data appropiately
- Loans table should be broken down to multiple tables, each table dedicated to loans that occurred in a specific year. This is speed up time based queries because teh database will only scan loans that occur in a specific year.



