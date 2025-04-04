WITH cte AS
(SELECT EXTRACT(YEAR FROM transaction_date), product_id, SUM(spend) AS curr_year_spend,
LAG(SUM(spend), 1) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend
FROM User_transactions
GROUP BY EXTRACT(YEAR FROM transaction_date), product_id
ORDER BY product_id,  EXTRACT(YEAR FROM transaction_date))


SELECT *, ROUND(((curr_year_spend - prev_year_spend)/prev_year_spend*100),2) as yoy_rate
FROM cte