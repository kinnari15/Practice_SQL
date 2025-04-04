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