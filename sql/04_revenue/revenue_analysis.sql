-- 1. Revenue Overview
SELECT
	COUNT(*) AS orders,
	ROUND(SUM(price_usd), 2) AS revenue,
	ROUND(AVG(price_usd), 2) AS aov
FROM [web_analytics].[orders];

-- 2. Revenue by Acquisition Source
SELECT
	COALESCE(ws.utm_source, 'organic/direct') AS source,
	COUNT(o.order_id) AS orders,
	ROUND(SUM(o.price_usd), 2) AS revenue,
	ROUND(AVG(o.price_usd), 2) AS aov
FROM [web_analytics].[orders] AS o
JOIN [web_analytics].[website_sessions] AS ws
ON o.website_session_id = ws.website_session_id
GROUP BY COALESCE(ws.utm_source, 'organic/direct')
ORDER BY revenue DESC;

-- 3. Revenue by Campaign
SELECT
	ws.utm_campaign,
	COUNT(o.order_id) AS orders,
	ROUND(SUM(o.price_usd), 2) AS revenue,
	ROUND(AVG(o.price_usd), 2) AS aov
FROM [web_analytics].[orders] AS o
JOIN [web_analytics].[website_sessions] AS ws
ON o.website_session_id = ws.website_session_id
GROUP BY ws.utm_campaign
ORDER BY revenue DESC;

-- 4. Revenue by Device Type
SELECT
	ws.device_type,
	COUNT(o.order_id) AS orders,
	ROUND(SUM(o.price_usd), 2) AS revenue,
	ROUND(AVG(o.price_usd), 2) AS aov
FROM [web_analytics].[orders] AS o
JOIN [web_analytics].[website_sessions] AS ws
ON o.website_session_id = ws.website_session_id
GROUP BY ws.device_type
ORDER BY revenue DESC;

-- 5. Product Revenue Analysis
SELECT
	p.product_name,
	COUNT(oi.order_item_id) AS items_sold,
	ROUND(SUM(oi.price_usd), 2) AS revenue
FROM [web_analytics].[order_items] AS oi
JOIN [web_analytics].products AS p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- 6. Profitability Analysis
SELECT
	p.product_name,
	ROUND(SUM(oi.price_usd), 2) AS revenue,
	ROUND(SUM(oi.cogs_usd), 2) AS cogs,
	ROUND(SUM(oi.price_usd) - SUM(oi.cogs_usd), 2) AS gross_profit
FROM [web_analytics].[order_items] AS oi
JOIN [web_analytics].products AS p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY gross_profit DESC;