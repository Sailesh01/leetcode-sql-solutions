WITH cte AS
(SELECT candidate, 1.00/COUNT(candidate) OVER(PARTITION BY voter) as vote_num
FROM Votes
WHERE candidate IS NOT NULL),
cte2 AS
(SELECT candidate, SUM(vote_num) as total_votes
FROM cte
GROUP BY candidate)
SELECT candidate
FROM cte2
WHERE total_votes = (SELECT MAX(total_votes) FROM cte2)
ORDER BY candidate