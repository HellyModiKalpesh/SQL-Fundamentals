select gender,avg(salary) from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id group by gender;

# now here  i can use window function instead of group by 

select gender,avg(salary) over() from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id;
# here it perform aggregation without grouping. Here it find averge salary without any partition means it will consider all the rows and then find acerage

select gender,avg(salary) over(partition by gender)from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id;
-- here it performed average salary based on partition by gender.

select gender,dem.first_name,dem.last_name,salary,sum(salary) over(partition by gender) from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id;
-- first it will take all rows and then make a group by gender and then it will calculate sum of slaries

select dem.employee_id,gender,dem.first_name,dem.last_name,salary,sum(salary) over(partition by gender order by dem.employee_id) as roll_over from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id;
-- in SQL, when you want to calculate a running total using a window function, it's essential to specify the order of rows using the ORDER BY clause within the OVER() function.
-- running total means cummulative sum

# ROW NUMBER
-- The ROW_NUMBER() function in SQL assigns a unique sequential integer to each row within a partition of a result set, typically based on a specified ordering.

select dem.employee_id,gender,dem.first_name,dem.last_name,salary,
row_number() over()
 from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id;
-- it will assign each unique number

select dem.employee_id,gender,dem.first_name,dem.last_name,salary,
row_number() over( partition by gender)
 from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id;
 -- This query assigns a row number to each row within its gender partition. Since there's no specified order within the OVER() clause, the database will default to an arbitrary order.
-- Each row number will start from 1 for each gender group.
 
 select dem.employee_id,gender,dem.first_name,dem.last_name,salary,
row_number() over( partition by gender order by salary desc)
 from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id;
 -- This query assigns a row number to each row within its gender partition, ordered by salary in descending order (ORDER BY salary DESC).
-- The row numbers will start from 1 for each gender group, with rows having higher salaries receiving lower row numbers within each partition.

# rank
select dem.employee_id,gender,dem.first_name,dem.last_name,salary,
row_number() over( partition by gender order by salary desc),
rank()over(partition by gender order by salary desc)
 from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id;
 -- This query partitions the result set by gender and ranks employees within each gender group based on their salary in descending order. Each row will have a distinct row number and rank within its gender partition. If there are ties in salary within a gender group, multiple rows may have the same rank.
 
 # dense rank
 select dem.employee_id,gender,dem.first_name,dem.last_name,salary,
row_number() over( partition by gender order by salary desc) as row_num,
rank()over(partition by gender order by salary desc)as rank_num,
dense_rank()over(partition by gender order by salary desc) as dense_num
 from employeement_demographic dem join employeement_salary sal on dem.employee_id=sal.employee_id;
 -- this is output 
-- difference between rank and dense rank is # 
 /*salary, row_num,rank,denserank
 '75000', '1', '1', '1'
'60000', '2', '2', '2'
 '55000', '3', '3', '3'
'25000', '4', '4', '4'
'90000', '1', '1', '1'
'70000', '2', '2', '2'
'65000', '3', '3', '3'
 '57000', '4', '4', '4'
 '50000', '5', '5', '5'
'50000', '6', '5', '5'
'20000', '7', '7', '6'*/
-- The primary difference between RANK() and DENSE_RANK() lies in how they handle ties. 
-- RANK() skips the next rank after tied ranks, while DENSE_RANK() maintains consecutive rank values, ensuring there are no gaps. 