/* =======================================
ANNUAL PRODUCT CATEGORY QUALITY ANALYSIS
Created by : faisalydth
Created date : 07-03-2022
======================================= */

-- 1. pendapatan/revenue perusahaan total untuk masing-masing tahun
CREATE VIEW apcqa_revenue AS
SELECT g.year, sum(g.revenue) AS revenue
FROM (
    SELECT year(o.purchase_timestamp) AS year, i.price + i.freight_value AS revenue
    FROM order_items i
    INNER JOIN orders o ON i.order_id = o.id
    WHERE o.status = 'delivered'
) AS g
GROUP BY g.year
ORDER BY g.year;

-- 2. jumlah cancel order total untuk masing-masing tahun
CREATE VIEW apcqa_canceled AS
SELECT g.year, count(g.status) AS count_canceled
FROM (
    SELECT year(purchase_timestamp) AS year, status
    FROM orders
    WHERE status = 'canceled'
) AS g
GROUP BY g.year
ORDER BY g.year;

-- 3. nama kategori produk yang memberikan pendapatan total tertinggi untuk masing-masing tahun
CREATE VIEW apcqa_top_category AS
SELECT g3.year, g3.category_name
FROM (
    SELECT dense_rank() OVER (PARTITION BY g2.year ORDER BY g2.revenue DESC) AS category_rank, g2.*
    FROM (
        SELECT g.year, g.category_name, sum(g.revenue) AS revenue
        FROM (
            SELECT year(o.purchase_timestamp) AS year, p.category_name, i.price + i.freight_value AS revenue
            FROM order_items i
            INNER JOIN orders o ON i.order_id = o.id
            INNER JOIN products p ON i.product_id = p.id
        ) AS g
        GROUP BY g.year, g.category_name
    ) AS g2
) AS g3
WHERE g3.category_rank = 1
ORDER BY g3.year;

-- 4. nama kategori produk yang memiliki jumlah cancel order terbanyak untuk masing-masing tahun
-- (Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan)
CREATE VIEW apcqa_top_category_canceled AS
SELECT g3.year, g3.category_name
FROM (
    SELECT dense_rank() OVER (PARTITION BY g2.year ORDER BY g2.n_category DESC) AS category_rank, g2.*
    FROM (
        SELECT g.year, g.category_name, count(g.category_name) AS n_category
        FROM (
            SELECT year(o.purchase_timestamp) AS year, p.category_name
            FROM order_items i
            INNER JOIN orders o ON i.order_id = o.id
            INNER JOIN products p ON i.product_id = p.id
            WHERE o.status = 'canceled'
        ) AS g
        GROUP BY g.year, g.category_name
    ) AS g2
) AS g3
WHERE g3.category_rank = 1
ORDER BY g3.year;

-- 5. metrics
SELECT
    r.year,
    r.revenue,
    c.count_canceled,
    tc.category_name AS top_revenue_category,
    tcc.category_name AS top_canceled_category
FROM apcqa_revenue r
INNER JOIN apcqa_canceled c ON r.year = c.year
INNER JOIN apcqa_top_category tc ON r.year = tc.year
INNER JOIN apcqa_top_category_canceled tcc ON r.year = tcc.year
ORDER BY r.year;