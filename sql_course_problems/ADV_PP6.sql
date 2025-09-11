-- FIND the companies that have the most job openings
-- Get the total number of job postings per company id (job_postings_fact)
-- Return the total number of jobs with the company name (company_dim)

WITH job_openings AS 
(
SELECT 
        company_id,
        COUNT (*) AS job_count
FROM 
        job_postings_fact
GROUP BY 
        company_id
) 
SELECT 
        name,
        job_count
FROM 
        job_openings
LEFT JOIN company_dim
ON job_openings.company_id = company_dim.company_id
ORDER BY job_count DESC;




