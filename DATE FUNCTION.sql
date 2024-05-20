# Date function in mysql
 -- DATE_ADD(date, INTERVAL expr unit)
-- The DATE_ADD function in SQL is used to add a specified time interval to a date.
-- DATE_ADD('2024-05-19', INTERVAL 1 DAY);
-- so here it will add 1 day to the date 

-- then to find the average by difference and round it upto 3 digit
-- round(avg(a1.timestamp-a2.timestamp),3)

-- there are case when we need to join on multiple column then we can do it by mentioning and 
select * from activity as a1 join activity as a2 on a1.machine_id=a2.machine_id and a1.process_id=a2.process_id and a1.activity_name='start' and a2.activity_name='end' group by a1.machine_id;