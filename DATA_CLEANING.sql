select *
from world_layoffs.layoffs;

-- 1. Remove duplicates
-- 2. Standardize Data
-- 3. Null values or blank values
-- 4. Remove any columns

USE `world_layoffs`;

CREATE TABLE world_layoffs.layoffs_staging
LIKE world_layoffs.layoffs;

select *
from world_layoffs.layoffs_staging;


-- insert from one table to another
INSERT world_layoffs.layoffs_staging
SELECT *
FROM world_layoffs.layoffs;

SELECT *,
row_number() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
FROM world_layoffs.layoffs_staging;


WITH duplicate_cte AS
(
SELECT *,
row_number() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

select *
from world_layoffs.layoffs_staging
where company='Casper';

delete 
from duplicate_cte
where row_num > 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

insert into layoffs_staging2
SELECT *,
row_number() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;

delete from
layoffs_staging2
where row_num > 1;
