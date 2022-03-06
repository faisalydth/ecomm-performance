/* =======================================
TABLE ORDER ITEMS
Created by : faisalydth
Created date : 03-03-2022
======================================= */

CREATE TABLE order_items (
    order_id	            VARCHAR(50),
    order_item_id	        INTEGER,
    product_id	            VARCHAR(50),
    seller_id	            VARCHAR(50),
    shipping_limit_date	    TIMESTAMP,
    price	                DECIMAL(10, 2),
    freight_value	        DECIMAL(10, 2)
);

TRUNCATE TABLE order_items;

LOAD DATA INFILE 'E:/GitHub/ecomm-performance/__dataset/order_items_mod.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE order_items ADD CONSTRAINT order_items_orders_fk FOREIGN KEY (order_id) REFERENCES orders (id);
ALTER TABLE order_items ADD CONSTRAINT order_items_products_fk FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE order_items ADD CONSTRAINT order_items_sellers_fk FOREIGN KEY (seller_id) REFERENCES sellers (id);