-- CTEs


WITH CTE_Example AS
(
select gender, AVG(salary)
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
Select * 
FROM CTE_Example
;

-- CTEs can only be used immediately after writing the CTE uery
WITH CTE_Example AS
(
SELECT employee_id, gender, birth_date
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
SELECT employee_id, salary
FROM parks_and_recreation.employee_salary
WHERE salary > 50000
)

SELECT *
from CTE_Example
JOIN CTE_Example2
ON CTE_Example.employee_id = CTE_Example2.employee_id
;

-- Temporary Tables

CREATE TEMPORARY TABLE parks_and_recreation.temp_table
(
first_name varchar(50),
last_name varchar(50),
fav_movie varchar(100)
);

select * 
from parks_and_recreation.temp_table;


CREATE temporary table parks_and_recreation.salary_over_50K
select *
from parks_and_recreation.employee_salary
where salary > 50000;

select *
from parks_and_recreation.salary_over_50K;

INSERT INTO parks_and_recreation.temp_table
VALUES ('Kinnari', 'Bhalerao', 'Interstellar');


-- Temp tables can be used only for a single session

-- Stored procedures
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM parks_and_recreation.employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM parks_and_recreation.employee_salary
	WHERE salary >= 20000;
END $$
DELIMITER ;

CALL large_salaries2();

DELIMITER $$
CREATE PROCEDURE large_salaries5(p_employee_id int)
BEGIN
	SELECT salary
    FROM employee_salary
    WHERE employee_id = p_employee_id;
END $$
DELIMITER ;

CALL large_salaries5(1);

-- Trigger is a block of code that executed automatically when an event takes place in a specific table

select *
from parks_and_recreation.employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert12
	AFTER INSERT ON employee_salary
    FOR EACH ROW 
BEGIN 
INSERT INTO employee_demographics(employee_id, first_name, last_name)
VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER $$

INSERT INTO employee_salary(employee_od, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Kinnari', 'Bhalerao', 'Astrophysicist', 100000, NULL);

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW 
BEGIN 
INSERT INTO employee_demographics(employee_id, first_name, last_name)
VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER $$

INSERT INTO employee_salary(employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(15, 'Kinnari', 'Bhalerao', 'Astrophysicist', 100000, NULL);

-- EVENTS

SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees2
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN 
	DELETE 
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

SELECT *
FROM employee_demographics;



