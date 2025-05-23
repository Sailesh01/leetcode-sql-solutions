SELECT
    query_name, 
    ROUND(AVG(rating/position), 2) as quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)/COUNT(*)*100, 2) as poor_query_percentage
FROM Queries
WHERE query_name IS NOT NULL
GROUP BY query_name
