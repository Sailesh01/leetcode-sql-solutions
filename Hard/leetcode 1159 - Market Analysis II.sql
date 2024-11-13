WITH cte AS
(SELECT u.user_id, o.order_date, u.favorite_brand, i.item_brand,
DENSE_RANK() OVER(PARTITION BY u.user_id ORDER BY o.order_date) as rnk,
COUNT(*) OVER(PARTITION BY u.user_id) as total_sale
FROM Users u
LEFT JOIN Orders o
ON u.user_id = o.seller_id
LEFT JOIN Items i
ON i.item_id = o.item_id),
cte2 AS
(SELECT user_id as seller_id, CASE WHEN total_sale < 2 THEN 'no'
WHEN total_sale >= 2 AND rnk = 2 AND favorite_brand = item_brand THEN 'yes'
WHEN total_sale >= 2 AND rnk = 2 AND favorite_brand <> item_brand THEN 'no'
ELSE NULL END as "2nd_item_fav_brand"
FROM cte)

SELECT *
FROM cte2
WHERE "2nd_item_fav_brand" IS NOT NULL