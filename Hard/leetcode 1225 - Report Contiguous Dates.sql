WITH cte AS
(SELECT fail_date as date_value, 'failed' as status
FROM Failed
UNION 
SELECT success_date as date_value, 'succeeded' as status
FROM Succeeded),
cte2 AS
(SELECT *, ROW_NUMBER() OVER(PARTITION BY status ORDER BY date_value) as rnk
FROM cte),
cte3 As
(SELECT *, DATE(date_value - INTERVAL '1 day' * rnk) as new_date
FROM cte2)

SELECT status as period_state, MIN(date_value) as start_date, MAX(date_value) as end_date
FROM cte3
WHERE date_value BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY new_date, status
ORDER BY start_date