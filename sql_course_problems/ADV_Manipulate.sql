/*job_id	job_title	company_name	post_date
-- 1	Data Scientist	Tech Innovations	January 1, 2023
2	Machine Learning Engineer	Data Driven Co	January 15, 2023
3	AI Specialist	Future Tech	February 1, 2023 */ 

INSERT INTO data_science_jobs (job_id, job_title, company_name, post_date)
VALUES 
('DA23', 'Data Analyst', 'Breakdown Solutions', '2025-09-15'),
('DS03', 'Data Scientist', 'Data Driven', '2026-01-15'),
('ML34', 'Machine Learning Engineer', 'Tech Innovations', '2025-11-01'),
('AI56','AI Specialist', 'Future Solutions', '2025-10-15');

ALTER TABLE data_science_jobs 
ALTER COLUMN remote SET DEFAULT FALSE;

-- insert a new row with the following:

INSERT INTO data_science_jobs 
(job_id, job_title, company_name, posted_on) 
VALUES (4, 'Data Scientist', 'Google', '2023-02-05');


DELETE FROM data_science_jobs
WHERE job_id = '4';

ALTER TABLE data_science_jobs
ALTER COLUMN remote SET DEFAULT FALSE;

INSERT INTO data_science_jobs
(job_id, job_title, company_name, posted_on, remote)
VALUES ('DS004', 'Data Scientist', 'Data Driven', '2026-01-15', TRUE);

INSERT INTO data_science_jobs
(job_id, job_title, company_name, posted_on, remote)
VALUES ('DS04', 'Data Scientist', 'Data Driven', '2026-01-15', TRUE);

UPDATE data_science_jobs
SET remote = TRUE
WHERE job_id = AI56;

ALTER TABLE data_science_jobs
DROP company_name;

UPDATE data_science_jobs
SET remote = TRUE
WHERE job_id = 'AI56';

DROP TABLE data_science_jobs;

SELECT *
FROM data_science_jobs;