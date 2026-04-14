USE northwind;

SELECT id, product_name,
	CASE
		WHEN minimum_reorder_quantity IS NOT NULL THEN true
        ELSE false
    END is_minimum_reorder_quantity
	-- IF(minimum_reorder_quantity IS NOT NULL, true, false) AS is_minimum_reorder_quantity
FROM products ORDER BY is_minimum_reorder_quantity;

SELECT id, product_name, standard_cost, 
(standard_cost * '1.2') AS standard_cost_usd
FROM products;

SELECT id, product_name, standard_cost, 
(standard_cost * '1.2b') AS standard_cost_usd
FROM products;

SELECT id, product_name, standard_cost, 
(standard_cost * 'b1.2') AS standard_cost_usd
FROM products;

SELECT id,
CONCAT(product_name, '. Price:', standard_cost) AS short_info
FROM products;

SELECT id, 
SUBSTRING(order_date, 1, 10) AS order_date
FROM orders;

SELECT id, product_name, 
CAST(standard_cost AS SIGNED) AS standard_cost
FROM products;

SELECT id, product_name, 
CAST(10 AS UNSIGNED) AS standard_cost
FROM products;

SELECT id, product_name, 
CAST(standard_cost AS CHAR) AS standard_cost
FROM products;

SELECT id,
CAST(order_date AS DATE) AS order_date
FROM orders;

SELECT id,
CAST(order_date AS TIME) AS order_time
FROM orders;

SELECT id,
CAST(order_date AS YEAR) AS order_year
FROM orders;

SELECT id, DATE_FORMAT(order_date, '%Y/%m/%d %H-%i-%s') AS order_date FROM orders;
SELECT id, TIME(order_date) AS order_date FROM orders;

SELECT DATEDIFF('2026-04-14', '2025-04-14') AS datediff;

SELECT NOW();

SELECT CURDATE();

SELECT CURTIME();

SELECT DATEDIFF(NOW(), '2025-04-14') AS datediff;

SELECT id, order_date, 
DATEDIFF(NOW(), order_date) AS order_date_days 
FROM orders 
ORDER BY order_date_days ASC LIMIT 1;

SELECT DATE_SUB('2026-04-14', INTERVAL 10 DAY) AS prev_ten_days;
SELECT DATE_SUB('2026-04-14', INTERVAL 10 YEAR) AS prev_ten_days;

SELECT DATE_ADD('2026-04-14', INTERVAL 10 DAY) AS prev_ten_days;
SELECT DATE_ADD('2026-04-14', INTERVAL 10 YEAR) AS prev_ten_days;

SELECT id, order_date
FROM orders
WHERE order_date > DATE_SUB(NOW(), INTERVAL 30 DAY);

SELECT id, order_date, shipped_date,
DATEDIFF(shipped_date, order_date) AS days_diff
FROM orders 
WHERE shipped_date IS NOT NULL
ORDER BY days_diff DESC;

SELECT id, 
EXTRACT(DAY FROM order_date) AS order_day, EXTRACT(DAY FROM shipped_date) AS shipped_day
FROM orders
WHERE shipped_date IS NOT NULL
ORDER BY order_day, shipped_day;