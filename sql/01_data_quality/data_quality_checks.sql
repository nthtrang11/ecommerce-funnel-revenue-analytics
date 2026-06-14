-- ==================================================================
-- PROJECT: E-COMMERCE DATA QUALITY CHECKS
-- PURPOSE: Check Null, Unique PK, and Data Logic before Analysis
-- ==================================================================

---------------------------------------------------------------------
-- 1. DATASET OVERVIEW
---------------------------------------------------------------------
SELECT 'website_sessions' AS table_name,
       COUNT(*) AS row_count
FROM [web_analytics].[website_sessions]

UNION ALL

SELECT 'website_pageviews',
       COUNT(*)
FROM [web_analytics].[website_pageviews]

UNION ALL

SELECT 'orders',
       COUNT(*)
FROM [web_analytics].[orders]

UNION ALL

SELECT 'order_items',
       COUNT(*)
FROM [web_analytics].[order_items]

UNION ALL

SELECT 'order_item_refunds',
       COUNT(*)
FROM [web_analytics].[order_item_refunds]

UNION ALL

SELECT 'products',
       COUNT(*)
FROM [web_analytics].[products];

---------------------------------------------------------------------
-- 2. PRIMARY KEY UNIQUENESS
---------------------------------------------------------------------
SELECT
    website_session_id,
    COUNT(*) AS duplicate_count
FROM [web_analytics].[website_sessions]
GROUP BY website_session_id
HAVING COUNT(*) > 1;

SELECT
	website_pageview_id,
	COUNT(*) AS duplicate_count
FROM [web_analytics].[website_pageviews]
GROUP BY website_pageview_id
HAVING COUNT(*) > 1;

SELECT
	order_id,
	COUNT(*) AS duplicate_count
FROM [web_analytics].[orders]
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
	order_item_id,
	COUNT(*) AS duplicate_count
FROM [web_analytics].[order_items]
GROUP BY order_item_id
HAVING COUNT(*) > 1;

SELECT
	order_item_refund_id,
	COUNT(*) AS duplicate_count
FROM [web_analytics].[order_item_refunds]
GROUP BY order_item_refund_id
HAVING COUNT(*) > 1;

SELECT
	product_id,
	COUNT(*) AS duplicate_count
FROM [web_analytics].[products]
GROUP BY product_id
HAVING COUNT(*) > 1;

---------------------------------------------------------------------
-- 3. NULL VALUE CHECK
---------------------------------------------------------------------
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS null_created_at,
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS null_user_id,
    SUM(CASE WHEN utm_source IS NULL THEN 1 ELSE 0 END) AS null_utm_source,
    SUM(CASE WHEN utm_campaign IS NULL THEN 1 ELSE 0 END) AS null_utm_campaign,
    SUM(CASE WHEN device_type IS NULL THEN 1 ELSE 0 END) AS null_device_type
FROM [web_analytics].[website_sessions];

SELECT
    http_referer,
    COUNT(*) AS sessions
FROM [web_analytics].[website_sessions]
WHERE utm_source IS NULL
GROUP BY http_referer
ORDER BY sessions DESC;

SELECT
	COUNT(*) AS total_rows,
	SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS null_created_at,
	SUM(CASE WHEN website_session_id IS NULL THEN 1 ELSE 0 END) AS null_session_id,
	SUM(CASE WHEN pageview_url IS NULL THEN 1 ELSE 0 END) AS null_pageview_url
FROM [web_analytics].[website_pageviews];

SELECT
	COUNT(*) AS total_rows,
	SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS null_created_at,
	SUM(CASE WHEN website_session_id IS NULL THEN 1 ELSE 0 END) AS null_session_id,
	SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS null_user_id,
	SUM(CASE WHEN price_usd IS NULL THEN 1 ELSE 0 END) AS null_price_usd,
    SUM(CASE WHEN cogs_usd IS NULL THEN 1 ELSE 0 END) AS null_cogs_usd
FROM [web_analytics].[orders];

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN price_usd IS NULL THEN 1 ELSE 0 END) AS null_price_usd
FROM [web_analytics].[order_items];

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS null_order_item_id,
    SUM(CASE WHEN refund_amount_usd IS NULL THEN 1 ELSE 0 END) AS null_refund_amount_usd
