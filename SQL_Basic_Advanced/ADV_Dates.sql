/* DATE FUNCTIONS Problem Statement ONE
Find the average salary both yearly (salary_year_avg) and 
hourly (salary_hour_avg) 
for job postings using the job_postings_fact table 
that were posted after June 1, 2023. 
Group the results by job schedule type. 
Order by the job_schedule_type in ascending order.

Hint
Calculate average salaries by using the AVG function 
on both salary_year_avg and salary_hour_avg.
Filter postings with WHERE for dates after June 1, 2023,
Group the results with job_schedule_type.
Use job_schedule_type for ORDER BY.*/

        SELECT  
            job_schedule_type AS job_type,
            AVG(salary_year_avg) AS average_yearly_salary,
            AVG(salary_hour_avg) AS average_hourly_salary
        FROM
            job_postings_fact
        WHERE   
            job_posted_date > '2023-06-01'
        GROUP BY
            job_schedule_type
        ORDER BY
            job_schedule_type;

/* DATE FUNCTIONS Problem Statement TWO
Count the number of job postings for each month, 
adjusting the job_posted_date to be in 'America/New_York' time zone 
before extracting the month. 
Assume the job_posted_date is stored in UTC. 
Group by and order by the month.

Hint
Use the EXTRACT(MONTH FROM ...) function to get the month 
from job_posted_date and within this EXTRACT convert it to 
the 'America/New_York' time zone using AT TIME ZONE 
(don’t forget to assume default is in ‘UTC’).
COUNT the number of job postings
GROUP BY the extracted month
ORDER BY the month. */

SELECT
    COUNT(job_id) AS postings_count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' 
    AT TIME ZONE 'America/New_York') AS month
FROM job_postings_fact
GROUP BY month
ORDER BY month;

SELECT*
FROM job_postings_fact
LIMIT 25;

/* DATE FUNCTIONS Problem Statement THREE
Find companies (include company name) that have posted jobs offering health insurance, 
where these postings were made in the second quarter of 2023. 
Use date extraction to filter by quarter. 
And order by the job postings count from highest to lowest.
HINT:  Join job_postings_fact and company_dim on company_id to match jobs to companies.
Use the WHERE clause to filter for jobs with job_health_insurance column.
Use EXTRACT(QUARTER FROM job_posted_date) to filter for postings in the second quarter.
Group results by company_name.
Count the number of job postings per company with COUNT(job_id).
Use HAVING to include only companies with at least one job posting.
ORDER BY the job postings count in descending order to get highest → lowest.*/

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


SELECT*
FROM job_postings_fact
LIMIT 25;

SELECT *
FROM company_dim;
