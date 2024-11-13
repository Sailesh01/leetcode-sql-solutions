WITH cte AS
(SELECT a.action_date, COUNT(DISTINCT CASE WHEN r.remove_date IS NOT NULL THEN a.post_id ELSE NULL END)*1.00 / COUNT(DISTINCT a.post_id)*100 as perc
FROM Actions a 
LEFT JOIN Removals r
ON a.post_id = r.post_id
WHERE a.action = 'report' 
AND a.extra = 'spam'
GROUP BY a.action_date)

SELECT ROUND(AVG(perc),2) as average_daily_percent 
FROM cte