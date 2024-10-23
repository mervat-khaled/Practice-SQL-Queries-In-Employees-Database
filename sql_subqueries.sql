USE employees;

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);

SELECT 
    e.emp_no, e.first_name, e.last_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no;

/* Exists Not Exists neastd inside Where */

SELECT 
    e.emp_no, e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY emp_no;

USE employees;

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no  >10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no 
    LIMIT 20) AS B;

/* Self Join*/

CREATE TABLE emp_manager2(
    emp_ID INT(11) NOT NULL,
    department_code CHAR(4),
    manager_ID INT(11)
);

SELECT 
    e1.*
FROM
    emp_manager2 e1
        JOIN
    emp_manager2 e2 ON e1.emp_ID = e2.manager_ID;

/* USing SOL views*/

SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

CREATE OR REPLACE VIEW v_dept_emp_empNO_count AS
    SELECT 
        emp_no, from_date, to_date, COUNT(emp_no) AS Num
    FROM
        dept_emp
    GROUP BY emp_no
    HAVING Num > 1;


    

