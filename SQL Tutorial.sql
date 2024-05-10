select * from perks_recreation.employeement_demographic;
select first_name,last_name,birth_date,age,age+10 from employeement_demographic;
select age,(age*10+10)-23 from employeement_demographic;
select distinct  first_name from employeement_demographic;
select  distinct gender,first_name from employeement_demographic;
select * from employeement_salary;
select * from employeement_salary where first_name='leslie';
select * from employeement_salary where salary>50000;
select * from employeement_salary where salary>=50000;
select * from employeement_salary where salary<50000;
select * from employeement_salary where salary<=50000;
select * from employeement_demographic where gender='female';
select * from employeement_demographic where gender !='female';
select * from employeement_demographic where birth_date >'1985-01-01';
-- AND OR NOT --Logical operators--
select * from employeement_demographic where birth_date >'1985-01-01' and gender='female';
select * from employeement_demographic where birth_date >'1985-01-01' or gender='male';

-- LIKE STATEMENT--
-- % and __
select * from employeement_demographic where first_name like 'jer%';
-- jer at beginning--

select * from employeement_demographic where first_name like '%er%';
-- it means anything in beginning but it should contain er in middle and anything in the end --

select * from employeement_demographic where first_name like 'a%';
-- it means first name starting with a --

select * from employeement_demographic where first_name like '%a';
-- it means first name ending with a --

select * from employeement_demographic where first_name like 'a__';
-- it means starting with a and then two character at the end --

select * from employeement_demographic where first_name like 'a___';
-- it means starting with a and then three character at the end --

-- we can use two operators of like at simultaneosly
select * from employeement_demographic where first_name like 'a___%';
-- it means starting with a then it should have three characters and then anything in the end--

select * from employeement_demographic where birth_date like '%03%';
-- it means anything in the before but it should contain 03 and then anything in the end --












  


