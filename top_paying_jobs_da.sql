/*
Which companies offer the highest-paying Data Analyst jobs?
This query helps identify companies that pay the most for remote Data Analyst roles.
*/
SELECT
    job_title,
    get_company_name.company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE
FROM job_postings_fact as jp
LEFT JOIN( 
    SELECT 
    company_id,
    name as company_name
    FROM company_dim 
) get_company_name on jp.company_id = get_company_name.company_id
WHERE 
    salary_year_avg IS NOT NULL 
    AND job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC
LIMIT 20