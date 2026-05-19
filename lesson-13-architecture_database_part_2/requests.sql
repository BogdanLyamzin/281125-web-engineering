CREATE DATABASE IF NOT EXISTS online_shop_281125_wdm;

USE online_shop_281125_wdm;

CREATE TABLE orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    customer_phone VARCHAR(20) NOT NULL,
    customer_address VARCHAR(255) NOT NULL,
    products VARCHAR(500) NOT NULL,
    delivery_address VARCHAR(255) NOT NULL,
    delivery_cost DECIMAL(10,2) NOT NULL CHECK (delivery_cost > 0)
);

INSERT INTO orders 
(customer_name, customer_phone, customer_address, products, delivery_address, delivery_cost)
VALUES('Anna Muller', '+49 111 2222333', 'Berlin, Alexandrplatz 1', 'Printer 1; Mouse 2', 
'Berlin, Alexandrplatz 1', 25.00);
/*Таблица находиться в первой нормальной форме (1NF) если:
- в каждой ячейке храниться одно значение, а не несколько (требование атомарности);
- подумайте, можно ли данные, хранящиеся в одном столбце, разделить на несколько столбцов.
- задавайте себе вопрос: можно ли разделить данные, хранящиеся в столбце, на несколько столбцов
и будет ли это полезно для фронтенда, а также аналитики?
*/
 
ALTER TABLE orders
DROP customer_address;

ALTER TABLE orders
ADD customer_state VARCHAR(100) NOT NULL;

ALTER TABLE orders
ADD customer_city VARCHAR(100) NOT NULL;

ALTER TABLE orders
ADD customer_address VARCHAR(100) NOT NULL;

ALTER TABLE orders
ADD customer_postal_code VARCHAR(10) NOT NULL;

ALTER TABLE orders
ADD delivery_state VARCHAR(100) NOT NULL;

ALTER TABLE orders
ADD delivery_city VARCHAR(100) NOT NULL;

ALTER TABLE orders
ADD delivery_address VARCHAR(100) NOT NULL;

ALTER TABLE orders
ADD delivery_postal_code VARCHAR(10) NOT NULL;

DELETE FROM orders WHERE id = 1;

INSERT INTO orders 
(customer_name, customer_phone, customer_state, customer_city, customer_address, customer_postal_code,
products, delivery_state, delivery_city, delivery_address, delivery_postal_code, delivery_cost)
VALUES('Anna Muller', '+49 111 2222333', 'Berlin', 'Berlin', 'Alexandrplatz 1', '123456',
'Printer 1; Mouse 2', 'Berlin', 'Berlin', 'Alexandrplatz 1', '123456', 25.00);

 
 
 
 