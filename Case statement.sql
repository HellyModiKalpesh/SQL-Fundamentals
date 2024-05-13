-- case statement 
-- it will act like if and else statement


SELECT first_name,last_name,age,
CASE 
	when age<30 then 'young'
    when age between 31 and 50 then 'old'
    when age >=50 then 'death bed'
END as age_bracket
 FROM employeement_demographic;
 
select * from employeement_salary;
# requirements: 
-- pay increases and bonus
-- <50000= 5%
-- >50000=7%
-- finance =10%  bonus

select salary,
case
	when salary<50000 then (salary+((salary*5)/100))
    when salary>50000 then (salary+((salary*7)/100))
end as new_salary,
case 
	when dept_id=6 then salary*0.10
end as bonus
from employeement_salary;

