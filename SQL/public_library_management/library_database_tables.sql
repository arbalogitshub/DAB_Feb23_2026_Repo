-- Create Library Branches Table 
CREATE TABLE IF NOT EXISTS branches
(
    branch_id    INTEGER NOT NULL,
    branch_name VARCHAR (255),
    address    VARCHAR(255),
    city    VARCHAR(255),
    phone    VARCHAR(255)  ,      -- 123-4578 format 
    
    CONSTRAINT pk_branch PRIMARY KEY (branch_id)
);

-- Create Patrons Table 
CREATE TABLE IF NOT EXISTS patrons
(
    patron_id    INTEGER NOT NULL, 
    first_name    VARCHAR (255),
    last_name    VARCHAR (255),
    email    VARCHAR(255),
    address    VARCHAR(255),
    city    VARCHAR(255),
    registration_date   TEXT, -- YYYY-MM-DD
    branch_id INTEGER NOT NULL,
    
    CONSTRAINT pk_patron    PRIMARY KEY (patron_id),
    CONSTRAINT fk_branch  FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- Create Book Genres Table 
CREATE TABLE IF NOT EXISTS genres 
(
    genre_id INTEGER NOT NULL,
    genre_name VARCHAR(255),
    description    TEXT,
    
    CONSTRAINT pk_gnere PRIMARY KEY (genre_id)
);

-- Create Authors Table 
CREATE TABLE IF NOT EXISTS authors
(
    author_id    INTEGER NOT NULL,
    first_name    VARCHAR(255),
    last_name    VARCHAR(255),
    birth_year    INTEGER,
    country    VARCHAR(255),
    
    CONSTRAINT pk_author PRIMARY KEY (author_id)
);

-- Create Books Table 
CREATE TABLE IF NOT EXISTS books
(
    book_id INTEGER NOT NULL,
    title VARCHAR (255),
    author_id    INTEGER NOT NULL,
    genre_id    INTEGER NOT NULL,
    isbn    VARCHAR(255) NOT NULL,
    publication_year    INTEGER NOT NULL,
    copies_owned INTEGER,
    

    CONSTRAINT pk_books PRIMARY KEY (book_id)    ,
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors (author_id),
    CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
);


-- Create Loans Table 
CREATE TABLE IF NOT EXISTS loans
(
    loan_id    INTEGER NOT NULL,
    book_id    INTEGER NOT NULL,
    patron_id    INTEGER NOT NULL,
    branch_id    INTEGER NOT NULL,
    checkout_date TEXT, --YYYY-MM-DD format 
    due_date    TEXT, --YYYY-MM-DD format 
    return_date TEXT DEFAULT NULL ,--YYYY-MM-DD
    
    CONSTRAINT pk_loan PRIMARY KEY (loan_id),
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES books (book_id),
    CONSTRAINT fk_patron FOREIGN KEY (patron_id) REFERENCES patrons (patron_id),
    CONSTRAINT fk_branch FOREIGN KEY (branch_id) REFERENCES branches (branch_id)

);

/*
DROP TABLE branches;
DROP TABLE patrons;
DROP TABLE authors;
DROP TABLE genres;
DROP TABLE books;
DROP TABLE loans;
*/
