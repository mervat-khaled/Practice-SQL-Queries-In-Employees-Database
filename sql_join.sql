USE employees;

/* INNER JOIN */
SELECT * FROM departments_dup order by dept_no;

SELECT * FROM dept_manager_dup order by emp_no desc;

SELECT 
          
          m.dept_no, m.emp_no,  d.dept_name
          
FROM
          dept_manager_dup m
                 INNER JOIN 
		  departments_dup d ON m.dept_no = d.dept_no
          
ORDER BY m.dept_no;

/* How to handle duplicate values with join */

INSERT INTO dept_manager_dup 
VALUES ('110228','d003','1992-03-21','9999-01-01');

INSERT INTO departments_dup 
VALUES ('d009','Customer Serviece');

/* To avoid duplicate values, add GROUP BY to the field that differs most among records*/


SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

SELECT 
          
          m.dept_no, m.emp_no,  d.dept_name
          
FROM
          dept_manager_dup m
                 JOIN 
		  departments_dup d ON m.dept_no = d.dept_no
GROUP BY  m.emp_no
ORDER BY dept_no;


/* LEFT JOIN*/

DELETE FROM departments_dup 
WHERE dept_no = 'd009';

/* Add back the intial records */

INSERT INTO departments_dup 
VALUES ('d009','Customer Service');

SELECT 
          m.dept_no, m.emp_no, d.dept_name
FROM 
          dept_manager_dup m 
                 LEFT JOIN
		  departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

/* HINT --- THE ORDER  MATTERS*/

SELECT 
          d.dept_no, m.emp_no, d.dept_name
FROM 
          
          departments_dup d
                 LEFT JOIN
		  dept_manager_dup m  ON m.dept_no = d.dept_no
ORDER BY d.dept_no;


/*Join and Where used together*/


SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 14500 LIMIT 10;

/* Cross Join*/

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    d.dept_no = dm.dept_no
ORDER BY dm.emp_no , d.dept_no;


/*Using aggregste function with join*/

/*Find the average salries of men and women in the company*/
-- 
SELECT 
    e.gender, AVG(s.salary) AS avg_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

/* JOIN MORE THAN TWO TABLES*/

SELECT 
    e.*, m.from_date, m.to_date, d.dept_name, s.salary
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    salaries s ON e.emp_no = s.emp_no;

/* Average salary for each department manager */
-- 
SELECT 
    d.dept_name, AVG(s.salary) AS avg_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY dept_name
ORDER BY avg_salary DESC;

/* What were the most paid titles? */

-- 
SELECT 
    t.title, MAX(s.salary) AS max_salary
FROM
    titles t
        JOIN
    employees e ON t.emp_no = e.emp_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY title
ORDER BY max_salary DESC;

