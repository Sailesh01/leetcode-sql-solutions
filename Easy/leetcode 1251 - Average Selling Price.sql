SELECT
    p.product_id,
    IFNULL(ROUND(SUM(p.price*IFNULL(u.units, 0)) / SUM(IFNULL(u.units,0)),2),0) as average_price

FROM
    Prices p
LEFT JOIN
    UnitsSold u
ON
    p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY
    p.product_id
