/* =======================================
TABLE CUSTOMERS
Created by : faisalydth
Created date : 03-03-2022
======================================= */

CREATE TABLE customers (
    id	                VARCHAR(50),
    customer_unique_id	VARCHAR(50),
    zip_code_prefix	    INTEGER,
    city	            VARCHAR(50),
    state	            VARCHAR(2)
);

TRUNCATE TABLE customers;

LOAD DATA INFILE 'E:/GitHub/ecomm-performance/__dataset/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE customers ADD CONSTRAINT customers_pk PRIMARY KEY (id);
ALTER TABLE customers ADD CONSTRAINT customers_locations_fk FOREIGN KEY (zip_code_prefix) REFERENCES locations (zip_code_prefix);