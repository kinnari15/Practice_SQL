select * from parks_and_recreation.employee_demographics;


select * from parks_and_recreation.employee_salary;

select dem.employee_id, age, occupation
from parks_and_recreation.employee_demographics as dem
INNER JOIN parks_and_recreation.employee_salary as sal
ON dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, age, occupation, salary
from parks_and_recreation.employee_demographics as dem
LEFT JOIN parks_and_recreation.employee_salary as sal
ON dem.employee_id = sal.employee_id;

select *
from parks_and_recreation.employee_demographics as dem
RIGHT JOIN parks_and_recreation.employee_salary as sal
ON dem.employee_id = sal.employee_id;


-- SELF JOIN

select *
from parks_and_recreation.employee_salary emp1
JOIN parks_and_recreation.employee_salary emp2
ON emp1.employee_id + 1 = emp2.employee_id;


select emp1.employee_id as emp_Santa,
emp1.first_name as first_name_santa,
emp2.employee_id as emp_santa,
emp2.first_name as first_name_santa
from parks_and_recreation.employee_salary emp1
JOIN parks_and_recreation.employee_salary emp2
ON emp1.employee_id + 1 = emp2.employee_id;


-- JOINING MULTIPLE TABLES TOGETHER 

select *
from parks_and_recreation.employee_demographics as dem
INNER JOIN parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_and_recreation.parks_departments pd
	ON sal.dept_id=pd.department_id
    ;

select *
from parks_and_recreation.parks_departments;


-- UNIONS

select first_name
from parks_and_recreation.employee_demographics
UNION ALL
select first_name
from parks_and_recreation.employee_salary;

-- var khali aste table

select first_name, last_name, 'Old Man' as label
from parks_and_recreation.employee_demographics
WHERE age >  40 and GENDER = 'Male'
UNION
select first_name, last_name, 'Old Lady' as label
from parks_and_recreation.employee_demographics
WHERE age >  40 and GENDER = 'Female'
UNION 
select first_name, last_name, 'Highly paid employee' as label
from parks_and_recreation.employee_salary
WHERE salary > 70000
order by first_name, last_name;


-- Case statements

select first_name, last_name,
case
when age <=30 THEN 'YOUNG'
when age between 31 and 50 then 'Old'
when age >=50 then 'Sorry'
END AS age_bracket
from parks_and_recreation.employee_demographics;


select first_name, last_name, salary,
CASE
WHEN salary < 50000 THEN salary + (salary * 1.05)
WHEN salary > 50000 THEN salary + (salary * 1.07)
END as new_salary,
CASE 
WHEN dept_id = 6 THEN salary * .10
END AS Bonus
from parks_and_recreation.employee_salary;


select *
from employee_salary;
select *
from parks_departments;

select length('Astronomy');

select first_name, UPPER(first_name)
from parks_and_recreation.employee_demographics;

select TRIM(          'Galaxy'               );
select LTRIM(          'Blackhole'           );

select first_name, 
LEFT(first_name,4),
RIGHT(first_name, 4),
SUBSTRING(first_name, 3, 2),
SUBSTRING(birth_date,6,2) as birthmonth
from parks_and_recreation.employee_demographics;


select first_name, REPLACE(first_name, 'a', 'z')
from parks_and_recreation.employee_demographics;

select LOCATE('x', 'Alexander');

select first_name, last_name,
CONCAT(first_name, last_name) as fullname
from parks_and_recreation.employee_demographics;



select *
from parks_and_recreation.employee_demographics
WHERE employee_id IN
(SELECT employee_id FROM parks_and_recreation.employee_salary
WHERE dept_id=1);

select first_name, salary, avg(salary)
from parks_and_recreation.employee_salary
GROUP BY first_name, salary;

select first_name, salary,
(select AVG(salary)
FROM parks_and_recreation.employee_salary)
FROM parks_and_recreation.employee_salary;

select gender, AVG(age), MAX(age), MIN(age), COUNT(age)
from parks_and_recreation.employee_demographics
GROUP BY gender;

select AVG(max_age) -- Back ticks are only is we have not renamed the files in the subquery
FROM
(
select gender,
 AVG(age) as avg_age, 
 MAX(age) as max_age,
 MIN(age) as min_age, 
 COUNT(age)
from parks_and_recreation.employee_demographics
GROUP BY gender) as agg_table;

select gender, AVG(salary) OVER(partition by gender)
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
ON dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, SUM(salary) OVER(partition by gender)
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
ON dem.employee_id = sal.employee_id;



-- over partition by, row_number, rank
select dem.first_name, dem.last_name, salary,
ROW_NUMBER() OVER(partition by gender ORDER BY salary DESC)
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
ON dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, salary,
ROW_NUMBER() OVER(partition by gender ORDER BY salary DESC) row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) dense_rank_num
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
ON dem.employee_id = sal.employee_id;





















