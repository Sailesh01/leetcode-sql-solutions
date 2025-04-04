WITH cte AS
(SELECT *, RANK() OVER(PARTITION BY user_id ORDER BY transaction_date) as rnk_by_date
FROM Transactions),
cte2 AS
(SELECT *, RANK() OVER(PARTITION BY user_id ORDER BY spend) as rnk_by_spend
FROM cte
WHERE rnk_by_date <= 3)

SELECT user_id, spend AS third_transaction_spend, transaction_date AS third_transaction_date
FROM cte2
WHERE rnk_by_date = 3 AND 
rnk_by_spend = 3
ORDER BY 1
