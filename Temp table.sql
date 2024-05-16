-- Temporary  table
 
 -- temporary tables are tables that are only visible to the session that we are created in
 -- there are two ways to initialize temporary table
 
 create temporary table temp_table(
 first_name varchar(50),
 age int,
 gender varchar(10));
 
 INSERT into temp_table values('helly',22,'female');
 select * from temp_table;
 
 
 -- 2 way to create temporary temple
 create temporary table salary_over_50k (
 select * from employeement_salary
 where salary >50000);
 
 select * from salary_over_50k;
 
 -- main difference between temp table and cte is Temporary tables persist beyond the scope of a single query and can be accessed and manipulated across multiple queries within the same session or even by different sessions until the session is connected.
 -- On the other hand, Common Table Expressions (CTEs) are temporary result sets that exist only within the execution scope of a single query. Once the query is completed, the CTE is discarded and not accessible anymore.