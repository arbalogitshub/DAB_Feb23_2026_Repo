-- Part 1 : Basic SQL Operations and JOIN Queries

-- Question 1) Basic Selection: Retrieve titles of all books published after 2000, order by publication year (newest to oldest)
SELECT 
    title AS 'Title',
    publication_year AS 'Publication Year'
FROM books 
WHERE publication_year > 2000
ORDER BY publication_year DESC;

-- Question 2) Filtering: Find all books with more than 5 copies owned in the fiction genre 
SELECT 
    title AS 'Book Title',
    copies_owned AS 'Copies Owned'
FROM books
WHERE copies_owned > 5
ORDER BY copies_owned DESC, title;

-- Question 3) Pattern Matching: List all books whose titles contain the word History
SELECT 
    title AS 'Book Title'
FROM books
WHERE title LIKE ('%History%') 
ORDER BY title;

-- Question 4) JOIN Operations: Display loan information and patron details for all loans made in Jan 2023 
SELECT 
    l.loan_id,
    l.checkout_date,
    l.due_date,
    p.first_name,
    p.last_name,
    p.email
FROM loans l 
INNER JOIN patrons p ON l.patron_id = p.patron_id
WHERE 
    strftime( '%Y',l.checkout_date) = '2023'
     AND strftime( '%m',l.checkout_date) = '01';


-- Question 5) Multi-table JOIN: Show book details for each loan along with checkout and due dates
SELECT 
    b.title AS 'Book Title',
    a.first_name || ' ' || a.last_name AS 'Author',
    g.genre_name AS 'Genre',
    
     l. checkout_date AS 'Checkout Date',
     l.due_date AS 'Due Date'
FROM books AS b
INNER JOIN authors AS a 
    ON b.author_id = a.author_id
INNER JOIN genres AS g 
    ON b.genre_id = g.genre_id
INNER JOIN loans AS l
    ON b.book_id = l.book_id;
    
-- Question 6) Self JOIN:  Find pairs of patrongs who live in the same city. Show both patron's names and in their city

-- Added WHERE clause in my query to not include rows where  patron_person_1 and patron_person_2 are the same person
SELECT 
    p1.first_name || ' ' || p1.last_name AS patron_person_1,
    p2.first_name || ' ' || p2.last_name AS patron_person_2,
    p1.city AS 'City'
FROM patrons AS p1
INNER JOIN patrons AS p2
    ON p1.city = p2.city 

WHERE  p1.first_name || ' ' || p1.last_name  <>   p2.first_name || ' ' || p2.last_name
ORDER BY p1.city;

-- Question 7) Multi-table JOIN w/ filtering: Find all fiction books that have been borrowed along with every patron and branch 
SELECT 
    b.title AS 'Book',
    p.first_name || ' ' || p.last_name AS 'Patron Full Name',
    br.branch_name AS 'Branch'
FROM books AS b
INNER JOIN loans AS l 
    ON b.book_id = l.book_id
INNER JOIN patrons AS p
    ON l.branch_id = p.branch_id
INNER JOIN branches AS br 
    ON p.branch_id = br.branch_id
WHERE b.genre_id = 1
ORDER BY b.title, br.branch_name;

-- PART 2: Aggregation and GROUP BY Operations

-- Question 8) COUNT aggregation: COUNT the number of books in each genre category
SELECT 
    g.genre_name AS 'Genre',
    COUNT(b.title) AS 'Total Books in Genre'
FROM genres AS g 
INNER JOIN books AS b 
    ON g.genre_id = b.genre_id 
GROUP BY g.genre_name
ORDER BY COUNT(b.title) DESC;
    

-- Question 9) Multiple Aggregations: Calculate the avg, min, and max loan duration for each library branch, only inlcude returned books

-- Uses julianday to get difference of dates in days
-- return_date, and checkout_date are text data types, I used  NOT LIKE '' to filter out return dates without a return date
SELECT 
    branch_id AS 'Branch ID',
    ROUND(AVG(julianday(return_date) - julianday(checkout_date)),2) AS 'Avg Loan Duration in Days',
    MIN(julianday(return_date) - julianday(checkout_date)) AS 'Min Loan Duration in Days',
    MAX(julianday(return_date) - julianday(checkout_date)) AS 'Max Loan Duration in Days'
FROM loans
WHERE return_date NOT LIKE ''
GROUP BY branch_id;

