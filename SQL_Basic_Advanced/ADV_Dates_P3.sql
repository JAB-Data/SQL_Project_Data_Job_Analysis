
SELECT  
    job_id,
    AVG(salary_year_avg),
    AVG(salary_hour_avg),
WHERE   
    EXTRACT(MONTH) FROM job_postings_fact = 6, 7, 8, 9, 10, 11, 12
    EXTRACT(YEAR) >=2023
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type;
    
SELECT
    company_dim.name AS company_name,
    COUNT(job_id) AS job_count
FROM 
    job_postings_fact AS j_p_f
INNER JOIN
    company_dim ON j_p_f.company_id = company_dim.company_id
WHERE
    j_p_f.job_health_insurance = TRUE AND
    EXTRACT(QUARTER FROM job_posted_date) = 2 AND
    EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY 
    company_dim.name
HAVING
    COUNT(job_id) >= 1
ORDER BY job_count DESC;