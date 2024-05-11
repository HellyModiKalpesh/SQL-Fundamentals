SELECT * FROM employeement_demographic;
select * from employeement_salary;

# union
/* The UNION operator is used to combine the result-set of two or more SELECT statements.
Every SELECT statement within UNION must have the same number of columns
The columns must also have similar data types
The columns in every SELECT statement must also be in the same order*/

# The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL:

select * from employeement_demographic union
select * from employeement_salary;

select first_name,last_name from employeement_demographic union distinct
select first_name,last_name from employeement_salary;

select first_name,last_name from employeement_demographic
where age>40
union
select occupation,last_name from employeement_salary where salary>70000;


select first_name,last_name,'old man' as label
from employeement_demographic
where age>40 and gender='male'
union
select first_name,last_name ,'old female' as label
from employeement_demographic
where age>50 and gender='female'
union
select first_name,last_name,'highly paid' as label
from employeement_salary
where salary>70000
order by first_name,last_name;
# this query works

select last_name,'old man' as label
from employeement_demographic
where age>40 and gender='male'
union
select first_name,last_name,'highly paid' as label
from employeement_salary
where salary>70000
order by first_name,last_name;
# this query doesn't work because The used SELECT statements have a different number of columns.

