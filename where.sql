-- WHERE CLAUSE

select * from 
employee_demographics
WHERE age > 30 AND gender ='female';

-- AND or NOT 

select * from
employee_demographics
where birth_date LIKE '1989%';


select gender, AVG(age)
from employee_demographics
group by gender;

select * from parks_and_recreation.employee_salary;

select occupation, MAX(salary) 
from parks_and_recreation.employee_salary
group by occupation;


select *
from parks_and_recreation.employee_demographics
order by 5, 4;


select gender, AVG(age)
from parks_and_recreation.employee_demographics
group by gender
having avg(age) > 40;


select occupation, avg(salary)
from parks_and_recreation.employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000;

select *
from parks_and_recreation.employee_demographics
order by age desc
LIMIT 2, 1;

select gender, avg(age) as AVG_AGE
from parks_and_recreation.employee_demographics
group by gender 
having AVG_AGE > 40;


