WITH cte AS
(SELECT *, COUNT(*) OVER(PARTITION BY dep_id) as dept_size
FROM Employees)

SELECT emp_name AS manager_name, dep_id
FROM cte
WHERE dept_size = (SELECT MAX(dept_size) FROM cte)
AND position = 'Manager'
ORDER BY dep_id