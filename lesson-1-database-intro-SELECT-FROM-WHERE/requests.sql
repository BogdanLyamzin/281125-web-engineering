USE northwind;

SELECT * FROM northwind.products;

/*
SELECT - оператор выбора.
FROM - оператор, указывающий из какой таблицы выбрать поля
*/
-- выбрать все столбцы из таблицы products;
SELECT * FROM products;

SELECT id, product_name, list_price, standard_cost FROM products;

SELECT * FROM products;

SELECT * FROM products WHERE list_price >= 20;

SELECT * FROM products WHERE product_code = 'NWTB-1';
SELECT * FROM products WHERE product_code = "NWTB-1";

SELECT * FROM products WHERE list_price >= 10 AND list_price <= 20;

SELECT id, product_name, standard_cost, list_price FROM products 
WHERE category = 'Baked Goods & Mixes' AND list_price > 10;

SELECT id, product_name, category FROM products
WHERE category = 'Beverages' OR category = 'Condiments';

SELECT id, product_name, category FROM products
WHERE category = 'Beverages' OR category = 'Condiments' OR category = 'Oil';

SELECT id, product_name, category FROM products
WHERE category IN ('Beverages', 'Condiments', 'Oil');

SELECT * FROM products WHERE list_price BETWEEN 10 AND 20;

SELECT * FROM products WHERE product_name LIKE '%beer%';

SELECT * FROM employees WHERE first_name LIKE '%A';

SELECT * FROM employees WHERE first_name LIKE '%_a_%';

SELECT * FROM employees WHERE job_title LIKE '%Manager%';

SELECT * FROM order_details WHERE purchase_order_id IS NOT NULL;

SELECT * FROM order_details WHERE purchase_order_id IS NULL;

SELECT * FROM orders WHERE shipped_date IS NOT NULL;

SELECT * FROM orders WHERE shipped_date IS NULL;