USE northwind;

SELECT id, order_id, product_id FROM order_details 	WHERE quantity >= 100;

SELECT COUNT(*) AS total_january_orders
FROM orders 
WHERE order_date >= '2006-01-01' AND order_date <= '2006-01-31';

SELECT COUNT(*) AS total_orders
FROM orders; -- 48

SELECT COUNT(shipped_date) AS total_shipped_orders
FROM orders; -- 39

SELECT id, quantity, unit_price, discount,
(quantity * unit_price * (1 - discount)) AS total_price
FROM order_details;

SELECT SUM(quantity) AS total_quantity FROM order_details;

SELECT SUM(quantity * unit_price * (1 - discount)) AS total_orders_price FROM order_details;

SELECT COUNT(*) AS total_products FROM products;

SELECT COUNT(DISTINCT product_id) AS total_products_ordered FROM order_details;

SELECT AVG(discount) AS avg_discount FROM order_details;

SELECT AVG(quantity) AS avg_quantity FROM order_details;

SELECT id, (quantity * unit_price * (1 - discount)) AS total_price FROM order_details;

SELECT AVG(quantity * unit_price * (1 - discount)) AS avg_total_price FROM order_details;

SELECT MAX(discount) AS max_discount FROM order_details;

SELECT MAX(quantity) AS max_quantity FROM order_details;

SELECT MAX(quantity * unit_price * (1 - discount)) AS max_total_price FROM order_details;

SELECT MIN(discount) AS min_discount FROM order_details;

SELECT MIN(quantity) AS min_quantity FROM order_details;

SELECT MIN(quantity * unit_price * (1 - discount)) AS min_total_price FROM order_details;

SELECT 
MAX(discount) AS max_discount,
MIN(discount) AS min_discount 
FROM order_details;

SELECT 
AVG(quantity * unit_price * (1 - discount)) AS avg_total_price,
MIN(quantity * unit_price * (1 - discount)) AS min_total_price,
MAX(quantity * unit_price * (1 - discount)) AS max_total_price
FROM order_details;

SELECT GROUP_CONCAT(product_name) AS all_products_name FROM products;

SELECT GROUP_CONCAT(DISTINCT category) AS all_products_name FROM products;


SELECT city, COUNT(id) AS total_city_customers FROM customers GROUP BY city;

SELECT state_province, COUNT(id) AS total_state_customers FROM customers GROUP BY state_province;

SELECT job_title, COUNT(id) AS total_employees 
FROM employees 
GROUP BY job_title 
ORDER BY total_employees ASC;

SELECT order_id, 
COUNT(*) AS total_positions 
FROM order_details 
GROUP BY order_id
ORDER BY total_positions DESC;

SELECT id, order_id,
quantity * unit_price * (1 - discount) AS total_position_price
FROM order_details;

SELECT order_id, 
COUNT(*) AS total_positions,
SUM(quantity * unit_price * (1 - discount)) AS total_order_price
FROM order_details 
GROUP BY order_id
ORDER BY total_order_price DESC;

SELECT company, job_title, COUNT(id) AS total_employees 
FROM employees 
GROUP BY company, job_title 
ORDER BY total_employees ASC;

SELECT order_id, 
COUNT(*) AS total_positions,
SUM(quantity * unit_price * (1 - discount)) AS total_order_price
FROM order_details 
GROUP BY order_id
HAVING total_order_price > 1000
ORDER BY total_order_price DESC;

