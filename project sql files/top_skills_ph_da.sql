/*
What are the top 10 most in-demand skills for Data Analyst jobs in the Philippines?
*/
WITH remote_jobs AS (
    SELECT
    job_id, 
    job_title 
    FROM job_postings_fact jp
    WHERE job_title_short = 'Data Analyst' and job_country ='Philippines'
)
SELECT
    skim.skills AS skill_name,
    COUNT(skjob.job_id) AS skcount
    FROM skills_job_dim skjob
    INNER JOIN remote_jobs remote1 ON skjob.job_id = remote1.job_id
    INNER JOIN skills_dim AS skim ON skjob.skill_id=skim.skill_id
    GROUP BY skim.skills
    ORDER BY skcount DESC
    LIMIT 10;

SELECT 
jp.job_country,
COUNT(jp.job_country)
FROM job_postings_fact jp
GROUP BY jp.job_country
ORDER BY COUNT(jp.job_country) DESC
