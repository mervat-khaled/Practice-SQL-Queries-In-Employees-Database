USE employees;

drop procedure if exists select_employees;
delimiter $$
create procedure select_employees() 
begin 
select * from employees
limit 100;
end $$
delimiter ;

call employees.select_employees();

call select_employees();

DROP PROCEDURE IF EXISTS emp_salary;
DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN 
SELECT 
e.first_name, e.last_name, s.salary,s.from_date,s.to_date
FROM 
employees e
JOIN 
salaries s ON e.emp_no = s.emp_no
WHERE 
e.emp_no = p_emp_no; 
END $$
DELIMITER ;

CALL employees.emp_salary(11300);

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN 
SELECT 
e.first_name, e.last_name, AVG(s.salary)
FROM 
employees e
JOIN 
salaries s ON e.emp_no = s.emp_no
WHERE 
e.emp_no = p_emp_no; 
END $$
DELIMITER ;

CALL emp_avg_salary(11300);

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN 
SELECT 
 AVG(s.salary)
 INTO p_avg_salary
FROM 
employees e
JOIN 
salaries s ON e.emp_no = s.emp_no
WHERE 
e.emp_no = p_emp_no; 
END $$
DELIMITER ;

CALL emp_avg_salary_out(11300, @p_avg_salary);
SELECT @p_avg_salary;

SET @v_avg_salary= 0;
CALL emp_avg_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN 
DECLARE v_avg_salary DECIMAL(10,2);
SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
RETURN v_avg_salary;
END $$

DELIMITER ;

SELECT f_emp_avg_salary(11300);




