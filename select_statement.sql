select * from parks_and_recreation.employee_demographics;


select 
first_name, 
last_name, 
birth_date,
age,
(age  + 10) * 10
from parks_and_recreation.employee_demographics;

select DISTINCT first_name, gender
from parks_and_recreation.employee_demographics;




