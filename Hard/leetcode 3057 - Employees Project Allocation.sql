WITH cte AS
(SELECT e.employee_id, p.project_id, e.name, p.workload, AVG(p.workload) OVER(PARTITION BY e.team) AS avg_workload
FROM Project p
LEFT JOIN Employees e
ON p.employee_id = e.employee_id)

SELECT employee_id, project_id, name as employee_name, workload as project_workload
FROM cte
WHERE workload > avg_workload
ORDER BY employee_id, project_id