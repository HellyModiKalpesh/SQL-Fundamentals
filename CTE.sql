-- Advanced MYSQL
-- CTE
-- In MySQL, CTE stands for Common Table Expressions. 
-- CTEs provide a way to define temporary result sets that can be referenced within a query. 
-- They are particularly useful for making complex queries more readable and manageable by breaking them down into smaller, more understandable parts.
-- CTEs are defined using the WITH clause at the beginning of a query, followed by one or more subqueries


WITH CTE_EXAMPLE as
(
select gender,avg(salary) as avg_sal,max(salary) as max_sal,min(salary) as min_sal from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id group by gender
)
select gender,avg_sal from CTE_EXAMPLE;

-- same using subquery
select gender,avg(max_sal) from (
select gender,avg(salary) as avg_sal, max(salary) as max_sal from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id group by gender) as query group by gender;

-- here i can't use cte in somewhere else 
select * from CTE_EXAMPLE;
-- IT WILL SHOW ERORR because cte-example is not a permenant table it is just common table expression to create just like temporary temple

-- now multiple cte

with cte_ex as 
( select gender,birth_date,employee_id from employeement_demographic where birth_date > '1979-09-25'),
cte_ex2 as (
select employee_id from employeement_salary)
select * from cte_ex join cte_ex2 on cte_ex.employee_id=cte_ex2.employee_id;
WITH CTE_AvgSalary AS (
    SELECT 
        gender,
        AVG(salary) AS avg_salary
    FROM 
        employeement_demographic dem 
    JOIN 
        employeement_salary sal ON dem.employee_id = sal.employee_id 
    GROUP BY 
        gender
)
SELECT 
    gender,
    avg_salary
FROM 
    CTE_AvgSalary;
