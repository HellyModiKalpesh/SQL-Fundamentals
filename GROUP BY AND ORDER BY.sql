# GRoup by function

select gender from employeement_demographic group by gender;

select first_name from employeement_demographic group by gender;
# doesn't work

#The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of customers in each country".

#The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.

select avg(age) from employeement_demographic group by gender; 

select * from employeement_salary;

select occupation from employeement_salary group by occupation;
select distinct occupation from employeement_salary;

# both the upper query return same result but since you are not applying any aggregate function (like SUM, AVG, etc.) in the first query, using GROUP BY without an aggregate function will essentially behave like DISTINCT. 
# However, it's important to note that they serve different purposes, and GROUP BY is primarily used when you want to perform aggregation operations on grouped data.

select * from employeement_demographic;
select gender,avg(age) from employeement_demographic group by gender;
select gender,avg(age),max(age) as Highest_age from employeement_demographic group by gender;
select gender,avg(age),max(age) as Highest_age,min(age),count(age) from employeement_demographic group by gender;

# ORDER BY

select * from employeement_demographic order by first_name DESC;
select * from employeement_demographic order by first_name ASC;
select * from employeement_demographic order by gender,age DESC;

