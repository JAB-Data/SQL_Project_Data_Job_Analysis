
/* CTE Problem Statement THREE

Calculate the number of unique skills required by each company. 

DONE_Aim to quantify the unique skills required per company and 
Identify which of these companies offer the highest average salary 
DONE_for positions necessitating at least one skill. 
For entities without skill-related job postings, list it as a zero skill requirement 
and a null salary. 
Use CTEs to separately assess the unique skill count and 
the maximum average salary offered by these companies.

HINTS:  Use two CTEs.  
DONE_The first should focus on counting the unique skills required by each company.
DONE_The second CTE should aim to find the highest average salary offered by these companies.
Ensure the final output includes companies without skill-related job postings. 
This involves use of LEFT JOINs to maintain companies in the result set 
even if they don't match criteria in the subsequent CTEs.
After creating the CTEs, the main query joins the company dimension table 
with the results of both CTEs */

-- Joe's solution
WITH unique_skill_count AS
(
SELECT 
    c_d.company_id,
    c_d.name AS company_name,
    COUNT (DISTINCT skill_id) AS distinct_skill_count
FROM 
    company_dim AS c_d
LEFT JOIN job_postings_fact AS j_p_f ON c_d.company_id = j_p_f.company_id
LEFT JOIN skills_job_dim AS s_j_d ON j_p_f.job_id = s_j_d.job_id
GROUP BY company_name, c_d.company_id
), 
highest_avg_salary AS
(
SELECT 
    company_id,
    AVG(salary_year_avg) AS avg_salary
FROM job_postings_fact
-- WHERE salary_year_avg > 0
GROUP BY company_id
)
SELECT  
    company_name, 
    distinct_skill_count,
    avg_salary
FROM company_dim AS c_d
LEFT JOIN unique_skill_count u_s_c ON c_d.company_id = u_s_c.company_id
LEFT JOIN highest_avg_salary h_a_s ON c_d.company_id = h_a_s.company_id
ORDER BY company_name
;   
-- Luke's solution:
-- Counts the distinct skills required for each company's job posting
WITH required_skills AS (
    SELECT
        companies.company_id,
        COUNT(DISTINCT skills_to_job.skill_id) AS unique_skills_required
    FROM
        company_dim AS companies 
    LEFT JOIN job_postings_fact as job_postings ON companies.company_id = job_postings.company_id
    LEFT JOIN skills_job_dim as skills_to_job ON job_postings.job_id = skills_to_job.job_id
    GROUP BY
        companies.company_id
),
-- Gets the highest average yearly salary from the jobs that require at least one skills 
max_salary AS (
    SELECT
        job_postings.company_id,
        MAX(job_postings.salary_year_avg) AS highest_average_salary
    FROM
        job_postings_fact AS job_postings
    WHERE
        job_postings.job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP BY
        job_postings.company_id
)
-- Joins 2 CTEs with table to get the query
SELECT
    companies.name,
    required_skills.unique_skills_required as unique_skills_required, --handle companies w/o any skills required
    max_salary.highest_average_salary
FROM
    company_dim AS companies
LEFT JOIN required_skills ON companies.company_id = required_skills.company_id
LEFT JOIN max_salary ON companies.company_id = max_salary.company_id
ORDER BY
    companies.name;

SELECT skill_id
FROM skills_dim

SELECT 
    job_id, 
    skill_id,
COUNT(*) 
FROM skills_job_dim
GROUP BY job_id, skill_id; 

