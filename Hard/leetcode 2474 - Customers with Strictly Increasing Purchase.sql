WITH cte AS
(SELECT customer_id, EXTRACT(YEAR FROM order_date), SUM(price) AS total,
MAX(EXTRACT(YEAR FROM order_date)) OVER(PARTITION BY customer_id) - MIN(EXTRACT(YEAR FROM order_date)) OVER(PARTITION BY customer_id) + 1 AS year_count,
DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY EXTRACT(YEAR FROM order_date)) as year_rnk,
DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY SUM(price)) AS price_rnk
FROM Orders
GROUP BY customer_id, EXTRACT(YEAR FROM order_date))


SELECT customer_id
FROM cte
GROUP BY customer_id
HAVING SUM(CASE WHEN year_rnk = price_rnk THEN 1 ELSE 0 END) = MAX(year_count)