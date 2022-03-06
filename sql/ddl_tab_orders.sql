/* =======================================
TABLE ORDERS
Created by : faisalydth
Created date : 03-03-2022
======================================= */

CREATE TABLE orders (
    id	                        VARCHAR(50),
    customer_id	                VARCHAR(50),
    status	                    VARCHAR(20),
    purchase_timestamp	        TIMESTAMP,
    approved_at	                TIMESTAMP,
    delivered_carrier_date	    TIMESTAMP,
    delivered_customer_date	    TIMESTAMP,
    estimated_delivery_date     DATE
);

TRUNCATE TABLE orders;

LOAD DATA INFILE 'E:/GitHub/ecomm-performance/__dataset/orders_mod.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, customer_id, status, purchase_timestamp, @approved_at, @delivered_carrier_date, @delivered_customer_date, estimated_delivery_date)
SET
    approved_at = IF(@approved_at = '', NULL, @approved_at),
    delivered_carrier_date = IF(@delivered_carrier_date = '', NULL, @delivered_carrier_date),
    delivered_customer_date = IF(@delivered_customer_date = '', NULL, @delivered_customer_date);

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY (id);
ALTER TABLE orders ADD CONSTRAINT orders_customers_fk FOREIGN KEY (customer_id) REFERENCES customers (id);