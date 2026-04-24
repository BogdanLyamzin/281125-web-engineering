USE northwind;

SELECT first_name, last_name, 'employee' AS status FROM employees
UNION ALL
SELECT first_name, last_name, 'customer' AS status FROM customers;

SELECT first_name, last_name, 'employee' AS status FROM employees
UNION
SELECT first_name, last_name, 'customer' AS status FROM customers;

SELECT first_name, last_name, 'employee' AS status, 'Seattle' as city
FROM employees WHERE city = 'Seattle'
UNION ALL
SELECT first_name, last_name, 'customer' AS status, 'Seattle' as city
FROM customers WHERE city = 'Seattle';

SELECT orders.id, order_date, shipped_date, 
customer_id, first_name, last_name, business_phone
FROM orders
JOIN customers ON orders.customer_id = customers.id;

SELECT orders.id, order_date, shipped_date, 
customer_id, first_name, last_name, business_phone
FROM customers
JOIN orders ON orders.customer_id = customers.id;

SELECT o.id, customer_id, order_date, shipped_date, 
first_name AS customer_first_name, last_name AS customer_last_name
FROM orders o
JOIN customers c ON o.customer_id = c.id;

SELECT o.id, customer_id, order_date, shipped_date, 
first_name, last_name
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.id;
 
SELECT orders.id, order_date, shipped_date, 
customer_id, 
customers.first_name AS customer_first_name, 
customers.last_name AS customer_last_name,
employee_id, 
employees.first_name AS employee_first_name, 
employees.last_name AS employee_last_name
FROM orders
JOIN customers ON orders.customer_id = customers.id
JOIN employees ON orders.employee_id = employees.id;





