CREATE DATABASE online_store ;
USE online_store;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
       
       
-- In this section JOIN is introduced, in order to match columns from the two tables
-- First we will see the inner Join, which is the intersection of the two tables

SELECT 
    *
FROM
    customers
        JOIN
    orders ON customers.id = orders.customer_id;
    
SELECT 
    first_name, last_name, order_date, amount
FROM
    customers
        JOIN
    orders ON customers.id = orders.customer_id;
    
-- The total amount spent by each customer for the orders they made

SELECT 
    first_name, last_name, SUM(amount)
FROM
    customers
        JOIN
    orders ON customers.id = orders.customer_id
GROUP BY first_name , last_name;


/* The LEFT JOIN  is used to identify any mismatch from two tables
In the LEFT JOIN the order of the tables is crucial*/

SELECT 
    first_name, last_name, order_date, amount
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.id;
    
-- Combining LEFT JOIN and GROUP BY 
-- The IFNULL() function, replaces NULL with an expression we want

SELECT 
    first_name,
    last_name,
    IFNULL(SUM(amount), 0) AS total_money_spent
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.id
GROUP BY first_name , last_name;

-- Excercise on JOINS 
CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30)
    );
    
CREATE TABLE papers (
	title VARCHAR(150),
    grade INT , 
    student_id INT, 
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE 
);

    INSERT INTO students (first_name) VALUES 
    ('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');
     
    INSERT INTO papers (student_id, title, grade ) VALUES
    (1, 'My First Book Report', 60),
    (1, 'My Second Book Report', 75),
    (2, 'Russian Lit Through The Ages', 94),
    (2, 'De Montaigne and The Art of The Essay', 98),
    (4, 'Borges and Magical Realism', 89);
    
    SELECT * FROM students;
    SELECT * FROM papers;
    
    SELECT 
    first_name, title, grade
FROM
    students
        JOIN
    papers ON students.id = papers.student_id
ORDER BY grade DESC;

SELECT 
    first_name, title, grade
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id;
    
SELECT 
    first_name, IFNULL( title, 'MISSING') AS title, IFNULL(grade, 0) AS grade
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id;
    
SELECT 
    first_name, IFNULL(AVG(grade), 0) AS grade
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY grade DESC;

SELECT 
    first_name,
    IFNULL(AVG(grade), 0) AS grade,
    CASE
        WHEN  IFNULL(AVG(grade), 0)>= 75.00 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY grade DESC;