SELECT r.contest_id, ROUND(COUNT(*)/(SELECT COUNT(*) FROM USers)*100, 2) as percentage
FROM Register r
LEFT JOIN Users u
ON r.user_id = u.user_id
GROUP BY r.contest_id
ORDER BY 2 DESC, 1