-- Question 10) Conditional Aggregation: Find patrons with overdue books and count the overdue books 
WITH cte1 AS (    
    SELECT 
        patron_id,
        book_id,
        due_date,
        return_date
     FROM loans
     WHERE 
         return_date LIKE ''
         AND due_date <  date('now','localtime')
) 
SELECT 
    patron_id,
    COUNT(book_id) AS 'Total Overdue Books'
FROM cte1 
GROUP BY patron_id 
ORDER BY COUNT(book_id) DESC;

-- Question 11: Time-based analysis : Analyze monthly borrowing trends, show year, month, number of loans, number of unique patrons per month
SELECT 
    strftime('%m', checkout_date) AS 'month',
    strftime('%Y', checkout_date) AS 'year',
    COUNT(loan_id) AS 'number of loans',
    COUNT(DISTINCT patron_id) AS 'unique patrons'
FROM loans
GROUP BY  strftime('%m', checkout_date);


-- Discussion Question 4) Combine tasks 1-3 

-- all titles, published years after 2000 order by publication year newewst to oldest
-- books with more than 5 copies owned in fiction genre_id = 1
-- all books with the word 'History' in title
SELECT 
    title,
    publication_year,
    copies_owned
FROM books 
WHERE 
     title LIKE ('%History%') 
     AND publication_year > 2000
     AND copies_owned > 5;

    


-- Part 1 : Basic SQL Operations and JOIN Queries

-- Question 1) Basic Selection: Retrieve titles of all books published after 2000, order by publication year (newest to oldest)
SELECT 
    title AS 'Title',
    publication_year AS 'Publication Year'
FROM books 
WHERE publication_year > 2000
ORDER BY publication_year DESC;

-- Question 2) Filtering: Find all books with more than 5 copies owned in the fiction genre 
SELECT 
    title AS 'Book Title',
    copies_owned AS 'Copies Owned'
FROM books
WHERE copies_owned > 5
ORDER BY copies_owned DESC, title;

-- Question 3) Pattern Matching: List all books whose titles contain the word History
SELECT 
    title AS 'Book Title'
FROM books
WHERE title LIKE ('%History%') 
ORDER BY title;

-- Question 4) JOIN Operations: Display loan information and patron details for all loans made in Jan 2023 
SELECT 
    l.loan_id,
    l.checkout_date,
    l.due_date,
    p.first_name,
    p.last_name,
    p.email
FROM loans l 
INNER JOIN patrons p ON l.patron_id = p.patron_id
WHERE 
    strftime( '%Y',l.checkout_date) = '2023'
     AND strftime( '%m',l.checkout_date) = '01';


-- Question 5) Multi-table JOIN: Show book details for each loan along with checkout and due dates
SELECT 
    b.title AS 'Book Title',
    a.first_name || ' ' || a.last_name AS 'Author',
    g.genre_name AS 'Genre',
    
     l. checkout_date AS 'Checkout Date',
     l.due_date AS 'Due Date'
FROM books AS b
INNER JOIN authors AS a 
    ON b.author_id = a.author_id
INNER JOIN genres AS g 
    ON b.genre_id = g.genre_id
INNER JOIN loans AS l
    ON b.book_id = l.book_id;
    
-- Question 6) Self JOIN:  Find pairs of patrongs who live in the same city. Show both patron's names and in their city

-- Added WHERE clause in my query to not include rows where  patron_person_1 and patron_person_2 are the same person
SELECT 
    p1.first_name || ' ' || p1.last_name AS patron_person_1,
    p2.first_name || ' ' || p2.last_name AS patron_person_2,
    p1.city AS 'City'
FROM patrons AS p1
INNER JOIN patrons AS p2
    ON p1.city = p2.city 

WHERE  p1.first_name || ' ' || p1.last_name  <>   p2.first_name || ' ' || p2.last_name
ORDER BY p1.city;

-- Question 7) Multi-table JOIN w/ filtering: Find all fiction books that have been borrowed along with every patron and branch 
SELECT 
    b.title AS 'Book',
    p.first_name || ' ' || p.last_name AS 'Patron Full Name',
    br.branch_name AS 'Branch'
FROM books AS b
INNER JOIN loans AS l 
    ON b.book_id = l.book_id
INNER JOIN patrons AS p
    ON l.branch_id = p.branch_id
