
SELECT *
FROM Products
WHERE REGEXP_LIKE(name, '[0-9]{3}')
AND NOT REGEXP_LIKE(name, '[0-9]{4,}')
ORDER BY product_id