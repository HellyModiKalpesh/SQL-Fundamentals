-- subqueries
-- different types of sub queries
-- 1.subquery in where statement 
select * 
from employeement_demographic
where employee_id in(select employee_id from employeement_salary where dept_id=1);
-- 2. use subquery as select 

select first_name,salary,(select avg(salary) from  employeement_salary) from employeement_salary;
-- 3. use of subquery in from 
select gender,avg(max_age) from(
select gender,avg(age) as avg_age,
max(age)as max_age,
min(age) as min_age 
from employeement_demographic group by gender) as new_table group by gender;