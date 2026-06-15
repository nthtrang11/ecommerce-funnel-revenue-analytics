-- 1. Refund Overview
SELECT
    COUNT(*) AS refunded_items,
    ROUND(SUM(refund_amount_usd), 2) AS total_refund_amount
FROM [web_analytics].[order_item_refunds];

-- 2. Overall Refund Rate
SELECT
	COUNT(DISTINCT oi.order_item_id) AS total_items,
	COUNT(DISTINCT r.order_item_refund_id) AS refunded_items,
	ROUND(100.0 * COUNT(DISTINCT r.order_item_refund_id) / COUNT(DISTINCT oi.order_item_id), 2) AS refund_rate
FROM [web_analytics].[order_items] oi
LEFT JOIN [web_analytics].[order_item_refunds] r
ON oi.order_item_id = r.order_item_id;

-- 3. Refund by Product
SELECT
	p.product_name,
	COUNT(r.order_item_refund_id) AS refunds,
	ROUND(SUM(r.refund_amount_usd), 2) AS refund_amount
FROM [web_analytics].[order_item_refunds] r
JOIN [web_analytics].[order_items] oi
ON r.order_item_id = oi.order_item_id
JOIN [web_analytics].[products] p
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY refund_amount DESC;

-- 4. Refund Rate by Product
SELECT
	p.product_name,
	COUNT(DISTINCT r.order_item_refund_id) AS refunded_items,
	COUNT(DISTINCT oi.order_item_id) AS items_sold,
	ROUND(100.0 * COUNT(DISTINCT r.order_item_refund_id) / COUNT(DISTINCT oi.order_item_id), 2) AS refund_rate
FROM [web_analytics].[order_items] oi
LEFT JOIN [web_analytics].[order_item_refunds] r
ON r.order_item_id = oi.order_item_id
JOIN [web_analytics].[products] p
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY refund_rate DESC;

-- 5. Net Revenue by Product
SELECT
    p.product_name,
    ROUND(SUM(oi.price_usd), 2) AS gross_revenue,
    ROUND(COALESCE(SUM(r.refund_amount_usd), 0), 2) AS refunds,
    ROUND(SUM(oi.price_usd) - COALESCE(SUM(r.refund_amount_usd), 0), 2) AS net_revenue
FROM [web_analytics].[order_items] oi
LEFT JOIN [web_analytics].[order_item_refunds] r
ON oi.order_item_id = r.order_item_id
JOIN [web_analytics].[products] p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY net_revenue DESC;