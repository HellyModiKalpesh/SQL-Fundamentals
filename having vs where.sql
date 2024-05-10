select * from employeement_demographic;

select gender, avg(age) from employeement_demographic where gender like 'f%' group by gender;
# here this works because we are not filtering on aggregate function 

select gender,avg(age) from employeement_demographic where avg(age)>10 group by gender;
# this doesn't work because the WHERE clause is evaluated before the aggregation occurs. 
#SQL evaluates the WHERE clause on individual rows, not on the result of aggregate functions.

# Having 
select gender,avg(age) from employeement_demographic group by gender having avg(age)>40;
# HAVING clause, which is used specifically for filtering results of aggregate functions.

# now we can use both having and where clause simultaneously

select * from employeement_salary;

select occupation ,avg(salary) from employeement_salary where occupation like '%manager%' group by occupation having avg(salary)>60000;
/* Filtering (WHERE clause):
 First, the database engine applies the WHERE clause to filter rows from the employeement_salary table where the occupation contains the word "manager".
Grouping (GROUP BY clause):
After the filtering, the remaining rows are grouped by the occupation column. This means that rows with the same occupation are combined into groups.
Aggregation (AVG() function):
Within each group created by the GROUP BY clause, the AVG() function calculates the average salary for that specific occupation.
Filtering (HAVING clause):
Finally, the HAVING clause is applied to the grouped data. It filters out groups where the average salary (avg(salary)) is not greater than $60,000.*/



