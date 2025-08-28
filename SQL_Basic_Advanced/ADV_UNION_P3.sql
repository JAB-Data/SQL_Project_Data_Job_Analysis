/* UNION Operators - Problem Statement THREE

Analyze the monthly demand for skills by counting the number of job postings for 
each skill in the first quarter (January to March), 
utilizing data from separate tables for each month. 
Ensure to include skills from all job postings across these months. 
The tables for the first quarter job postings were created in Practice Problem 6.

HINT:  Use UNION ALL to combine job postings from January, February and March into 
a consolidated dataset.
Apply the EXTRACT function to obtain the year and month from job posting dates, 
even though the month will be implicitly known from the source table.
Group the combined results by skill to summarize the total postings for each skill 
across the first quarter.
Join with the skills dimension table to match skill IDs with skill names.

COUNT the number of job postings for each skill in Q1; */

SELECT 
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS skill_demand,
        EXTRACT(YEAR FROM job_postings_fact.job_posted_date) AS year,  
        EXTRACT(MONTH FROM job_postings_fact.job_posted_date) AS month 
FROM  
    (   -- Subquery to get job_id for Q1 postings (January, February, March)
        SELECT job_id
        FROM job_postings_fact 
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1  -- January
        UNION ALL  -- Combine results for each month
        SELECT job_id
        FROM job_postings_fact 
        WHERE EXTRACT(MONTH FROM job_posted_date) = 2  -- February
        UNION ALL
        SELECT job_id
        FROM job_postings_fact 
        WHERE EXTRACT(MONTH FROM job_posted_date) = 3  -- March
    ) AS Q1_job_postings   -- Alias for subquery
JOIN 
    job_postings_fact 
    ON Q1_job_postings.job_id = job_postings_fact.job_id  -- Join to get the job details
LEFT JOIN 
    skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id  -- Join to get skill info
LEFT JOIN 
    skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id  -- Join to get skill details
GROUP BY 
    skills_dim.skills,
    EXTRACT(YEAR FROM job_postings_fact.job_posted_date), 
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date)
ORDER BY 
    skill_demand DESC; 