INNER JOIN branches AS br 
    ON p.branch_id = br.branch_id
WHERE b.genre_id = 1
ORDER BY b.title, br.branch_name;

-- PART 2: Aggregation and GROUP BY Operations

-- Question 8) COUNT aggregation: COUNT the number of books in each genre category
SELECT 
    g.genre_name AS 'Genre',
    COUNT(b.title) AS 'Total Books in Genre'
FROM genres AS g 
INNER JOIN books AS b 
    ON g.genre_id = b.genre_id 
GROUP BY g.genre_name
ORDER BY COUNT(b.title) DESC;
    

-- Question 9) Multiple Aggregations: Calculate the avg, min, and max loan duration for each library branch, only inlcude returned books

-- Uses julianday to get difference of dates in days
-- return_date, and checkout_date are text data types, I used  NOT LIKE '' to filter out return dates without a return date
SELECT 
    branch_id AS 'Branch ID',
    ROUND(AVG(julianday(return_date) - julianday(checkout_date)),2) AS 'Avg Loan Duration in Days',
    MIN(julianday(return_date) - julianday(checkout_date)) AS 'Min Loan Duration in Days',
    MAX(julianday(return_date) - julianday(checkout_date)) AS 'Max Loan Duration in Days'
FROM loans
WHERE return_date NOT LIKE ''
GROUP BY branch_id;

-- Question 10) Conditional Aggregation: Find patrons with overdue books and count the overdue books 
WITH cte1 AS (    
    SELECT 
        patron_id,
        book_id,
        due_date,
        return_date
     FROM loans
     WHERE 
         return_date LIKE ''
         AND due_date <  date('now','localtime')
) 
SELECT 
    patron_id,
    COUNT(book_id) AS 'Total Overdue Books'
FROM cte1 
GROUP BY patron_id 
ORDER BY COUNT(book_id) DESC;

-- Question 11: Time-based analysis : Analyze monthly borrowing trends, show year, month, number of loans, number of unique patrons per month
SELECT 
    strftime('%m', checkout_date) AS 'month',
    strftime('%Y', checkout_date) AS 'year',
    COUNT(loan_id) AS 'number of loans',
    COUNT(DISTINCT patron_id) AS 'unique patrons'
FROM loans
GROUP BY  strftime('%m', checkout_date);


-- Discussion Question 4) Combine tasks 1-3 

-- all titles, published years after 2000 order by publication year newewst to oldest
-- books with more than 5 copies owned in fiction genre_id = 1
-- all books with the word 'History' in title
SELECT 
    title,
    publication_year,
    copies_owned
FROM books 
WHERE 
     title LIKE ('%History%') 
     AND publication_year > 2000
     AND copies_owned > 5;

-- What's the average loan duration by genre
SELECT g.genre_name,
       ROUND(AVG(JULIANDAY(l.return_date) - JULIANDAY(l.checkout_date)),2) as avg_loan_days
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Genres g ON b.genre_id = g.genre_id
WHERE l.return_date IS NOT NULL
GROUP BY g.genre_name
ORDER BY avg_loan_days DESC;
    
-- Who are the top 10 most active patrons by branch
SELECT br.branch_name,
       p.first_name || ' ' || p.last_name as patron_name,
       COUNT(l.loan_id) as total_loans
FROM Patrons p
INNER JOIN Branches br 
    ON p.branch_id = br.branch_id
INNER JOIN Loans l 
    ON p.patron_id = l.patron_id
GROUP BY br.branch_name, p.patron_id
ORDER BY br.branch_name, total_loans DESC
LIMIT 10;

-- Business Questions not covered in previous tasks

-- Most Popular Genre by city

WITH rank_genre AS (
    SELECT 
           p.city AS city,
           g.genre_name AS genre,
           COUNT(l.loan_id) as loans_count,
           RANK() OVER (PARTITION BY p.city ORDER BY COUNT(l.loan_id) DESC) as genre_rank
       FROM Loans l
       JOIN Patrons p ON l.patron_id = p.patron_id
       JOIN Books b ON l.book_id = b.book_id
       JOIN Genres g ON b.genre_id = g.genre_id
       GROUP BY p.city, g.genre_name

)
SELECT * 
FROM rank_genre
HAVING genre_rank <= 3
ORDER BY city, genre, genre_rank