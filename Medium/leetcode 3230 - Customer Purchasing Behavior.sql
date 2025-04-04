WITH cte AS(
SELECT t.*, p.category, COUNT(*) OVER(PARTITION BY customer_id, category) as cnt
FROM transactions as t
LEFT JOIN Products as p
ON t.product_id = p.product_id),

cte2 AS
(SELECT *, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY cnt DESC, transaction_date DESC) as rnk
FROM cte) 

SELECT customer_id, ROUND(SUM(amount),2) as total_amount, COUNT(*) as transaction_count, COUNT(DISTINCT category) as unique_categories, ROUND(SUM(amount)/COUNT(transaction_id),2) as avg_transaction_amount,
MAX(CASE WHEN rnk=1 THEN category ELSE NULL END) as top_category,
ROUND(((COUNT(transaction_id)*10) + SUM(amount)/100),2) as loyalty_score
FROM cte2
GROUP BY customer_id
ORDER BY loyalty_score DESC, customer_id 