CREATE DATABASE empl_db;
USE empl_db;

CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);
 
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);
 
SELECT * FROM employees;

-- The OVER() function gives an aggregate result alongside every row of the table
SELECT department, salary, MIN(salary) OVER() , MAX(salary) OVER() 
FROM employees; 

-- Including the PARTITION BY clause in OVER() function, we further partition the data 
-- and group our data 

CREATE VIEW company_view AS 
SELECT   emp_no
		, department
		, salary
        , MIN(salary) OVER(PARTITION BY department) AS dept_min 
        , MAX(salary)  OVER(PARTITION BY department) AS dept_max 
        , AVG(salary) OVER(PARTITION BY department) AS dept_avg 
        , AVG(salary) OVER() AS company_avg 
FROM employees; 

SELECT * FROM  company_view;