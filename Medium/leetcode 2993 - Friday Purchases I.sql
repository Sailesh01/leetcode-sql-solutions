WITH cte AS
(SELECT *, TO_CHAR(purchase_date, 'Day') as day_of_week, 
EXTRACT(WEEK FROM purchase_date) - EXTRACT(WEEK FROM DATE_TRUNC('month', purchase_date)) + 1 AS week_of_month
FROM Purchases)

SELECT week_of_month, purchase_date, SUM(amount_spend) as total_amount
FROM cte
WHERE TRIM(day_of_week) = 'Friday'
GROUP BY week_of_month, purchase_date
ORDER BY week_of_month
