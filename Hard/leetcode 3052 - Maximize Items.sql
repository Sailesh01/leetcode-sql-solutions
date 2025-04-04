WITH cte AS
(SELECT item_type, SUM(square_footage) AS total_area, COUNT(item_category) AS total_items,
FLOOR(500000/SUM(square_footage)) AS max_combs

FROM Inventory
GROUP BY item_type)


SELECT item_type, CASE WHEN item_type='prime_eligible' THEN total_items*max_combs
WHEN item_type='not_prime' THEN 
FLOOR((500000-(SELECT total_area*max_combs FROM cte WHERE item_type='prime_eligible'))/(SELECT total_area FROM cte WHERE item_type='not_prime'))*total_items
END AS item_count
FROM cte