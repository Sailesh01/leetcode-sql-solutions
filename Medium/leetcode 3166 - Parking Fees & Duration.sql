WITH cte AS
(SELECT *, ROUND(EXTRACT(EPOCH FROM (exit_time - entry_time))*1.00/3600,1)AS time_diff
FROM ParkingTransactions),
cte2 AS
(SELECT car_id, SUM(fee_paid) AS total_fee_paid, ROUND(SUM(fee_paid)/SUM(time_diff),2) as avg_hourly_fee
FROM cte
GROUP BY car_id),
cte3 AS
(
SELECT car_id, lot_id, RANK() OVER (PARTITION BY car_id ORDER BY SUM(time_diff) DESC) AS lot_rank
FROM cte
GROUP BY car_id, lot_id
)
SELECT c2.car_id, 
       c2.total_fee_paid, 
       c2.avg_hourly_fee, 
       c4.lot_id AS most_time_lot
FROM cte2 c2
JOIN cte3 c4 ON c2.car_id = c4.car_id
WHERE c4.lot_rank = 1
ORDER BY c2.car_id;