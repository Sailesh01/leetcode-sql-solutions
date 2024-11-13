WITH cte AS
(SELECT product_id, EXTRACT(YEAR FROM purchase_date) as year_value, COUNT(order_id) AS num_order,
EXTRACT(YEAR FROM purchase_date) - ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM purchase_date)) as date_diff
FROM Orders
GROUP BY product_id, EXTRACT(YEAR FROM purchase_date))

SELECT DISTINCT product_id
FROM cte
GROUP BY product_id, date_diff
HAVING COUNT(*)>=2