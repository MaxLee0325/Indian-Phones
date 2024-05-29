#exclude the phones made before a certain year
DROP PROCEDURE IF EXISTS exclude_year;
DELIMITER $$
CREATE PROCEDURE exclude_year(IN input INT)
BEGIN 
	START TRANSACTION;
		DELETE FROM mobiles_year
        WHERE year_made < input
        #reference the primary key for safety mode
        AND brand <> ''
        AND model <> '';
    COMMIT;
END;
$$

#update and adjust the price according to the inflation rate
DROP PROCEDURE IF EXISTS inflated_price;
DELIMITER $$
CREATE PROCEDURE inflated_price(IN inflation_rate FLOAT)
BEGIN 
	START TRANSACTION;
		UPDATE mobiles_info
        SET price = price * (inflation_rate + 1)
        #reference the primary key for safety mode
        WHERE title <> '';
    COMMIT;
END;
$$

#exclude the phones made before 2018
SET @least_year = 2018;
CALL exclude_year(@least_year);
SELECT * FROM mobiles_year;

#set the inflation rate to 0.2 and upte the price
SET @inflation_rate = 0.2;
CALL inflated_price(@inflation_rate);
SELECT * FROM mobiles_info;
