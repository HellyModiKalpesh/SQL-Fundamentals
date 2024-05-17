-- TRIGGERS AND EVENTS
-- TRIGGERS
-- A trigger is a database object that automatically performs a specific action in response to certain events on a particular table or view in the database.
-- These events can include INSERT, UPDATE, DELETE operations, or a combination of them
-- Types of Triggers: MySQL supports BEFORE and AFTER triggers, which execute before or after the triggering event, respectively.

# let's create a triggere when any new entry is added in employeement_salary table then it should automatically added in employeement_demographic table

delimiter $$
create trigger employee_insert
	after insert on employeement_salary
    for each row
begin
	insert into employeement_demographic(employee_id,first_name,last_name)values(new.employee_id,new.first_name,new.last_name);
    end $$
delimiter ;

-- let me insert an entry into employeement_salary 
insert into employeement_salary values(13,'helly','modi','data analyst',100000,4);
-- here this entry employee_id,first_name and last_name is also stored in demographic table

## events
-- An event is a scheduled task that is executed automatically according to a specified schedule.
-- Events are useful for performing routine maintenance tasks, such as backups, data purging, or generating reports at predefined intervals.

-- let's create an event in employeement_demographic table where if age is > 60 then it should delete and this event is scheduled every 30 seconds

delimiter $$
create event employee_delete
on schedule every 30 second
Do 
begin
  delete from employeement_demographic where age> 60;
  end $$
  delimiter ;
  
  -- to see events
  show variables like 'event%';