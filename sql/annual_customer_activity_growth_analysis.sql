/* =======================================
ANNUAL CUSTOMER ACTIVITY GROWTH ANALYSIS
Created by : faisalydth
Created date : 06-03-2022
======================================= */

-- 1. rata-rata jumlah customer aktif bulanan (monthly active user) untuk setiap tahun
CREATE VIEW acag_monthly_active_user AS
SELECT
    g2.year,
    1.0 * sum(g2.n_customer) / 12 AS avg_monthly_active_user
FROM (
    SELECT
        g.year,
        g.month,
        count(g.customer_unique_id) AS n_customer
    FROM (
        SELECT
            c.customer_unique_id,
            year(o.purchase_timestamp) AS year,
            month(o.purchase_timestamp) AS month
        FROM orders o
        INNER JOIN customers c ON o.customer_id = c.id
    ) AS g
    GROUP BY g.year, g.month
    ORDER BY g.year, g.month
) AS g2
GROUP BY g2.year
ORDER BY g2.year
;

-- 2. jumlah customer baru pada masing-masing tahun
CREATE VIEW acag_new_user AS
SELECT
	g.year,
	count(g.customer_unique_id) AS new_user
FROM (
	SELECT 
		c.customer_unique_id,
		min(year(o.purchase_timestamp)) AS year
	FROM orders o
	INNER JOIN customers c ON o.customer_id = c.id
	GROUP BY c.customer_unique_id
) AS g
GROUP BY g.year
ORDER BY g.year
;

-- 3. jumlah customer yang melakukan pembelian lebih dari satu kali (repeat order) pada masing-masing tahun
CREATE VIEW acag_user_repeat_order AS
SELECT
	g2.year,
	count(g2.customer_unique_id) AS count_user_repeat_order
FROM (
	SELECT
		g.customer_unique_id,
		g.year,
		count(g.customer_unique_id) AS n_order
	FROM (
		SELECT 
			c.customer_unique_id,
			year(o.purchase_timestamp) AS year
		FROM orders o
		INNER JOIN customers c ON o.customer_id = c.id
	) AS g
	GROUP BY g.customer_unique_id, g.year
	HAVING n_order > 1
) AS g2
GROUP BY g2.year
ORDER BY g2.year
;

-- 4. rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun
CREATE VIEW acag_total_order AS
WITH customer_orders AS (
	SELECT
		g.customer_unique_id,
		g.year,
		count(g.customer_unique_id) AS n_order
	FROM (
		SELECT 
			c.customer_unique_id,
			year(o.purchase_timestamp) AS year
		FROM orders o
		INNER JOIN customers c ON o.customer_id = c.id
	) AS g
	GROUP BY g.customer_unique_id, g.year
),
n_orders AS (
	SELECT
		year,
		count(year) AS n_year
	FROM customer_orders
	GROUP BY year
)
SELECT
	c.year,
	1.0 * sum(c.n_order) / n.n_year AS avg_order
FROM customer_orders c
INNER JOIN n_orders n ON c.year = n.year
GROUP BY c.year
ORDER BY c.year
;

-- 5. metrics
SELECT
    mau.year,
    mau.avg_monthly_active_user,
    nu.new_user,
    uro.count_user_repeat_order,
    tor.avg_order
FROM acag_monthly_active_user mau
INNER JOIN acag_new_user nu ON mau.year = nu.year
INNER JOIN acag_user_repeat_order uro ON mau.year = uro.year
INNER JOIN acag_total_order tor ON mau.year = tor.year
ORDER BY mau.year
;