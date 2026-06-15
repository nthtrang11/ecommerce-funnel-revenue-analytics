-- 1. Traffic Attribution
SELECT
	COALESCE(utm_source, 'organic/direct') AS source,
	COUNT(*) AS sessions,
	ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM [web_analytics].[website_sessions]), 2) AS traffic_share
FROM [web_analytics].[website_sessions]
GROUP BY COALESCE(utm_source, 'organic/direct')
ORDER BY traffic_share DESC;

-- 2. Source Efficiency
SELECT
	COALESCE(utm_source, 'organic/direct') AS source,
	COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
	ROUND(SUM(o.price_usd), 2) AS revenue,
	ROUND(100.0 * COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id), 2) AS conversion_rate
FROM [web_analytics].[website_sessions] ws
LEFT JOIN [web_analytics].[orders] o
ON ws.website_session_id = o.website_session_id
GROUP BY COALESCE(utm_source, 'organic/direct')
ORDER BY revenue DESC;