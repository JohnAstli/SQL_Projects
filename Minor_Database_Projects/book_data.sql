CREATE DATABASE book_store; 

USE book_store ; 

CREATE TABLE books 
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

DESC books ; 
SELECT * FROM books;

/* Showing the CONCAT() function */
SELECT CONCAT ( author_fname, ' ', author_lname) AS full_name FROM books;

/* With the CONCAT_WS we get the concat function inserting a separator as a first argument */
SELECT CONCAT_WS ( '-' , author_fname , author_lname) AS full_name FROM books;

/* Showing the SUBSTRING() function */
SELECT SUBSTRING(author_fname, 1, 1) AS initial , author_fname FROM books;

/* The combination of the previous functions gives some nice results */
SELECT 
    CONCAT(SUBSTRING(title, 1, 10), '...') AS short_title
FROM
    books; 
        
SELECT 
    CONCAT(SUBSTRING(author_fname, 1, 1),
            '.',
            SUBSTRING(author_lname, 1, 1),
            '.') AS initials
FROM
    books; 
    
/* The REPLACE function, given an initial string (1st parameter) changes 
the target (2nd parameter) string with a third parameter string */
SELECT REPLACE(title, ' ', '-' ) FROM books; 

/* The REVERSE() function takes a string and reverses it
In the below example we combine CONCAT() with REVERSE() and make the 
name's palindromes from the database books */
SELECT 
    CONCAT(author_fname, REVERSE(author_fname)) AS palindrome
FROM
    books;

/* CHAR_LENGTH gives the number of characters that reside in a string */
SELECT 
    CHAR_LENGTH(title) AS len, title
FROM
    books;
    
/* UPPER() and LOWER() are functions to make all letters uppercase or lowercase respectively */
SELECT CONCAT('I LOVE ', UPPER(title) , '!!!') FROM books; 

/* Basic exercises in strings with our database  */
SELECT REPLACE ( title, ' ' , '->') AS title FROM books;

SELECT 
    author_lname AS forwards, REVERSE(author_lname) AS backwards
FROM
    books;
    
SELECT 
    CONCAT(UPPER(author_fname),
            ' ',
            UPPER(author_lname)) AS 'full name in caps'
FROM
    books;
    
SELECT 
    CONCAT(title,
            ' was released in ',
            released_year) AS blurb
FROM
    books;    
    
SELECT 
    CONCAT(SUBSTRING(title, 1, 10), '...') AS short_title,
    CONCAT(author_lname, ',', author_fname) AS author,
    CONCAT(stock_quantity, ' in stock ') AS quantity
FROM
    books;

/* In this section we will see some sophisticated functions of SQL */

INSERT INTO books
        (title, author_fname, author_lname, released_year, stock_quantity, pages)
        VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
               ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
               ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);  
               
SELECT * FROM books; 

/* With the DISTINCT clause we print only the distinct values of our database */
SELECT DISTINCT author_fname, author_lname FROM books;

/* ORDER BY is a clause to present the values by our preferred order */
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author,
    title,
    released_year
FROM
    books
ORDER BY released_year;        

/* We can order the results, on multiple columns giving more entries to the ORDER BY clause */
SELECT 
    author_lname, released_year, title
FROM
    books
ORDER BY author_lname , released_year;

/* LIMIT is a clause to minimize the results shown by our selection of entries 
We can specify the spectrum through two arguments after LIMIT, starting point and 
number of entries to be printed*/
SELECT 
    author_lname, released_year, title
FROM
    books
ORDER BY released_year DESC
LIMIT 2,2; 

/* LIKE is another useful clause to optimize the search in the database
in the situation that we cannot remember the whole entry */
SELECT 
    author_fname, title
FROM
    books
WHERE
    author_fname LIKE '%da%';
    
/*Excercise section */ 
/* 1st . Find all the titles that contain the word 'stories' */
SELECT 
    title
FROM
    books
WHERE
    title LIKE '%stories%';
    
/* 2nd  . Find the book with the most pages */
SELECT 
    title, pages
FROM
    books
ORDER BY pages DESC
LIMIT 0, 1; 

/* 3rd . Print the summary of the 3 recent books (summary contains title - year) */
SELECT 
    CONCAT(title, ' - ', released_year) AS summary
FROM
    books
ORDER BY released_year DESC
LIMIT 0 , 3;

/* 4th . Print the author names and titles, where the author has a space in the last name */
SELECT 
    author_lname, title
FROM
    books
WHERE
    author_lname LIKE '% %';
    
/* 5th . Print the 3 lowest in stock books */ 
SELECT 
    title, released_year, stock_quantity
FROM
    books
ORDER BY stock_quantity
LIMIT 0 , 3;

/*6th . Print the last name and the title, first sorted by last name and then by title*/
SELECT 
    title, author_lname
FROM
    books
ORDER BY author_lname , title;

/* 7th . Print in all capital, all author names with 
"MY FAVOURITE AUTHOR IS" first, sorted by last name */
SELECT 
    UPPER(CONCAT('MY FAVOURITE AUTHOR IS ',
                    author_fname,
                    ' ',
                    author_lname,
                    '!')) AS yell
FROM
    books
ORDER BY author_lname;



