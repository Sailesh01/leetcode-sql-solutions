WITH cte AS
(SELECT *, ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY match_day) as match_rnk,
ROW_NUMBER() OVER(PARTITION BY player_id, result ORDER BY match_day) as win_rnk
FROM matches),
cte2 AS
(SELECT player_id, match_rnk - win_rnk as rnk_diff, COUNT(*) as streak,
ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY COUNT(*) DESC) as rnk
FROM cte
WHERE result = 'Win'
GROUP BY player_id, match_rnk - win_rnk)

SELECT DISTINCT player_id, COALESCE(streak,0) as longest_streak
FROM matches m
LEFT JOIN (SELECT player_id, streak
FROM cte2
WHERE rnk = 1) AS T
USING (player_id)