USE book_store;

DESC books; 
SELECT * FROM books;

/* In this section, the aggregate functions are described*/
/* Below the COUNT function is presented */
SELECT COUNT(*) FROM books;
/* In order to specify the results we want to count inside 
the parentheses of COUNT we define the column .
Otherwise, we make a general count with the (*) definition
and with the function WHERE we specify what is it to be counted*/
SELECT COUNT(author_fname) FROM books;

-- In the below queries we count the titles that include the word 'the'
SELECT title FROM books WHERE title LIKE '%the%';
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

/* In order to bring more sophisticated results, we use the GROUP BY 
function in combination with the COUNT clause*/ 
-- Below we present the number of books, each author wrote
SELECT 
    author_lname, COUNT(*) AS books_written
FROM
    books
GROUP BY author_lname
ORDER BY books_written DESC;

/* More capabilities with the MIN and MAX functions are available 
only when used with the help of subqueries */
SELECT MIN(pages) FROM books;

/* The above querie cannot be further specified. 
So if we want to find the title of the book with the least pages*/
SELECT 
    title, pages
FROM
    books
WHERE
    pages = (SELECT 
            MIN(pages)
        FROM
            books);


/* GROUP BY multiple columns with combination of COUNT
 In the below querie we specify the author's name so as to have all distinct values
 Because we have two author with the last name Harris */
SELECT 
    CONCAT(SUBSTRING(author_fname, 1, 1),
            '.',
            author_lname) AS author,
    COUNT(*) AS books_written
FROM
    books
GROUP BY author;  

-- Using MIN/MAX with the GROUP BY clause
SELECT 
    author_lname,
    author_fname,
    COUNT(*) AS books_written,
    MAX(released_year) AS latest_release,
    MIN(released_year) AS earliest_release,
    MAX(pages) AS longest_page_count
FROM
    books
GROUP BY author_lname , author_fname
ORDER BY books_written DESC;


/* Below a couple of exercises in aggregate functions */

-- ex 1. Print the number of books in the database
SELECT COUNT(title) FROM books;

-- ex 2. Print out how many books were released each year
SELECT 
    released_year, COUNT(title) AS released_books
FROM
    books
GROUP BY released_year
ORDER BY released_year DESC; 

-- ex 3. Print out the total number of books in stock
SELECT SUM(stock_quantity) FROM books;

-- ex 4. Find the average released_ year of each author
SELECT 
    author_fname, author_lname, AVG(released_year)
FROM
    books
GROUP BY author_fname , author_lname;

-- ex 5. Find the full name of the author that wrote the longest book
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author, pages
FROM
    books
WHERE
    pages = (SELECT 
            MAX(pages)
        FROM
            books); 

-- ex 6. Print each year, the number of books that were released that year 
--       and the average number of pages (Format: year| # books | avg pages

SELECT 
    released_year AS 'year',
    COUNT(title) AS '# books',
    AVG(pages) AS 'avg pages'
FROM
    books
GROUP BY released_year
ORDER BY released_year ; 

