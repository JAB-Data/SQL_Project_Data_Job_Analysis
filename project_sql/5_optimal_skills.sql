/*
What are the most optimal skills to learn, i.e. high pay and demand?
- Identify skills in high demand and associated with high-average salaries for data-analyst roles
- Concentrates on remote positions with specified salaries
- WHY?  Targets skills that offer high job security (high demand) and financial benefits (high salary),
offering strategic insights for career development in data analysis
*/

WITH skill_demand AS 
(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_dim.skills) AS demand_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short LIKE '%Data Analyst%'
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id,
        skills_dim.skills
),

top_paying_skills AS 
(
    SELECT 
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short LIKE '%Data Analyst%'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id
)
SELECT 
    skill_demand.skill_id,
    skill_demand.skills,
    demand_count,
    avg_salary
FROM 
    skill_demand
INNER JOIN top_paying_skills AS t_p_s 
    ON skill_demand.skill_id = t_p_s.skill_id
ORDER BY
    demand_count DESC,
    skill_demand.skills DESC, 
    avg_salary DESC
LIMIT 25;





   
