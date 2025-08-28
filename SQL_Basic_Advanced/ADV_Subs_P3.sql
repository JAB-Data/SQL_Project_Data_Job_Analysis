    /* SUBQUERIES Problem Statement THREE

    Find companies that offer an average salary > overall average yearly salary 
    of all job postings. 
    Use SUBQUERIES to select companies with an average salary >  
    the overall average salary (which is another subquery).

    HINT:  Start by separating the task into two main steps.
    Calculating the overall average salary
    Identifying companies with higher averages.
    Use a subquery (subquery 1) to find the average yearly salary across all job postings. 
    Then join this subquery onto the company_dim table.
    Use another subquery (subquery 2) to establish the overall average salary, 
    which will help in filtering in the WHERE clause companies with higher average salaries.
    Determine each company's average salary (what you got from subquery 1) 
    and compare it to the overall average you calculated (subquery 2). 
    Focus on companies that greater than this average.*/

-- Joe's solution
SELECT 
    company_dim.name
FROM 
    company_dim
INNER JOIN 
(
    SELECT 
        company_id,
        AVG(salary_year_avg) AS avg_salary
    FROM 
        job_postings_fact
    GROUP BY         
        company_id
) AS sb_comp_avg_sal 
    ON sb_comp_avg_sal.company_id = company_dim.company_id
WHERE 
    sb_comp_avg_sal.avg_salary > 
(
        SELECT 
            AVG(salary_year_avg)
        FROM 
            job_postings_fact
);

-- Luke's solution
SELECT 
    company_dim.name
FROM 
    company_dim
INNER JOIN (
    -- Subquery to calculate average salary per company
    SELECT 
        company_id, 
        AVG(salary_year_avg) AS avg_salary
    FROM job_postings_fact
    GROUP BY company_id
    ) AS company_salaries ON company_dim.company_id = company_salaries.company_id
-- Filter for companies with an average salary greater than the overall average
WHERE company_salaries.avg_salary > (
    -- Subquery to calculate the overall average salary
    SELECT AVG(salary_year_avg)
    FROM job_postings_fact
);








