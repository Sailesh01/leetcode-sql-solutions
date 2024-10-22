SELECT e.user_id
FROM emails e
JOIN texts t
ON e.email_id = t.email_id
WHERE t.signup_action = 'Verified'
AND DATE(e.signup_date) + INTERVAL '1 day' = DATE(t.action_date)
ORDER BY user_id