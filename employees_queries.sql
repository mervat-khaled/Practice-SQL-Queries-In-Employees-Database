USE employees;
-- -- -- 
SELECT *  FROM employees 

WHERE  first_name IS NOT NULL; 

 SELECT DISTINCT(gender) FROM employees;

SELECT * FROM employees ORDER BY  first_name LIMIT 10;

SELECT * FROM employees ORDER BY  first_name DESC LIMIT 10;

SELECT * FROM employees ORDER BY  emp_no DESC  LIMIT 10;

SELECT * FROM employees ORDER BY  first_name, last_name ASC LIMIT 10;

 /*How many employees are registered in our database? */
 
 
 SELECT  COUNT(emp_no) FROM employees;

/*******************************************************************/

SELECT COUNT(first_name) FROM employees WHERE first_name IS NULL;

SELECT COUNT(DISTINCT first_name) AS Unique_first_names FROM employees; 

SELECT 
    dept_no,COUNT(dept_no) AS departments_count
FROM
    dept_emp 
GROUP BY dept_no;

SELECT 
    dept_no,COUNT(dept_no)  AS departments_count
FROM
    dept_emp 
GROUP BY dept_no
ORDER BY departments_count DESC;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

/*********************************************************************/

/*THE INSERT STATEMENT*/
-- 
SELECT 
    *
FROM
    employees
LIMIT 10;

insert into employees
(
emp_no, 
birth_date, 
first_name,
 last_name, 
 gender, 
 hire_date)
values(999901,
'1986-04-21',
 'John', 
 'Smith',
 'M',
 '2011-01-01') 
 ;
-- 
SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

/* INSERTING DATA INTO A NEW TABLE*/

CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

select * from departments_dup;
--  
INSERT INTO departments_dup (dept_no,dept_name) 
SELECT * FROM departments;

SELECT * FROM departments_dup;

USE employees;

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

/* HOW many employee start dates are in the database?*/

SELECT 
    COUNT( DISTINCT from_date)
FROM
    salaries;
-- 
SELECT 
    SUM(salary)
FROM
    salaries;

/* Which is the highest salary we offer?*/
-- 
SELECT 
    MAX(salary)
FROM
    salaries;
 --    
SELECT 
    MIN(salary)
FROM
    salaries;
-- 
SELECT 
    AVG(salary)
FROM
    salaries;
-- 

SELECT 
    ROUND(AVG(salary))
FROM
    salaries;


