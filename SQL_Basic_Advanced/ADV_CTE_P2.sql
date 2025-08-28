/*  CTE Problem Statement 2
Explore job postings by listing job id, job titles, company names and their average salary rates, 
while categorizing these salaries relative to the average in their respective countries. 

Include the month of the job posted date. 
Use CTEs, conditional logic and date functions to COMPARE INDIVIDUAL salaries with NATIONAL averages.

HINT:  
Define a CTE to calculate the average salary for each country. 
This will serve as a foundational dataset for comparison.

Within the main query, use a CASE WHEN statement 
to CATEGORIZE each salary as 'Above Average' or 'Below Average' based on its comparison (>) 
to the country's average salary calculated in the CTE.

To include the month of the job posting, use the EXTRACT function 
on the job posting date within your SELECT statement.

JOIN the job postings data (job_postings_fact) with the CTE 
to compare individual salaries to the average. 
[DONE] Additionally, JOIN with the company dimension (company_dim) table 
to get company names linked to each job posting. */  

-- Joe's solution
WITH avg_salary_country AS (
    SELECT 
        job_postings_fact.job_country, 
        AVG(salary_year_avg) AS country_avg_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY job_postings_fact.job_country
)
SELECT
    NAME AS company_name,
    job_id, 
    job_title, 
    TO_CHAR(job_posted_date, 'Month') AS posting_month,
    -- EXTRACT(MONTH FROM job_postings.job_posted_date) AS posting_month,
    avg_salary_country.job_country,
    salary_year_avg AS job_salary,
    avg_salary_country.country_avg_salary,
    CASE
        WHEN salary_year_avg > country_avg_salary THEN 'Above Average'
        WHEN salary_year_avg < country_avg_salary THEN 'Below Average'
    END AS above_below_avg
FROM job_postings_fact
INNER JOIN avg_salary_country ON job_postings_fact.job_country = avg_salary_country.job_country
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE salary_year_avg IS NOT NULL
ORDER BY above_below_avg
;

-- Luke's solution
-- gets average job salary for each country
WITH avg_salaries AS (
    SELECT 
        job_country, 
        AVG(salary_year_avg) AS avg_salary
    FROM job_postings_fact
    GROUP BY job_country
)
SELECT
    -- Gets basic job info
    job_postings.job_id,
    job_postings.job_title,
    companies.name AS company_name,
    job_postings.salary_year_avg AS salary_rate,
    -- categorizes the salary as above or below average the average salary for the country
    CASE
        WHEN job_postings.salary_year_avg > avg_salaries.avg_salary
        THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_category,
    -- gets the month and year of the job posting date
    EXTRACT(MONTH FROM job_postings.job_posted_date) AS posting_month
FROM
    job_postings_fact as job_postings
INNER JOIN
    company_dim as companies ON job_postings.company_id = companies.company_id
INNER JOIN
    avg_salaries ON job_postings.job_country = avg_salaries.job_country
ORDER BY
    -- Sorts it by the most recent job postings
    posting_month desc;

-- Daniela Becerril
WITH avg_per_country AS (
SELECT
job_country,
AVG(salary_year_avg) AS avg_country_salary
FROM job_postings_fact
GROUP BY
job_country
)

SELECT
company_dim.name,
job_postings_fact.job_id,
job_postings_fact.job_title,
avg_per_country.job_country,
job_postings_fact.salary_year_avg,
avg_per_country.avg_country_salary,
CASE
WHEN job_postings_fact.salary_year_avg > avg_per_country.avg_country_salary THEN 'above the average'
WHEN job_postings_fact.salary_year_avg = avg_per_country.avg_country_salary THEN 'on the average'
ELSE 'below the average'
END AS salary_vs_country_category,
EXTRACT(MONTH FROM job_postings_fact.job_posted_date) AS month
FROM job_postings_fact
LEFT JOIN avg_per_country ON job_postings_fact.job_country = avg_per_country.job_country
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
ORDER BY
month DESC;


