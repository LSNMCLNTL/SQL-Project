
WITH top_paying_jobs AS (
    SELECT
        job_id,
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
        AND job_work_from_home = TRUE 
        AND job_title_short = 'Data Analyst'
    ORDER BY salary_year_avg DESC
    LIMIT 20
)
SELECT *, skim.skills
FROM top_paying_jobs toppay
INNER JOIN skills_job_dim as skjob on toppay.job_id=skjob.job_id
INNER JOIN skills_dim as skim on skjob.skill_id = skim.skill_id

/*
Query for counting the occurrences of each skill 
SELECT
skills as skill_name,
COUNT(skjob.job_id) as skill_count
FROM top_paying_jobs toppay
INNER JOIN skills_job_dim as skjob on toppay.job_id=skjob.job_id
INNER JOIN skills_dim as skim on skjob.skill_id = skim.skill_id
GROUP BY skill_name
ORDER BY skill_count DESC
*/
