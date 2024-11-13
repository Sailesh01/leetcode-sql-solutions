WITH cte AS
(SELECT *, RANK() OVER(PARTITION BY department_id ORDER BY mark DESC) as rnk, COUNT(*) OVER(PARTITION BY department_id) as student_count
FROM Students)

SELECT student_id, department_id, COALESCE(ROUND((rnk-1)*100/(student_count - 1),2),0) as percentage
FROM cte
