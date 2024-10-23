SELECT CONCAT(t1.topping_name,',',t2.topping_name,',',t3.topping_name) as pizza,
t1.cost + t2.cost + t3.cost as total_cost
FROM Toppings t1
INNER JOIN Toppings t2
ON t1.topping_name < t2.topping_name
INNER JOIN Toppings t3
ON t2.topping_name < t3.topping_name
ORDER BY total_cost DESC, pizza