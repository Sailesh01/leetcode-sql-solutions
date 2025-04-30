WITH trans_grp AS
(SELECT TO_CHAR(trans_date, 'YYYY-MM') as month, country,
	SUM(CASE WHEN state='approved' THEN 1 ELSE 0 END) as approved_count,
	SUM(CASE WHEN state='approved' THEN amount ELSE 0 END) as approved_amount
FROM Transactions
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country),

chargeback_grp AS
(SELECT TO_CHAR(c.trans_date, 'YYYY-MM') as month, t.country, 
COUNT(*) as chargeback_count, SUM(amount) as chargeback_amount
FROM Chargebacks AS c
LEFT JOIN Transactions AS t
ON c.trans_id = t.id
GROUP BY TO_CHAR(c.trans_date, 'YYYY-MM'), t.country),
result_tbl as
(SELECT t.*, COALESCE(c.chargeback_count,0) as chargeback_count, COALESCE(c.chargeback_amount,0) as chargeback_amount
FROM trans_grp t
LEFT JOIN chargeback_grp c
ON t.month = c.month 
AND t.country = c.country
UNION
SELECT c.month, c.country, COALESCE(t.approved_count,0) as approved_count,
COALESCE(t.approved_amount,0) as approved_amount, c.chargeback_count, c.chargeback_amount
FROM trans_grp t
RIGHT JOIN chargeback_grp c
ON t.month = c.month 
AND t.country = c.country)

SELECT *
FROM result_tbl
WHERE approved_count+approved_amount+chargeback_count+chargeback_amount>0