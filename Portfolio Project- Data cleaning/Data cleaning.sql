 -- Data cleaning
 -- steps:
 -- 1.Remove dupliactes
 -- 2.Standarize the data
 -- 3.Null values or blank values
 -- 4.Remove any columns or rows


 create table layoff_staging
 like layoffs;
-- inser data
insert layoff_staging select * from layoffs;

-- step 1 remove duplicates
-- use row_number to get unique id and if anything is duplicate it will have occurence as 2 or more

select *, row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num from layoff_staging;
-- now here let's find out if we got any duplicate values or not
with duplicate_layoff as (
select *, row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num from layoff_staging
)
select * from duplicate_layoff where row_num >1;
-- we got 5 duplicates rows
-- let's check if it's duplicate or not
select * from layoff_staging where location='London';

-- now here we want to delete duplicate rows where row_num is greather than 1 so what we will do is we will create new table and then get all the rows deleted which are duplicated

CREATE TABLE `world_layoffs`.`layoffs_staging2` (
`company` text,
`location`text,
`industry`text,
`total_laid_off` INT,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
row_num INT
);
Insert into layoffs_staging2
select *, row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num from layoff_staging;

select * from layoffs_staging2 where row_num >1;
Delete from layoffs_staging2 where row_num >1;

-- step 2 STANDARIZE DATA
SELECT * 
FROM world_layoffs.layoffs_staging2;
-- there seems to be spaces in company name so let's trim and update it
update layoffs_staging2 set company=trim(company);

-- if we look at industry it looks like we have some null and empty rows, let's take a look at these
-- here in industry we have certain names as crypto,crypto_currency where it should all have crypto as name so let's update

select * from layoffs_staging2 where industry like'crypto%';
-- so now let's replace it
update layoffs_staging2 set industry='Crypto' where industry like'crypto%';
-- here in country column data has a full stop after it so let's fix it
select * from layoffs_staging2 where country like 'United States%.%';
update layoffs_staging2 set country='United States' where country like 'United States%.%';
-- 2 nd method to trim . is 
select distinct country,trim(trailing '.' from country) from layoffs_staging2;
-- update it 
update layoffs_staging2 set country=trim(trailing '.' from country);

-- here date is text format so we need to convert in into date column
select date ,STR_TO_DATE(date,'%m/%d/%y') from layoffs_staging2;

UPDATE layoffs_staging2
SET date = STR_TO_DATE(date, '%m/%d/%Y');
-- we did change the format but it's data type is still text so let's change it 

alter table layoffs_staging2 modify column date  DATE;

-- STEP 3 NULL VALUES AND BLANK VALUES

select * from layoffs_staging2;

-- here there are null values in total_laid_off and percentage_laid_Off

select * from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;

select  * from layoffs_staging2 where industry is null or industry='';
-- in industry there are null values present in it so let's fix it

select * from layoffs_staging2 where company='Airbnb';
-- here in company as airbnb we get industry as travel and then another entry is blank so let's update all the blank value as travel for airbnb and for another also

select * from layoffs_staging2 t1 join layoffs_staging2 t2 on t1.company=t2.company and t1.location=t2.location
where (t1.industry is null or t1.industry ='') and t2.industry is not null;

-- first update all the blank value with null values
update layoffs_staging2 set industry = null where industry='';

-- now let's replace it

update layoffs_staging2 t1 join layoffs_staging2 t2 on t1.company=t2.company and t1.location=t2.location set t1.industry=t2.industry where t1.industry is null and t2.industry is not null;

-- now we will delete that row where total_laid off and percentage_laid_off is null
delete from  layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;
-- now we don't need row_num also 
alter table layoffs_staging2 drop column row_num;

select * from layoffs_staging2;