FROM [web_analytics].[order_item_refunds];

---------------------------------------------------------------------
-- 4. FOREIGN KEY INTEGRITY
---------------------------------------------------------------------

-- FK CHECK: website_pageviews -> website_sessions
SELECT
    COUNT(*) AS orphan_pageviews
FROM [web_analytics].[website_pageviews] pv
LEFT JOIN [web_analytics].[website_sessions] ws
ON pv.website_session_id = ws.website_session_id
WHERE ws.website_session_id IS NULL;

-- FK CHECK: orders -> website_sessions
SELECT
	COUNT(*) AS orphan_orders
FROM [web_analytics].[orders] o
LEFT JOIN [web_analytics].[website_sessions] ws
ON o.website_session_id = ws.website_session_id
WHERE ws.website_session_id IS NULL;

-- FK CHECK: order_items -> orders
SELECT
    COUNT(*) AS orphan_order_items
FROM [web_analytics].[order_items] oi
LEFT JOIN [web_analytics].[orders] o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- FK CHECK: order_items -> products
SELECT
    COUNT(*) AS orphan_products
FROM [web_analytics].[order_items] oi
LEFT JOIN [web_analytics].[products] p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- FK CHECK: refunds -> order_items
SELECT
    COUNT(*) AS orphan_refunds
FROM [web_analytics].[order_item_refunds] r
LEFT JOIN [web_analytics].[order_items] oi
ON r.order_item_id = oi.order_item_id
WHERE oi.order_item_id IS NULL;

-- FK CHECK: refunds -> orders
SELECT
    COUNT(*) AS orphan_refund_orders
FROM [web_analytics].[order_item_refunds] r
LEFT JOIN [web_analytics].[orders] o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

---------------------------------------------------------------------
-- 5. DATE RANGE CHECK
---------------------------------------------------------------------
SELECT
    'website_sessions' AS table_name,
    MIN(created_at) AS start_date,
    MAX(created_at) AS end_date
FROM [web_analytics].[website_sessions]

UNION ALL

SELECT
    'website_pageviews',
    MIN(created_at),
    MAX(created_at)
FROM [web_analytics].[website_pageviews]

UNION ALL

SELECT
    'orders',
    MIN(created_at),
    MAX(created_at)
FROM [web_analytics].[orders]

UNION ALL

SELECT
    'order_items',
    MIN(created_at),
    MAX(created_at)
FROM [web_analytics].[order_items]

UNION ALL

SELECT
    'order_item_refunds',
    MIN(created_at),
    MAX(created_at)
FROM [web_analytics].[order_item_refunds]

UNION ALL

SELECT
    'products',
    MIN(created_at),
    MAX(created_at)
FROM [web_analytics].[products];
 
---------------------------------------------------------------------
-- 6. BUSINESS SANITY CHECK
---------------------------------------------------------------------

-- Negative Revenue
SELECT
    COUNT(*) AS negative_revenue_orders
FROM [web_analytics].[orders]
WHERE price_usd < 0;

-- Negative COGS
SELECT
    COUNT(*) AS negative_cogs_orders
FROM [web_analytics].[orders]
WHERE cogs_usd < 0;

-- Revenue < COGS
SELECT
    COUNT(*) AS loss_orders
FROM [web_analytics].[orders]
WHERE price_usd < cogs_usd;

-- Invalid Items Purchased
SELECT
    COUNT(*) AS invalid_orders
FROM [web_analytics].[orders]
WHERE items_purchased <= 0;

-- Negative Product Price
SELECT
    COUNT(*) AS negative_price_items
FROM [web_analytics].[order_items]
WHERE price_usd < 0;

-- Negative Refund
SELECT
    COUNT(*) AS negative_refunds
FROM [web_analytics].[order_item_refunds]
WHERE refund_amount_usd < 0;

-- Refund > Product Price
SELECT
    COUNT(*) AS invalid_refunds
FROM [web_analytics].[order_item_refunds] r
JOIN [web_analytics].[order_items] oi
ON r.order_item_id = oi.order_item_id
WHERE r.refund_amount_usd > oi.price_usd;

-- Product Price = 0
SELECT
    COUNT(*) AS zero_price_items
FROM [web_analytics].[order_items]
WHERE price_usd = 0;