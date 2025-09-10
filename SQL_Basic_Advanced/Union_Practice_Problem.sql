/* PRACTICE PROBLEM_UNION OPERATORS 
Get the corresponding skill and skill type for each job posting in Q1.
Includes those without any skills, too.
Why?  Look at the SKILLS and the TYPE for each job in the first quarter that has a
salary > 70000. */

SELECT 
    job_postings_fact.job_id,
    skills,
    type,
    null_skill,
    job_posted_date
FROM (
    SELECT skills, type, skill_id
    FROM skills_dim
    WHERE skills IS NOT NULL
UNION ALL
    SELECT skills, type, skill_id
    FROM skills_dim
    WHERE skills IS NULL
) AS null_skill
LEFT JOIN skills_job_dim ON null_skill.skill_id = skills_job_dim.skill_id
LEFT JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE EXTRACT(MONTH FROM job_posted_date) BETWEEN 1 AND 3 AND
salary_year_avg > 70000;

-- ShatGPT:
SELECT 
    sd.skills,
    sd.type,
    jpf.job_posted_date
FROM job_postings_fact jpf

-- Include all jobs, even those without skills
LEFT JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id

-- Only include jobs from Q1 with salary > 70000
WHERE EXTRACT(MONTH FROM jpf.job_posted_date) BETWEEN 1 AND 3
  AND jpf.salary_year_avg > 70000;


SELECT
    job_id
FROM job_postings_fact,
WITH skills_listed AS 
(
SELECT
    skills,
    type 
FROM 
    skills_dim
) 
WHERE salary_avg_year > 70000








-- job_postings_fact.job_id,
-- LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
-- LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

