select * from employeement_demographic;
select * from employeement_salary;

# Join - combine rows from two or more table based on related column between them
#1. INNER JOINS - select rows from both table that have matching values in both table

select * from employeement_demographic Inner join employeement_salary
	on employeement_demographic.employee_id=employeement_salary.employee_id;

select * from employeement_demographic as dem
inner join employeement_salary as sal
	on dem.employee_id=sal.employee_id;

select dem.employee_id,dem.first_name,occupation from employeement_demographic as dem 
inner join employeement_salary as sal 
	on dem.employee_id=sal.employee_id;
    
# outer join- 1.left outer join
# left outer join : return all the values from left table and matched rows from right table
select * from employeement_demographic
 left outer join employeement_salary
	on employeement_demographic.employee_id=employeement_salary.employee_id;
    
# right outer join: return all the values from right table and matched rows from left table

select * from employeement_demographic 
right outer join employeement_salary
	on employeement_demographic.employee_id=employeement_salary.employee_id;

# self joins- regular join but with same table

select * from employeement_salary as emp1 join employeement_salary as emp2
	on emp1.employee_id=emp2.employee_id;

select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santaa,
emp2.employee_id as emp_id,
emp2.first_name as emp_first_Name,
emp2.last_name as emp_last_name
from employeement_salary as emp1 join employeement_salary as emp2
	on emp1.employee_id+1=emp2.employee_id;

# join multiple tables

select * from employeement_demographic as emp1 inner join employeement_salary as sal
	on emp1.employee_id=sal.employee_id
inner join perks_department as per
	on sal.dept_id=per.department_id;

-- cross join
-- SQL CROSS JOIN returns all the records from the left and right tables.
-- CROSS JOIN returns a combination of each row in the left table paired with each row in the right table.
SELECT * FROM table1 CROSS JOIN table2;