USE sql_indexes_demo;

CREATE FUNCTION calc_amount_after_deliver(amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (amount - 5);

SELECT *, 
calc_amount_after_deliver(total_amount) AS total_amount_after_delivery
FROM orders_demo WHERE country = 'Germany';

DELIMITER //
CREATE FUNCTION get_price_category(amount  DECIMAL(10,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(10);
    IF amount < 100 THEN
		SET result =  'cheap';
	ELSEIF amount < 500 THEN
		SET result =  'medium';
	ELSE 
		SET result =  'expensive';
	END IF;
    RETURN result;
END //
DELIMITER ;

SELECT *, get_price_category(total_amount) AS price_category
FROM orders_demo
WHERE country = 'Germany';