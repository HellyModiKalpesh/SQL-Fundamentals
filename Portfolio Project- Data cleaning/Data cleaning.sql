 -- Data cleaning
 -- steps:
 -- 4.remove columns
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
