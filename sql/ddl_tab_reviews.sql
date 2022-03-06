/* =======================================
TABLE REVIEWS
Created by : faisalydth
Created date : 03-03-2022
======================================= */

CREATE TABLE reviews (
    id	                VARCHAR(50),
    order_id	        VARCHAR(50),
    score	            INTEGER,
    comment_title	    VARCHAR(50),
    comment_message	    VARCHAR(4000),
    creation_date	    DATE,
    answer_timestamp	TIMESTAMP
);

TRUNCATE TABLE reviews;

LOAD DATA INFILE 'E:/GitHub/ecomm-performance/__dataset/reviews_mod.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE reviews ADD CONSTRAINT reviews_orders_fk FOREIGN KEY (order_id) REFERENCES orders (id);