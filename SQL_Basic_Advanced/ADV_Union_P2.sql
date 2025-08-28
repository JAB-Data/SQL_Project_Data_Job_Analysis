/*  
UNION Operators - Problem Statement TWO
Retrieve the job id, job title short, job location, job via, skill and skill type 
for each job posting from the first quarter (January to March). 
Using a subquery to combine job postings from the first quarter 
(these tables were created in the Advanced Section - Practice Problem 6 Video) 
Only include postings with an average yearly salary greater than $70,000.

HINT:  Use UNION ALL to combine job postings from January, February and March 
into a single dataset.
Apply a LEFT JOIN to include skills information, allowing for 
job postings without associated skills to be included.
Filter the results to only include job postings with an average yearly salary above $70,000.  
*/

SELECT 
    job_postings_fact.job_id,
    job_postings_fact.job_title_short,
    job_postings_fact.job_location,
    job_postings_fact.job_via,
    skills_dim.skills,
    skills_dim.type 
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
WHERE 
    job_postings_fact.salary_year_avg > 70000  -- Filter for salary > 70000
ORDER BY 
    job_postings_fact.job_id;  -- Sort by job_id


