-- 1. Customer Mix
SELECT
	CASE WHEN is_repeat_session = 1 THEN 'Repeat' ELSE 'New' END AS customer_type,
	COUNT(*) AS sessions
FROM [web_analytics].[website_sessions]
GROUP BY CASE WHEN is_repeat_session = 1 THEN 'Repeat' ELSE 'New' END;

-- 2. Conversion by Customer Type
SELECT
    CASE WHEN is_repeat_session = 1 THEN 'Repeat' ELSE 'New' END AS customer_type,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(100.0 * COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id), 2) AS conversion_rate
FROM [web_analytics].[website_sessions] ws
LEFT JOIN [web_analytics].[orders] o
ON ws.website_session_id = o.website_session_id
GROUP BY CASE WHEN is_repeat_session = 1 THEN 'Repeat' ELSE 'New' END;

-- 3. Revenue by Customer Type
SELECT
	CASE WHEN is_repeat_session = 1 THEN 'Repeat' ELSE 'New' END AS customer_type,
    COUNT(o.order_id) AS orders,
    ROUND(SUM(o.price_usd), 2) AS revenue,
    ROUND(AVG(o.price_usd), 2) AS aov
FROM [web_analytics].[orders] o
JOIN [web_analytics].[website_sessions] ws
ON o.website_session_id = ws.website_session_id
GROUP BY CASE WHEN is_repeat_session = 1 THEN 'Repeat' ELSE 'New' END;

-- 4. User-Level Repeat Behavior
SELECT AVG(session_count * 1.0) AS avg_sessions_per_user
FROM(
	SELECT 
		user_id,
		COUNT(*) AS session_count
	FROM [web_analytics].[website_sessions]
	GROUP BY user_id
) x;

-- 5. Repeat User Revenue Concentration
SELECT
	CASE WHEN is_repeat_session = 1 THEN 'Repeat' ELSE 'New' END AS customer_type,
	ROUND(100.0 * SUM(o.price_usd) / (SELECT SUM(price_usd) FROM [web_analytics].[orders]), 2) AS revenue_share
FROM [web_analytics].[orders] o
JOIN [web_analytics].[website_sessions] ws
ON o.website_session_id = ws.website_session_id
GROUP BY CASE WHEN is_repeat_session = 1 THEN 'Repeat' ELSE 'New' END;