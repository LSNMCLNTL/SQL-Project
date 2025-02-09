SELECT 
    skim.skill_id, 
    skim.skills,  
    COUNT(jp.job_id) AS demand_count,
    ROUND(AVG(jp.salary_year_avg), 2)AS average_salary
FROM job_postings_fact jp 
LEFT JOIN skills_job_dim AS skjob ON jp.job_id = skjob.job_id
INNER JOIN skills_dim AS skim ON skjob.skill_id = skim.skill_id
WHERE 
    jp.job_title LIKE '%Data Analyst%'
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = TRUE
GROUP BY 
    skim.skill_id 
HAVING 
    COUNT(jp.job_id) > 10
ORDER BY 
    average_salary DESC,
    demand_count DESC
LIMIT 20