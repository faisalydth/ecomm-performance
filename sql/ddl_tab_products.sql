/* =======================================
TABLE PRODUCTS
Created by : faisalydth
Created date : 03-03-2022
======================================= */

CREATE TABLE products (
    id	                    VARCHAR(50),
    category_name	        VARCHAR(50),
    product_name_len	    INTEGER,
    product_desc_len	    INTEGER,
    product_photos_qty	    INTEGER,
    product_weight	        INTEGER COMMENT 'unit : g',
    product_length	        INTEGER COMMENT 'unit : cm',
    product_height	        INTEGER COMMENT 'unit : cm',
    product_width	        INTEGER COMMENT 'unit : cm'
);

TRUNCATE TABLE products;

LOAD DATA INFILE 'E:/GitHub/ecomm-performance/__dataset/products_mod.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, category_name, @product_name_len, @product_desc_len, @product_photos_qty, @product_weight, @product_length, @product_height, product_width)
SET
    product_name_len = IF(@product_name_len = '', NULL, @product_name_len),
    product_desc_len = IF(@product_desc_len = '', NULL, @product_desc_len),
    product_photos_qty = IF(@product_photos_qty = '', NULL, @product_photos_qty),
    product_weight = IF(@product_weight = '', NULL, @product_weight),
    product_length = IF(@product_length = '', NULL, @product_length),
    product_height = IF(@product_height = '', NULL, @product_height);

UPDATE products SET product_width = NULL WHERE product_width = -1;

ALTER TABLE products ADD CONSTRAINT products_pk PRIMARY KEY (id);