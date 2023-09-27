CREATE DATABASE tv_review_db;
USE tv_review_db;

CREATE TABLE reviewers (
        id INT PRIMARY KEY AUTO_INCREMENT,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL
    );
     
CREATE TABLE series (
        id INT PRIMARY KEY AUTO_INCREMENT,
        title VARCHAR(100),
        released_year YEAR,
        genre VARCHAR(100)
);
     
CREATE TABLE reviews (
        id INT PRIMARY KEY AUTO_INCREMENT,
        rating DECIMAL(2 , 1 ),
        series_id INT,
        reviewer_id INT,
        FOREIGN KEY (series_id)
            REFERENCES series (id),
        FOREIGN KEY (reviewer_id)
            REFERENCES reviewers (id)
);
     
INSERT INTO series (title, released_year, genre) VALUES
        ('Archer', 2009, 'Animation'),
        ('Arrested Development', 2003, 'Comedy'),
        ("Bob's Burgers", 2011, 'Animation'),
        ('Bojack Horseman', 2014, 'Animation'),
        ("Breaking Bad", 2008, 'Drama'),
        ('Curb Your Enthusiasm', 2000, 'Comedy'),
        ("Fargo", 2014, 'Drama'),
        ('Freaks and Geeks', 1999, 'Comedy'),
        ('General Hospital', 1963, 'Drama'),
        ('Halt and Catch Fire', 2014, 'Drama'),
        ('Malcolm In The Middle', 2000, 'Comedy'),
        ('Pushing Daisies', 2007, 'Comedy'),
        ('Seinfeld', 1989, 'Comedy'),
        ('Stranger Things', 2016, 'Drama');
     
     
INSERT INTO reviewers (first_name, last_name) VALUES
        ('Thomas', 'Stoneman'),
        ('Wyatt', 'Skaggs'),
        ('Kimbra', 'Masters'),
        ('Domingo', 'Cortes'),
        ('Colt', 'Steele'),
        ('Pinkie', 'Petit'),
        ('Marlon', 'Crafford');
        
     
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
        (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
        (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
        (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
        (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
        (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
        (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
        (7,2,9.1),(7,5,9.7),
        (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
        (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
        (10,5,9.9),
        (13,3,8.0),(13,4,7.2),
        (14,2,8.5),(14,3,8.9),(14,4,8.9);
        
-- Let's fetch the series title alongside the rating that was given
SELECT 
    title, rating
FROM
    series
        JOIN
    reviews ON series.id = reviews.series_id;
    
-- Now we will present the titles alongside the average rating given
-- We use the ROUND() function for better presentation
SELECT 
    title, ROUND(AVG(rating), 2) AS avg_rating
FROM
    series
        JOIN
    reviews ON series.id = reviews.series_id
GROUP BY title
ORDER BY avg_rating;

-- We will fetch every reviewers name and the rating they gave
SELECT 
    first_name
    , last_name
    , rating
FROM
    reviewers
        JOIN
    reviews ON reviewers.id = reviews.reviewer_id;

-- Now we will fetch all the unreviewed series by using Left Join
SELECT 
    title AS unreviewed_series
FROM
    series
        LEFT JOIN
    reviews ON series.id = reviews.series_id
WHERE
    rating IS NULL;
    
-- In this query we will combine every genre with the average rating for the genre
SELECT 
    genre, ROUND(AVG(rating), 2) AS avg_rating
FROM
    series
        JOIN
    reviews ON series.id = reviews.series_id
GROUP BY genre;

-- For this section we gonna take some measurements for our reviewers 
SELECT 
    first_name,
    last_name,
    COUNT(rating) AS 'COUNT',
   IFNULL( MIN(rating), 0) AS 'MIN',
   IFNULL( MAX(rating), 0) AS 'MAX',
   IFNULL( ROUND( AVG(rating), 2), 0) AS 'AVG',
    CASE
        WHEN COUNT(rating)=0 THEN 'INACTIVE'
        ELSE 'ACTIVE'
    END AS 'STATUS'
FROM
    reviewers
        LEFT JOIN
    reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name, last_name;


-- In this example we gonna show every review left for each series by making a double JOIN
SELECT 
    title,
    rating,
    CONCAT(first_name, ' ', last_name) AS reviewer
FROM
    series
        JOIN
    reviews ON series.id = reviews.series_id
        JOIN
    reviewers ON reviewers.id = reviews.reviewer_id; 
    
    
-- Introducing the Views, which are instances of queries saved in a virtual tavble for separate usage
CREATE VIEW full_reviews AS
    SELECT 
        title, released_year, genre, rating, first_name, last_name
    FROM
        reviews
            JOIN
        series ON series.id = reviews.series_id
            JOIN
        reviewers ON reviewers.id = reviews.reviewer_id;

-- WITH ROLLUP clause is a very useful clause used only with GROUP BY to give us further
-- statistics, by the given aggregate function 

SELECT 
    released_year, genre, AVG(rating)
FROM
    full_reviews
GROUP BY released_year , genre WITH ROLLUP;

-- In the below example with the combination of HAVING clause we see how we can get the average
-- ratings of a specific year, for all genres and the general average just by using WITH ROLLUP
SELECT 
    released_year, genre, AVG(rating)
FROM
    full_reviews
GROUP BY released_year , genre WITH ROLLUP
HAVING released_year= 2014;