WITH cte AS
(SELECT city, EXTRACT(HOUR FROM call_time) as hr, COUNT(*) as total_calls,
DENSE_RANK() OVER(PARTITION BY city ORDER BY COUNT(*) DESC) as rnk
FROM Calls
GROUP BY city, EXTRACT(HOUR FROM call_time))

SELECT city, hr as peak_calling_hour, total_calls AS number_of_calls
FROM cte
WHERE rnk = 1
ORDER BY 2 DESC, 1 DESC