/* OBJECTIVE:  Determine the size category ('Small', 'Medium', or 'Large') 
for each company by first identifying the number of job postings they have. 

Use a SUBQUERY to calculate the total job postings per company
Implement a SUBQUERY to AGGREGATE job counts per company
AGGREGATE job counts per company in the SUBQUERY   
•	This involves GROUPING BY COMPANY and COUNTING JOB POSTINGS.
•	Use this subquery in the FROM clause of your main query

THEN – classify them based on size
MAIN QUERY – categorize companies based on the aggregated job counts from 
the subquery with a CASE statement.

•	A company is considered 'Small' if it has less than 10 job postings, 
•	'Medium' if the number of job postings is between 10 and 50
•	'Large' if it has more than 50 job postings
•	Determine the size category for each company BY 
    the number of job postings (job_id)*/

SELECT *
FROM company_dim
SELECT *
FROM job_postings_fact


-- Joe's solution:
SELECT
  company_dim.name,
  CASE 
    WHEN jb_pstngs < 10 THEN 'Small'
    WHEN jb_pstngs BETWEEN 10 AND 50 THEN 'Medium'
    ELSE 'Large'
  END AS company_size
FROM 
(
  SELECT company_id, COUNT(job_id) AS jb_pstngs
  FROM job_postings_fact
  GROUP BY company_id
) sub_jb_pstngs
INNER JOIN company_dim ON sub_jb_pstngs.company_id = company_dim.company_id
ORDER BY company_dim.company_id;

-- Luke's solution:
SELECT
   company_id,
   name,
   -- Categorize companies
   CASE
       WHEN job_count < 10 THEN 'Small'
       WHEN job_count BETWEEN 10 AND 50 THEN 'Medium'
       ELSE 'Large'
   END AS company_size
FROM (
   -- Subquery to calculate number of job postings per company 
   SELECT
       company_dim.company_id,
       company_dim.name,
       COUNT(job_postings_fact.job_id) AS job_count
   FROM company_dim
   INNER JOIN job_postings_fact 
       ON company_dim.company_id = job_postings_fact.company_id
   GROUP BY
       company_dim.company_id,
       company_dim.name
) AS company_job_count;





