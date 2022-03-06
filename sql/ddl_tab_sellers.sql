/* =======================================
TABLE SELLERS
Created by : faisalydth
Created date : 03-03-2022
======================================= */

CREATE TABLE sellers (
    id	                VARCHAR(50),
    zip_code_prefix	    INTEGER,
    city	            VARCHAR(50),
    state	            VARCHAR(2)
);

TRUNCATE TABLE sellers;

LOAD DATA INFILE 'E:/GitHub/ecomm-performance/__dataset/sellers.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE sellers ADD CONSTRAINT sellers_pk PRIMARY KEY (id);
ALTER TABLE sellers ADD CONSTRAINT sellers_locations_fk FOREIGN KEY (zip_code_prefix) REFERENCES locations (zip_code_prefix);