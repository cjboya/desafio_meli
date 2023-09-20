SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS mes_anio,
    c.nombre,
    c.apellido,
    COUNT(o.order_id) AS cantidad_ventas,
    SUM(i.price) AS monto_total
FROM Order o
INNER JOIN Customer c ON o.customer_id = c.customer_id
INNER JOIN Item i ON o.item_id = i.item_id
INNER JOIN Category cat ON i.category_id = cat.category_id
WHERE cat.description = 'Celulares'
  AND o.order_date >= '2020-01-01' AND o.order_date <= '2020-12-31'
GROUP BY mes_anio, c.customer_id
ORDER BY mes_anio, monto_total DESC
LIMIT 5;
