/* =======================================
ANNUAL CUSTOMER ACTIVITY GROWTH ANALYSIS
Created by : faisalydth
Created date : 06-03-2022
======================================= */

-- Rata-rata Monthly Active User (MAU) per tahun
SELECT
    g.year,
    g.month,
    count(g.id) AS n_customer
FROM (
    SELECT
        c.id,
        year(o.purchase_timestamp) AS year,
        month(o.purchase_timestamp) AS month
    FROM orders o
    INNER JOIN customers c ON o.customer_id = c.id
) AS g
GROUP BY g.year, g.month
ORDER BY g.year, g.month
;

-- total customer baru per tahun


-- jumlah customer yang melakukan repeat order per tahun


-- rata-rata frekuensi order untuk setiap tahun

