SELECT c.nombre, c.apellido
FROM Customer c
INNER JOIN Order o ON c.customer_id = o.customer_id
WHERE MONTH(c.fecha_nac) = MONTH(CURDATE()) AND DAY(c.fecha_nac) = DAY(CURDATE())
  AND o.order_date >= '2020-01-01' AND o.order_date <= '2020-01-31'
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 1500;
