/*
What are the top skills based on salary?
- Look at the average salary associated with each skill for data analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why?  If reveals how different skills impact salary levels for data analysts and helps
  helps identify the most financially rewarding skills to acquire or improve
  */

      SELECT 
          skills_dim.skills,
          ROUND(AVG(salary_year_avg), 0) AS avg_salary
      FROM 
          job_postings_fact
      INNER JOIN
          skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
      INNER JOIN
          skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
      WHERE 
          job_title_short LIKE '%Data Analyst%' AND
          salary_year_avg IS NOT NULL AND
          job_work_from_home = TRUE
      GROUP BY
          skills_dim.skills
      ORDER BY avg_salary DESC
      LIMIT 25

/*
Beyond the Requisite Data Analyst Skillset

1. Python is tied to higher salaries.  
Skills like Pandas and Flask consistently appear in top-paying roles, 
signaling a preference for analysts with coding capabilities.

2. Machine learning frameworks correlate with top-tier compensation
Tools like TensorFlow, Keras, and PyTorch frequently appear in the highest-paying analyst roles.

3. Developer tools show up in higher-paying roles
Skills like GitLab, Bitbucket, and Linux are common among top-paying data analyst jobs, 
which translates to a need for collaboration and version-control skills.
*/