USE northwind;

SELECT AVG(quantity * unit_price * (1 - discount)) as avg_positon_price 
FROM order_details;

SELECT id, (quantity * unit_price * (1 - discount)) AS position_price
FROM order_details ORDER BY position_price DESC;

SELECT id, quantity, AVG(quantity) OVER() AS avg_quantity 
FROM order_details ORDER BY quantity DESC;

SELECT id, 
(quantity * unit_price * (1 - discount)) AS position_price,
AVG(quantity * unit_price * (1 - discount)) OVER() AS avg_position_price
FROM order_details ORDER BY position_price DESC;

SELECT product_id, 
(quantity * unit_price * (1 - discount)) AS product_position_price,
AVG(quantity * unit_price * (1 - discount)) OVER(PARTITION BY product_id) 
AS avg_product_position_price
FROM order_details ORDER BY product_id ASC;

SELECT product_id, quantity,
AVG(quantity) OVER(PARTITION BY product_id) 
AS avg_product_quantity
FROM order_details ORDER BY product_id ASC;

SELECT order.*, name
FROM order
JOIN user ON oder.user_id = user.id;