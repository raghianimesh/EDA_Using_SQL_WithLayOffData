
# ------------------------ Exploratory Data Analysis Project -------------------------------------


SELECT * FROM layoff_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off) FROM layoff_staging2;

SELECT * FROM layoff_staging2 where percentage_laid_off = 1
order by total_laid_off desc;

SELECT * FROM layoff_staging2 where percentage_laid_off = 1
order by funds_raised_millions desc;

SELECT company,SUM(total_laid_off) FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`date`) FROM layoff_staging2;

SELECT industry,SUM(total_laid_off) FROM layoff_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country,SUM(total_laid_off) FROM layoff_staging2
GROUP BY country
ORDER BY 2 DESC;


SELECT `date`,SUM(total_laid_off) FROM layoff_staging2
GROUP BY `date`
ORDER BY 2 DESC;

SELECT YEAR(`date`),SUM(total_laid_off) FROM layoff_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`,6,2) AS `MONTH`, SUM(total_laid_off) FROM layoff_staging2
GROUP BY `MONTH`;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) FROM layoff_staging2
GROUP BY `MONTH`;

WITH Rolling_total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS tot_off FROM layoff_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`,tot_off, SUM(tot_off) OVER(ORDER BY `MONTH`) AS
rolling_total FROM Rolling_total;

SELECT company,YEAR(`date`), SUM(total_laid_off) FROM layoff_staging2
GROUP BY company , `date`
ORDER BY 3 DESC ;

WITH company_laid AS
(
SELECT company, YEAR(`date`) AS `YEAR`, SUM(total_laid_off) AS tot_off FROM layoff_staging2
GROUP BY company,`YEAR`
)
SELECT *, dense_rank() OVER(PARTITION BY `YEAR` ORDER BY tot_off DESC) FROM company_laid
WHERE `YEAR` IS NOT NULL;

