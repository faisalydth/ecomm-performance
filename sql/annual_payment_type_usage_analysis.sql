/* =======================================
ANNUAL PAYMENT TYPE USAGE ANALYSIS
Created by : faisalydth
Created date : 08-03-2022
======================================= */

-- 1. jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit
SELECT type, count(type)
FROM payments
GROUP BY type;

-- 2. jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun
SELECT DISTINCT type FROM payments;
WITH cte_payments AS (
    SELECT g2.*, g2.credit_card + g2.boleto + g2.voucher + g2.debit_card AS total
    FROM (
        SELECT g.year, sum(g.credit_card) AS credit_card, sum(g.boleto) AS boleto, sum(g.voucher) AS voucher, sum(g.debit_card) AS debit_card
        FROM (
            SELECT
                year(o.purchase_timestamp) AS year,
                CASE WHEN p.type = 'credit_card' THEN 1 ELSE 0 END AS credit_card,
                CASE WHEN p.type = 'boleto' THEN 1 ELSE 0 END AS boleto,
                CASE WHEN p.type = 'voucher' THEN 1 ELSE 0 END AS voucher,
                CASE WHEN p.type = 'debit_card' THEN 1 ELSE 0 END AS debit_card
            FROM payments AS p
            JOIN orders o ON p.order_id = o.id
        ) AS g
        GROUP BY g.year
        ORDER BY g.year
    ) AS g2
)
SELECT * FROM cte_payments
UNION ALL
SELECT NULL AS year, sum(credit_card) AS credit_card, sum(boleto) AS boleto, sum(voucher) AS voucher, sum(debit_card) AS debit_card, sum(total) AS total FROM cte_payments
;