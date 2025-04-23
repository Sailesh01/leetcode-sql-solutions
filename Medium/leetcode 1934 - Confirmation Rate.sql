SELECT s.user_id, 
CASE 
    WHEN c.action IS NOT NULL THEN ROUND(SUM(CASE WHEN c.action='confirmed'THEN 1 ELSE 0 END)/COUNT(*),2)
    ELSE 0.00
    END as confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id