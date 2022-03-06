/* =======================================
TABLE GEOLOCATIONS
Created by : faisalydth
Created date : 03-03-2022
======================================= */

CREATE TABLE geolocations (
    zip_code_prefix	    INTEGER,
    latitude	        DECIMAL(10, 6),
    longitude	        DECIMAL(10, 6),
    city	            VARCHAR(50),
    state	            VARCHAR(2)
);

TRUNCATE TABLE geolocations;

LOAD DATA INFILE 'E:/GitHub/ecomm-performance/__dataset/geolocations.csv'
INTO TABLE geolocations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE locations AS
SELECT DISTINCT zip_code_prefix FROM GEOLOCATIONS;

ALTER TABLE locations ADD CONSTRAINT locations_pk PRIMARY KEY (zip_code_prefix);
ALTER TABLE geolocations ADD CONSTRAINT geolocations_locations_fk FOREIGN KEY (zip_code_prefix) REFERENCES locations (zip_code_prefix);