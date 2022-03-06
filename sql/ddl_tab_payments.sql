/* =======================================
TABLE PAYMENTS
Created by : faisalydth
Created date : 03-03-2022
======================================= */

CREATE TABLE payments (
    order_id	        VARCHAR(50),
    sequential	        INTEGER,
    type	            VARCHAR(20),
    installments	    INTEGER,
    value	            DECIMAL(10, 2)
);

TRUNCATE TABLE payments;

LOAD DATA INFILE 'E:/GitHub/ecomm-performance/__dataset/payments.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE payments ADD CONSTRAINT payments_orders_fk FOREIGN KEY (order_id) REFERENCES orders (id);