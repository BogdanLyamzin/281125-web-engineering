CREATE DATABASE sql_indexes_demo;

USE sql_indexes_demo;

DROP TABLE IF EXISTS users_demo;

CREATE TABLE users_demo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    age INT NOT NULL,
    created_at DATETIME NOT NULL
);

SET SESSION cte_max_recursion_depth = 1000000;

INSERT INTO users_demo (
    username,
    email,
    city,
    status,
    age,
    created_at
)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 1000000
)
SELECT
    CONCAT('user_', n),
    CONCAT('user_', n, '@example.com'),
    CASE 
        WHEN n % 10 = 0 THEN 'Berlin'
        WHEN n % 10 = 1 THEN 'Paris'
        WHEN n % 10 = 2 THEN 'London'
        WHEN n % 10 = 3 THEN 'Madrid'
        WHEN n % 10 = 4 THEN 'Rome'
        WHEN n % 10 = 5 THEN 'Warsaw'
        WHEN n % 10 = 6 THEN 'Prague'
        WHEN n % 10 = 7 THEN 'Vienna'
        WHEN n % 10 = 8 THEN 'Amsterdam'
        ELSE 'Lisbon'
    END,
    CASE
        WHEN n % 3 = 0 THEN 'active'
        WHEN n % 3 = 1 THEN 'inactive'
        ELSE 'blocked'
    END,
    18 + (n % 60),
    DATE_ADD('2020-01-01 00:00:00', INTERVAL n SECOND)
FROM numbers;

EXPLAIN ANALYZE SELECT * FROM users_demo WHERE email = 'user_500000@example.com';

/*
-> Filter: (users_demo.email = 'user_500000@example.com')  
	(cost=100954 rows=99552) (actual time=336..666 rows=1 loops=1)
     -> Table scan on users_demo  (cost=100954 rows=995517) 
		(actual time=0.0724..508 rows=1e+6 loops=1)
        Result: 0.66 sec
*/

CREATE INDEX idx_users_demo_email ON users_demo(email);

EXPLAIN ANALYZE SELECT * FROM users_demo WHERE email = 'user_500000@example.com';

/*
-> Index lookup on users_demo using idx_users_demo_email (email='user_500000@example.com')  
		(cost=0.35 rows=1) (actual time=0.0438..0.0472 rows=1 loops=1)
        Result 0.05 sec
 */
 
 EXPLAIN ANALYZE SELECT * FROM users_demo WHERE LOWER(email) = 'user_500000@example.com';
 /*
 -> Filter: (lower(users_demo.email) = 'user_500000@example.com')  
		(cost=100954 rows=995517) (actual time=400..805 rows=1 loops=1)
     -> Table scan on users_demo  (cost=100954 rows=995517) 
			(actual time=0.0838..524 rows=1e+6 loops=1)
 */
 
 CREATE INDEX idx_users_demo_lower_email ON users_demo((LOWER(email)));
 
 EXPLAIN ANALYZE SELECT * FROM users_demo WHERE LOWER(email) = 'user_500000@example.com';
 /*
 -> Index lookup on users_demo using idx_users_demo_lower_email 
 (lower(email)='user_500000@example.com')  
 (cost=0.35 rows=1) (actual time=0.0356..0.0373 rows=1 loops=1)
 */
 
EXPLAIN ANALYZE SELECT * FROM users_demo WHERE city = 'Berlin' AND status = 'active';
/*
-> Filter: ((users_demo.`status` = 'active') and (users_demo.city = 'Berlin'))  
	(cost=100982 rows=9955) (actual time=0.0868..666 rows=33333 loops=1)
     -> Table scan on users_demo  (cost=100982 rows=995476) 
			(actual time=0.073..529 rows=1e+6 loops=1)
*/

CREATE INDEX idx_users_demo_city_status ON users_demo(city, status);

EXPLAIN ANALYZE SELECT * FROM users_demo WHERE city = 'Berlin' AND status = 'active';
/*
-> Index lookup on users_demo using idx_users_demo_city_status (city='Berlin', status='active')  
(cost=11113 rows=68112) (actual time=0.283..134 rows=33333 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM users_demo WHERE city = 'Berlin';
/*
-> Index lookup on users_demo using idx_users_demo_city_status (city='Berlin')  
	(cost=25937 rows=216350) (actual time=0.254..384 rows=100000 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM users_demo WHERE status = 'active';
/*
-> Filter: (users_demo.`status` = 'active')  (cost=100982 rows=99548) 
		(actual time=0.0838..653 rows=333333 loops=1)
     -> Table scan on users_demo  (cost=100982 rows=995476) 
			(actual time=0.0797..529 rows=1e+6 loops=1)
*/

CREATE FUNCTION apply_discount(price DECIMAL(10,2), discount_percent DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN price - price * discount_percent / 100;

SELECT apply_discount(100, 10);

CREATE TABLE orders_demo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(50) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    country VARCHAR(50) NOT NULL,
    status VARCHAR(30) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    created_at DATETIME NOT NULL
);
SET SESSION cte_max_recursion_depth = 1000000;

INSERT INTO orders_demo (
    order_number,
    customer_name,
    customer_email,
    country,
    status,
    payment_method,
    total_amount,
    created_at
)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 1000000
)
SELECT
    CONCAT('ORD-', LPAD(n, 7, '0')),
    CONCAT('Customer ', n),
    CONCAT('customer_', n, '@shop.test'),
    CASE
        WHEN n % 10 = 0 THEN 'Germany'
        WHEN n % 10 = 1 THEN 'France'
        WHEN n % 10 = 2 THEN 'Spain'
        WHEN n % 10 = 3 THEN 'Italy'
        WHEN n % 10 = 4 THEN 'Poland'
        WHEN n % 10 = 5 THEN 'Netherlands'
        WHEN n % 10 = 6 THEN 'Austria'
        WHEN n % 10 = 7 THEN 'Belgium'
        WHEN n % 10 = 8 THEN 'Portugal'
        ELSE 'Czech Republic'
    END,
    CASE
        WHEN n % 5 = 0 THEN 'new'
        WHEN n % 5 = 1 THEN 'paid'
        WHEN n % 5 = 2 THEN 'shipped'
        WHEN n % 5 = 3 THEN 'delivered'
        ELSE 'cancelled'
    END,
    CASE
        WHEN n % 4 = 0 THEN 'card'
        WHEN n % 4 = 1 THEN 'paypal'
        WHEN n % 4 = 2 THEN 'bank_transfer'
        ELSE 'cash'
    END,
    ROUND(10 + (n % 5000) * 0.37, 2),
    DATE_ADD('2023-01-01 00:00:00', INTERVAL n SECOND)
FROM numbers;