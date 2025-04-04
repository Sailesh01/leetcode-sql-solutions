WITH cte AS
(SELECT *, PERCENT_RANK() OVER(PARTITION BY state ORDER BY fraud_score DESC) as percentile
FROM Fraud)

SELECT policy_id, state, fraud_score
FROM cte
WHERE percentile <= 0.05
ORDER BY 2, 3 DESC, 1