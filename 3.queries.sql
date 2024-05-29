#1.select where
#look up the phone and price with brand Apple
SELECT title, price FROM mobiles_info
	WHERE brand = 'APPLE'
    ORDER BY price DESC;
#2.join
#look up the phones with no touchscreen
SELECT mobiles_info.brand, model_name, rating, display_size
	FROM mobiles_info INNER JOIN mobiles_display ON model_name = model
    WHERE touchscreen = 'No'
    ORDER BY rating;

#3.group
#look up the phone brand and country rand that has the most expensive average price
SELECT brand, country, ROUND(AVG(price), 0) as avgPrice
	FROM mobiles_info INNER JOIN mobiles_country USING(brand)
	GROUP BY brand, country
	ORDER BY avgPrice DESC;

#4.subquery
#loop up the phones that has a price that is above average
SELECT title, price FROM mobiles_info
	WHERE price > (	SELECT ROUND(AVG(price), 0) as avgPrice
						FROM mobiles_info)
	ORDER BY price DESC;

#5.view, modify and compare
#look up phones average price with the rating above 4.5
DROP VIEW IF EXISTS nice_phones;
CREATE VIEW nice_phones AS(
	SELECT brand, country, AVG(price) as avg_price
		FROM mobiles_info INNER JOIN mobiles_country USING(brand)
        WHERE rating > 4.5
        GROUP BY brand, country
        ORDER BY avg_price DESC
);
#check the view
SELECT * FROM nice_phones;
#modify mobiles_info add inflation
CALL inflated_price(0.3);
#rerun the view and reflect the changes
SELECT * FROM nice_phones;