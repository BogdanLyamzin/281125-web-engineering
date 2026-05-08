USE northwind;

SELECT id, order_date, shipping_fee, SUM(shipping_fee) OVER() AS total_shipping_fee 
FROM orders WHERE order_date >= '2006-01-01' AND order_date <= '2006-01-31';

SELECT id, order_date, shipping_fee, SUM(shipping_fee) OVER(ORDER BY order_date) AS total_shipping_fee 
FROM orders WHERE order_date >= '2006-01-01' AND order_date <= '2006-01-31';

SELECT id, order_date, shipping_fee, 
SUM(shipping_fee) OVER(PARTITION BY order_date ORDER BY shipping_fee) AS total_shipping_fee 
FROM orders;

SELECT id, order_date, shipping_fee, SUM(shipping_fee) OVER() AS total_shipping_fee FROM orders;

SELECT id, order_date, shipping_fee, SUM(shipping_fee) OVER(PARTITION BY order_date) AS total_shipping_fee FROM orders;

SELECT ROW_NUMBER() OVER() AS order_number, id, order_date, shipping_fee
FROM orders;

SELECT order_date, ROW_NUMBER() OVER(PARTITION BY order_date) AS order_number, id, shipping_fee
FROM orders;

SELECT order_date, ROW_NUMBER() OVER(PARTITION BY order_date ORDER BY shipping_fee) AS order_number, id, shipping_fee
FROM orders;

SELECT RANK() OVER(ORDER BY shipping_fee) AS shipping_fee_rank,
id, order_date, shipping_fee
FROM orders;

SELECT order_date, RANK() OVER(PARTITION BY order_date ORDER BY shipping_fee) AS shipping_fee_rank,
shipping_fee, id
FROM orders;

SELECT DENSE_RANK() OVER(ORDER BY shipping_fee) AS shipping_fee_rank,
id, order_date, shipping_fee
FROM orders;

SELECT order_date, DENSE_RANK() OVER(PARTITION BY order_date ORDER BY shipping_fee) AS shipping_fee_rank,
shipping_fee, id
FROM orders;

SELECT id, shipping_fee, 
NTILE(3) OVER(ORDER BY shipping_fee) AS category
FROM orders;

SELECT id, shipping_fee, 
NTILE(3) OVER(ORDER BY shipping_fee) AS category
FROM orders GROUP BY shipping_fee;

USE shop;

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount FROM ORDERS; 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount FROM ORDERS; 

SELECT ORDER_ID AS id, DATE_FORMAT(ODATE, '%Y-%m') AS date_month, AMT AS amount FROM ORDERS; 

SELECT ORDER_ID AS id, DATE_FORMAT(ODATE, '%Y-%m') AS date_month, SUM(AMT) AS total_month_sum
FROM ORDERS 
GROUP BY (DATE_FORMAT(ODATE, '%Y-%m')); 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
LAG(AMT) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS prev_amount
FROM ORDERS; 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
LEAD(AMT) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS prev_amount
FROM ORDERS; 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
FIRST_VALUE(AMT) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS first_amount
FROM ORDERS; 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
LAST_VALUE(AMT) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS first_amount
FROM ORDERS; 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
NTH_VALUE(AMT, 2) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS first_amount
FROM ORDERS; 