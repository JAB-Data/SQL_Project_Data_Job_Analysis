/*What are the top paying, data-analyst jobs?
- Identify the top 100 highest paying data analyst roles that are available remotely.
- Focuses on job postings with specified salaries (removing nulls).
- WHY?  Highlight the top-paying opportunities for data analysts, 
- offering insights into employment opportunities.*/

SELECT
    job_id,
    name as company_name,
    job_title,
    job_location,
    job_schedule_type,
    job_work_from_home,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    -- job_title ILIKE '%data analyst%' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
ORDER BY salary_year_avg DESC
LIMIT 100;



