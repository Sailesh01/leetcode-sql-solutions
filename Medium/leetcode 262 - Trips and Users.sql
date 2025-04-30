SELECT tt.Request_at AS Day, ROUND(AVG(status != 'completed'),2) as `Cancellation Rate`
FROM trips tt
JOIN users uu ON tt.Client_Id = uu.Users_Id AND uu.Banned = 'No'
JOIN Users uu1 ON tt.Driver_Id = uu1.Users_Id AND uu1.Banned = 'No'
WHERE tt.Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY tt.Request_at
