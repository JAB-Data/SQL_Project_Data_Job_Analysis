/*  What are the top paying, data-analyst jobs?
Identify the top 10 highest paying data analyst roles that are available remotely.
Focuses on job postings with specified salaries (remove nulls).
Why?  Highlight the top-paying opportunities for data analysts, 
offering insights into employment opportunities. */

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

-- With total number of job postings.
SELECT
    job_id,
    job_title,
    job_location,
    job_work_from_home,
    salary_year_avg,
    job_posted_date,
    COUNT(*) OVER () AS total_job_postings
FROM job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
    AND job_title ILIKE '%data analyst%'
    AND job_work_from_home = TRUE
ORDER BY salary_year_avg DESC;

-- Job postings by job title.
SELECT
    job_title,
    COUNT(*) AS total_job_postings
FROM job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
    AND job_title ILIKE '%data analyst%'
    AND job_work_from_home = TRUE
GROUP BY job_title
ORDER BY total_job_postings DESC;


