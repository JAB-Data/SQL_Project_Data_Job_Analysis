/*  What skills are required for the top paying data analyst jobs?
- Use the top 10, highest-paying Data Analyst jobs from the first query.
- Add the specific skills required for these roles.
- Why?  It provides a detailed look at which high-paying jobs demand certains skills,
    helping job seekers understand, which skills to develop that align with top salaries. */

WITH top_paying_jobs AS
(
    SELECT
        job_id,
        name as company_name,
        job_title,
        -- job_location,
        -- job_schedule_type,
        salary_year_avg
        -- job_posted_date
    FROM
        job_postings_fact AS j_p_f
        LEFT JOIN company_dim ON j_p_f.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        -- job_title ILIKE '%data analyst%' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    ORDER BY salary_year_avg DESC
)
SELECT
    t_p_j.job_id,
    company_name,
    t_p_j.job_title,
    t_p_j.salary_year_avg,
    skills,
    type 
FROM 
    top_paying_jobs AS t_p_j
LEFT JOIN skills_job_dim AS s_j_d ON t_p_j.job_id = s_j_d.job_id
INNER JOIN skills_dim ON s_j_d.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
;

/*  Skills insights for top paying Data Analyst jobs.

CONCLUSION
The skills landscape for high paying data analyst roles in 2023 emphasizes SQL and Python 
as foundational, with strong demand for visualization tools (Tableau, Power BI, Excel) 
and emerging cloud technologies (Snowflake, AWS, Azure). Statistical tools like R and SAS 
remain relevant in specialized sectors, while collaboration tools indicate the importance of 
teamwork in senior roles. Aspiring analysts should prioritize these skills to maximize 
their employability and salary potential. */
