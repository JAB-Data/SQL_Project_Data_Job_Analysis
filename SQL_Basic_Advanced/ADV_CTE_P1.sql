/* CTE Problem Statement ONE
OBJECTIVE:  Identify companies with the most diverse (unique) job titles. 

Use a CTE to count the number of unique job titles per company, then 
select companies with the highest diversity in job titles.

HINT:  CTE ONE:  Use a CTE to count the distinct number of job titles for each company.
After identifying the number of unique job titles per company, 

JOIN CTE ONE with the company_dim table to get the company names.

Order your final results by the number of unique job titles in descending order 
to highlight the companies with the highest diversity.
Limit your results to the top 10 companies. 

This limit helps focus on the companies with the most significant diversity in job roles. 
Think about how SQL determines which companies make it into the top 10 
when there are ties in the number of unique job titles. 

company_dim:  name (company_id)
job_postings_fact:  job_title (company_id)*/

WITH unique_job_titles AS
(SELECT
    company_id,
    COUNT (DISTINCT job_title) AS distinct_titles
FROM job_postings_fact
GROUP BY company_id
)
SELECT
    NAME,
    unique_job_titles.distinct_titles
FROM company_dim
INNER JOIN unique_job_titles ON company_dim.company_id = unique_job_titles.company_id
ORDER BY distinct_titles DESC
LIMIT 10;



