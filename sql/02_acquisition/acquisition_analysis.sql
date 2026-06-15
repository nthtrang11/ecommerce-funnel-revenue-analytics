-- 1. Traffic Overview
SELECT COUNT(*) AS total_sessions
FROM [web_analytics].[website_sessions];

-- 2. Traffic by Source
SELECT
	COALESCE(utm_source, 'organic/direct') AS source,
	COUNT(*) AS sessions
FROM [web_analytics].[website_sessions]
GROUP BY COALESCE(utm_source, 'organic/direct')
ORDER BY sessions DESC;

-- 3. Orders by Source
SELECT
	COALESCE(ws.utm_source, 'organic/direct') AS source,
	COUNT(o.order_id) AS orders
FROM [web_analytics].[website_sessions] AS ws
LEFT JOIN [web_analytics].[orders] AS o
ON o.website_session_id = ws.website_session_id
GROUP BY COALESCE(ws.utm_source, 'organic/direct')
ORDER BY orders DESC;

-- 4. conversion Rate by Source
SELECT
	COALESCE(ws.utm_source, 'organic/direct') AS source,
	COUNT(DISTINCT o.order_id) AS orders,
	COUNT(DISTINCT ws.website_session_id) AS sessions,
	ROUND(100.0 * COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id), 2) AS conversion_rate
FROM [web_analytics].[website_sessions] AS ws
LEFT JOIN [web_analytics].[orders] AS o
ON ws.website_session_id = o.website_session_id
GROUP BY COALESCE(ws.utm_source, 'organic/direct')
ORDER BY conversion_rate DESC;

-- 5. Campaign Performance
SELECT
	ws.utm_campaign,
	COUNT(DISTINCT o.order_id) AS orders,
	COUNT(DISTINCT ws.website_session_id) AS sessions,
	ROUND(100.0 * COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id), 2) AS conversion_rate
FROM [web_analytics].[website_sessions] AS ws
LEFT JOIN [web_analytics].[orders] AS o
ON ws.website_session_id = o.website_session_id
WHERE ws.utm_campaign IS NOT NULL
GROUP BY utm_campaign
ORDER BY conversion_rate DESC;

-- 6. Repeat Session Analysis
SELECT
    COALESCE(utm_source,'organic/direct') AS source,
    COUNT(*) AS total_sessions,
    SUM(
        CASE
            WHEN is_repeat_session = 1
            THEN 1
            ELSE 0
        END
    ) AS repeat_sessions,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN is_repeat_session = 1
                THEN 1
                ELSE 0
            END
        )
        /
        COUNT(*),
        2
    ) AS repeat_session_rate
FROM [web_analytics].[website_sessions]
GROUP BY COALESCE(utm_source,'organic/direct')
ORDER BY repeat_session_rate DESC;