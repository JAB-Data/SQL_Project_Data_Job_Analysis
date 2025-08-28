-- Find the COUNT of the number of REMOTE JOB POSTINGS per SKILL
-- DISPLAY the TOP 5 skills BY their DEMAND in remote jobs
-- Include SKILL ID, NAME and COUNT of POSTING REQUIRING the SKILL 
-- job_postings_fact:  job_id(sk_jb_dim), job_title & job_work_from_home
-- skills_dim:  skill_id(sk_jb_dim) & skills
-- skills_job_dim:  job_id(jb_id) & skill_id(sk_dim)

SELECT 
    sk_jb_dim.skill_id, 
    skills_dim.skills,
    COUNT(*) skill_demand
FROM job_postings_fact AS jb_postings
INNER JOIN skills_job_dim AS sk_jb_dim ON jb_postings.job_id = sk_jb_dim.job_id
INNER JOIN skills_dim ON sk_jb_dim.skill_id = skills_dim.skill_id
WHERE   job_work_from_home = TRUE AND
        job_title = 'Data Analyst' -- added by Luke
    
GROUP BY 
    sk_jb_dim.skill_id,
    skills_dim.skills
ORDER BY skill_demand DESC
LIMIT 10;


/* SELECT skills,
COUNT (*)
FROM skills_dim
GROUP BY skill_demand
ORDER BY skill_demand
LIMIT 25 */