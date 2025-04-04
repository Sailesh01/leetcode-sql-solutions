WITH cte AS
(SELECT co.first_name, c.type, c.duration,
DENSE_RANK() OVER(PARTITION BY c.type ORDER BY c.duration DESC) as rnk
FROM Calls c
JOIN Contacts co
ON c.contact_id = co.id)

SELECT first_name, type, TO_CHAR(
        INTERVAL '1 second'*duration, 
        'HH24:MI:SS'
    ) AS duration_formatted
FROM cte
WHERE rnk <= 3
ORDER BY 2, 3 DESC, 1 DESC;