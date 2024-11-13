WITH cte AS
(SELECT book_id, SUM(quantity) as total_sold
FROM Orders
WHERE dispatch_date BETWEEN (DATE '2019-06-23' - INTERVAL '1 Year') AND DATE '2019-06-23'
GROUP BY book_id)

SELECT b.book_id, b.name
FROM Books b
LEFT JOIN cte c
ON b.book_id = c.book_id
WHERE COALESCE(c.total_sold, 0) < 10
AND (DATE '2019-06-23' - b.available_from)/30 >=1



