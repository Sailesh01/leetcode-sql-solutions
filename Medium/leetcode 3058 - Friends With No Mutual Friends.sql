WITH cte AS
(SELECT *
FROM Friends
UNION
SELECT user_id2, user_id1
FROM Friends),

cte2 AS
(SELECT c1.*, c2.user_id2 as f1, c3.user_id2 as f2
FROM cte c1
LEFT JOIN cte c2
ON c1.user_id1 = c2.user_id1
LEFT JOIN cte AS c3
ON c1.user_id2 = c3.user_id1
WHERE c2.user_id2 = c3.user_id2)

SELECT *
FROM Friends
WHERE (user_id1, user_id2) NOT IN 
(SELECT user_id1, user_id2 FROM cte2)
ORDER by user_id1, user_id2