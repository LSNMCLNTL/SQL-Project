SELECT 
    skim.skills,
    count(skim.skills) AS SKILL_COUNT,
ROUND(AVG(jp.salary_year_avg), 2) AS average_salary
FROM job_postings_fact AS jp
LEFT JOIN skills_job_dim AS skjob ON jp.job_id = skjob.job_id
INNER JOIN skills_dim AS skim ON skjob.skill_id = skim.skill_id
WHERE 
    jp.job_title_short = 'Data Analyst' 
    AND jp.salary_year_avg > (SELECT AVG(salary_year_avg) FROM job_postings_fact)  AND salary_year_avg IS NOT NULL
GROUP BY skim.skills
ORDER BY average_salary DESC
LIMIT 30
