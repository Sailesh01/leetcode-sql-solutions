SELECT emp.name, bon.bonus
FROM Employee emp
LEFT JOIN Bonus bon
ON emp.empId = bon.empId
WHERE bon.bonus < 1000 OR bon.bonus IS NULL