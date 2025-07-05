--QUERYING
SELECT supplier_id, SUM(local_amount) AS supplier_amount
FROM items i RIGHT JOIN orders o
ON i.order_no = o.order_no
GROUP BY supplier_id
ORDER BY supplier_amount DESC;