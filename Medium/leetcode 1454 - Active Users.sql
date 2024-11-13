WITH cte AS
(SELECT DISTINCT l.*, a.name
FROM Logins l
JOIN Accounts a
ON l.id = a.id),
cte2 AS 
(SELECT *, ROW_NUMBER() OVER(PARTITION BY id ORDER BY login_date) as rnk
FROM cte) 

SELECT DISTINCT id, name
FROM cte2
GROUP BY id, name, login_date - INTERVAL '1 day' * (rnk -1)
HAVING COUNT(*) >= 5