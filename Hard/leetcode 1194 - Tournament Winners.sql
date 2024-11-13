WITH cte AS
(SELECT p.player_id, p.group_id, SUM(CASE WHEN p.player_id = m.first_player THEN first_score
WHEN p.player_id = m.second_player THEN second_score ELSE 0 END)  AS total_score
FROM Players p
LEFT JOIN Matches m
ON p.player_id = m.first_player 
OR p.player_id = m.second_player
GROUP BY p.player_id, p.group_id),
cte2 AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY group_id ORDER BY total_score DESC, player_id) as rnk
FROM cte)

SELECT group_id, player_id
FROM cte2
WHERE rnk = 1