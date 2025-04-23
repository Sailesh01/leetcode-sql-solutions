WITH cte AS
(SELECT *, RANK() OVER(PARTITION BY customer_id ORDER BY order_date) as rnk
FROM Delivery)


SELECT ROUND(SUM(CASE WHEN order_date=customer_pref_delivery_date THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS immediate_percentage
FROM cte
WHERE rnk = 1