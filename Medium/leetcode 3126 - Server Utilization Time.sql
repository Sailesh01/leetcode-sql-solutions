WITH cte AS
(SELECT server_id, session_status, status_time, 
LEAD(status_time) OVER(PARTITION BY server_id ORDER BY status_time) as next_status_time
FROM servers)

SELECT FLOOR(SUM(EXTRACT(EPOCH FROM(next_status_time - status_time)))/86400) as time_in_sec
FROM cte
WHERE session_status = 'start'