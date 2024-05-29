DROP DATABASE IF EXISTS india_phones;
CREATE DATABASE india_phones;
USE india_phones;

#DATABASE creation
DROP TABLE IF EXISTS mobiles_info;
CREATE TABLE mobiles_info(
	title VARCHAR(150) PRIMARY KEY,
	brand VARCHAR(20),
    model_name VARCHAR(20) NOT NULL,
    price INT,
    rating FLOAT,
    num_of_reviews INT,
    color VARCHAR(20),
    quick_charge VARCHAR(5),
    operating_system VARCHAR(20),
    _storage VARCHAR(10)
);
CREATE INDEX idx_brand ON mobiles_info(brand);				#attribute must be indexed for foreign key integrity
CREATE INDEX idx_model_name ON mobiles_info(model_name);	#attribute must be indexed for foreign key integrity

DROP TABLE IF EXISTS mobiles_country;
CREATE TABLE mobiles_country(
	brand VARCHAR(20) PRIMARY KEY,
    country VARCHAR(20) NOT NULL,
    FOREIGN KEY (brand) REFERENCES mobiles_info(brand)
);

DROP TABLE IF EXISTS mobiles_display;
CREATE TABLE mobiles_display(
	model_num INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(20),
    model VARCHAR(20),
    touchscreen VARCHAR(5),
    display_size FLOAT CHECK(display_size > 0),
    FOREIGN KEY (model) REFERENCES mobiles_info(model_name)
);

DROP TABLE IF EXISTS mobiles_year;
CREATE TABLE mobiles_year(
	brand VARCHAR(20),
    model VARCHAR(20),
    year_made INT CHECK(year_made > 1990),
    PRIMARY KEY(brand, model),
    FOREIGN KEY (model) REFERENCES mobiles_info(model_name)
);

#DATA loading
LOAD DATA LOCAL INFILE '/Users/maxlee/Library/Mobile Documents/com~apple~CloudDocs/Dalhousie/2023 Fall/csci 2141/ass/ass2/mobiles_info.csv' 	#get the file path
INTO TABLE mobiles_info		#table to be inserted
FIELDS TERMINATED BY ','	#data separation 
ENCLOSED BY '"' 			#data enclosing
LINES TERMINATED BY '\n' 	#line identification
IGNORE 1 LINES;				#ignore the header line
select * from mobiles_info;

LOAD DATA LOCAL INFILE '/Users/maxlee/Library/Mobile Documents/com~apple~CloudDocs/Dalhousie/2023 Fall/csci 2141/ass/ass2/mobiles_country.csv'
INTO TABLE mobiles_country
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
select * from mobiles_country;

LOAD DATA LOCAL INFILE '/Users/maxlee/Library/Mobile Documents/com~apple~CloudDocs/Dalhousie/2023 Fall/csci 2141/ass/ass2/mobiles_year.csv'
INTO TABLE mobiles_year
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
select * from mobiles_year;

LOAD DATA LOCAL INFILE '/Users/maxlee/Library/Mobile Documents/com~apple~CloudDocs/Dalhousie/2023 Fall/csci 2141/ass/ass2/mobiles_display.csv'
INTO TABLE mobiles_display
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
select * from mobiles_display;
