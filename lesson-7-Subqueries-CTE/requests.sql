USE northwind;

SELECT AVG(unit_price) AS avg_unit_price FROM order_details;

SET @avg_unit_price = (SELECT AVG(unit_price) FROM order_details);

-- SELECT @avg_unit_price;

SELECT * FROM order_details WHERE unit_price > @avg_unit_price ORDER BY unit_price ASC;

SELECT * FROM order_details 
WHERE unit_price > (SELECT AVG(unit_price) FROM order_details) 
ORDER BY unit_price ASC;

SELECT id FROM customers WHERE city = 'Los Angelas';

SELECT * FROM orders WHERE customer_id IN (SELECT id FROM customers WHERE city = 'Los Angelas');

SELECT orders.*,
city
FROM orders 
JOIN customers ON orders.customer_id = customers.id
WHERE city  = 'Los Angelas';

with 
LA_clients AS
(SELECT id from customers 
WHERE city = 'Los Angelas')
SELECT * FROM orders 
WHERE customer_id IN (SELECT id FROM LA_clients);








