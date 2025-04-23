SELECT man.name
FROM Employee emp
JOIN Employee man
ON emp.managerId = man.id
GROUP BY man.id, man.name
HAVING COUNT(man.id) >= 5 