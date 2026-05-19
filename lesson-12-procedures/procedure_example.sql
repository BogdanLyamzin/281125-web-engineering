USE sql_indexes_demo;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    quantity INT NOT NULL CHECK (quantity > 0)
);

INSERT INTO products (name, category, price, quantity)
VALUES
    ('Laptop', 'Electronics', 1200.00, 5),
    ('Mouse', 'Electronics', 25.00, 40),
    ('Keyboard', 'Electronics', 70.00, 20),
    ('Desk', 'Furniture', 300.00, 7),
    ('Chair', 'Furniture', 150.00, 12),
    ('Notebook', 'Stationery', 4.50, 100),
    ('Pen', 'Stationery', 1.20, 200);

SELECT id, name, category, price, quantity FROM products WHERE category = 'Furniture';

DELIMITER //
CREATE PROCEDURE get_products_by_category(IN category_name VARCHAR(50))
BEGIN
	SELECT id, name, category, price, quantity FROM products WHERE category = category_name;
END //
DELIMITER ;

CALL get_products_by_category('Furniture');
CALL get_products_by_category('Stationery');

DELIMITER //
CREATE PROCEDURE change_price_by_category(IN category_name  VARCHAR(50), IN percent_param DECIMAL(5,2))
BEGIN
	UPDATE products SET price = price * (1 + percent_param/100) WHERE category = category_name AND id > 0;
END //
DELIMITER ;

CALL get_products_by_category('Furniture');
CALL change_price_by_category('Furniture', 10);

DELIMITER //
CREATE PROCEDURE count_products_by_category(IN category_name VARCHAR(50), OUT total_products INT)
BEGIN
	SELECT COUNT(*) INTO total_products FROM products WHERE category = category_name;
END //
DELIMITER ;

-- SET @total = 0; 
CALL count_products_by_category('Furniture', @total);
SELECT @total;

DELIMITER //
CREATE PROCEDURE get_category_statistics(
IN category_name VARCHAR(50), 
OUT total_products INT,
OUT average_price DECIMAL(10, 2),
OUT total_in_stock INT,
OUT total_stock_value DECIMAL(10, 2)
)
BEGIN
	SELECT COUNT(*), AVG(price), SUM(quantity), SUM(price * quantity)
    INTO total_products, average_price, total_in_stock, total_stock_value
    FROM products WHERE category = category_name;
END //
DELIMITER ;

CALL get_category_statistics('Electronics',
@total_products,
@average_price,
@total_in_stock,
@total_stock_value);

SELECT 'Electronics' AS category, @total_products, @average_price, @total_in_stock, @total_stock_value;

