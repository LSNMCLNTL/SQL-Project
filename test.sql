WITH skill_count AS (
    SELECT
        skjob.job_id,
        skim.skills      
    FROM skills_job_dim skjob
    INNER JOIN skills_dim skim ON skjob.skill_id = skim.skill_id
)
SELECT  
    skcount.skills,
    COUNT(quarter1.job_id) AS job_skill_count
FROM( 
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM feb_jobs
    UNION ALL
    SELECT * FROM march_jobs
)quarter1
INNER JOIN skill_count skcount ON quarter1.job_id = skcount.job_id
WHERE quarter1.salary_year_avg > 70000
GROUP BY skcount.skills  -- Fixed missing GROUP BY
ORDER BY job_skill_count DESC