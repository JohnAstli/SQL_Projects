CREATE DATABASE dtexer;

USE dtexer;

CREATE TABLE people (
	name VARCHAR(50), 
    birthdate DATE , 
    birthtime TIME , 
    birthdt DATETIME
);
DESC people;

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00'),
		('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10'),
        ('Juan', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');
        
SELECT * FROM people;

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Tom', CURDATE(), CURTIME(), NOW());

SELECT 
    name,
    birthdate,
    DAY(birthdate),
    DAYOFWEEK(birthdate),
    DAYOFYEAR(birthdate)
FROM
    people;
    
    
CREATE TABLE captions ( 
	text VARCHAR (150),
    created_at TIMESTAMP default CURRENT_TIMESTAMP
); 

CREATE TABLE captions2 ( 
	text VARCHAR (150),
    created_at TIMESTAMP default CURRENT_TIMESTAMP,
    -- this parameter updates the timestamp everytime we change it
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
); 
INSERT INTO captions (text) VALUES ('just me and the girls chilling');
INSERT INTO captions (text) VALUES ('beautiful sunset');

INSERT INTO captions2 (text) VALUES ('i love life!!');
SELECT * FROM captions2 ;

UPDATE captions2 SET text='I love life too!!' WHERE text='i love life!!' ;

USE book_store;

SELECT 
    title
FROM
    books
WHERE
    title NOT LIKE '%e%';
    
SELECT 
    title,
    released_year,
    CASE
        WHEN released_year >= 2000 THEN 'moderln lit'
        ELSE '20th century lit'
    END AS Genre
FROM
    books;
SELECT * FROM books;
SELECT 
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 50 AND 100 THEN '**'
        ELSE '***'
    END AS Stock
FROM
    books;
    
-- Ex.1 Select all the books written before 1980 (non inclusive)
SELECT title, released_year FROM books WHERE released_year < 1980;

-- Ex.2 Select all books written by Eggers or Chabon
SELECT title, author_lname FROM books WHERE author_lname IN ('Eggers','Chabon');

-- Ex.3 Select all books published by Lahiri, and published after 2000
SELECT 
    title, author_lname, released_year
FROM
    books
WHERE
    author_lname = 'Lahiri'
        OR released_year >= 2000;

-- Ex.4 Select all books that have a page count between 100 and 200 
SELECT title, pages FROM books WHERE pages BETWEEN 100 AND 200;
-- Ex.5 Select all book where author_lname start with 'C' or 'S'     
SELECT title, author_lname FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%' ;

SELECT title, author_lname, 
	CASE 
		WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title LIKE '%Just Kids%' OR title LIKE '%Heartbreaking%' THEN 'Memoir'
        ELSE 'Novel'
	END AS Type 
FROM books;


 SELECT author_fname, author_lname, 
	CASE 
		WHEN COUNT(*)  = 1 THEN '1 book'
        WHEN COUNT(*)  =  2 THEN '2 books'
        ELSE '3 books'
	END AS COUNT
FROM books 
GROUP BY author_fname,author_lname;
    

