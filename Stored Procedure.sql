-- stored procedure
-- A stored procedure is like a pre-written script or a recipe that is stored in the database.
--  When you need to perform a specific task, instead of writing out all the steps each time, you can just call this stored procedure, and it will execute all the steps for you.

create procedure min_salary()
select * from employeement_salary where salary>=50000;

-- to call this stored procedure
call min_salary();

-- to create multiple query in stored procedure
DELIMITER $$
create procedure min_salary2()
Begin
	select * from employeement_salary where salary>=50000;
	select * from employeement_salary where salary>10000;
End $$
DELIMITER ;
-- DELIMITER $$ :This tells MySQL to treat $$ as the statement terminator instead of the default semicolon.
-- DELIMITER ;: Changes the delimiter back to the default semicolon.
-- here if we use ; as terminator then in the query only first query will be executed and then end so for implementing both queries we replace terminator which is semicolon to $$ and then again restore it back

-- HERE i will get two result by calling this procedure
call min_salary2();

-- stored procedure with parameter

Delimiter $$
create procedure max_salary(id INT)
begin
	select salary from employeement_salary where employee_id=id ;
    end $$
delimiter ;
    
call max_salary(2);

-- Here I have created a stored procedure named max_salary.
--  This stored procedure takes one input parameter, id, which is an integer. 
-- The purpose of this procedure is to retrieve the salary of an employee based on the provided employee ID.