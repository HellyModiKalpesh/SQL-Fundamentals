#LIMIT

SELECT * FROM perks_recreation.employeement_demographic limit 5;
# it will return first five rows

select * from employeement_demographic order by age desc limit 5;
# it will return first five rows with age set in descending order

select * from employeement_demographic order by age desc limit 2,1;
# here from result it will strt from second row and then consider one row after it

# ALIASING
# rename column

select gender,avg(age) as HIGHEST_AGE from employeement_demographic group by gender having HIGHEST_AGE > 40;
# here we rename avg(age) column a highest_age