WITH cte AS
(SELECT player_id, MIN(event_date) as first_day
FROM Activity
GROUP BY player_id)

SELECT ROUND(COUNT(DISTINCT a.player_id)*1.0/(SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM Activity a
INNER JOIN cte c
ON a.player_id = c.player_id
AND a.event_date = DATE_ADD(c.first_day, INTERVAL 1 DAY)