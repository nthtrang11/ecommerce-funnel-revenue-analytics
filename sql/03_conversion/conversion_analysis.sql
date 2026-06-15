-- 1. Overall Conversion Rate
SELECT
	COUNT(DISTINCT o.order_id) AS orders,
	COUNT(DISTINCT ws.website_session_id) AS sessions,
	ROUND(100.0 * COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id), 2) AS conversion_rate
FROM [web_analytics].[website_sessions] AS ws
LEFT JOIN [web_analytics].[orders] AS o
ON ws.website_session_id = o.website_session_id;

-- 2. Device Conversion Analysis
SELECT
	ws.device_type,
	COUNT(DISTINCT o.order_id) AS orders,
	COUNT(DISTINCT ws.website_session_id) AS sessions,
	ROUND(100.0 * COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id), 2) AS conversion_rate
FROM [web_analytics].[website_sessions] AS ws
LEFT JOIN [web_analytics].[orders] AS o
ON ws.website_session_id = o.website_session_id
GROUP BY ws.device_type
ORDER BY conversion_rate DESC;

-- 3. Landing Page Performance
WITH first_pageview AS
(
	SELECT 
		website_session_id,
		MIN(website_pageview_id) AS first_pageview_id
	FROM [web_analytics].[website_pageviews]
	GROUP BY website_session_id
)

SELECT
	wp.pageview_url AS landing_page,
	COUNT(*) AS sessions
FROM first_pageview fp
JOIN [web_analytics].[website_pageviews] wp
ON fp.first_pageview_id = wp.website_pageview_id
GROUP BY wp.pageview_url
ORDER BY sessions DESC;

-- Landing Page Conversion Rate
WITH first_pageview AS
(
    SELECT
        website_session_id,
        MIN(website_pageview_id) AS first_pageview_id
    FROM [web_analytics].[website_pageviews]
    GROUP BY website_session_id
),

landing_page AS
(
    SELECT
        fp.website_session_id,
        wp.pageview_url
    FROM first_pageview fp
    JOIN [web_analytics].[website_pageviews] wp
    ON fp.first_pageview_id = wp.website_pageview_id
)

SELECT
    lp.pageview_url AS landing_page,
    COUNT(*) AS sessions,
    COUNT(o.order_id) AS orders,
    ROUND(100.0 * COUNT(o.order_id) / COUNT(*), 2) AS conversion_rate
FROM landing_page lp
LEFT JOIN [web_analytics].[orders] o
ON lp.website_session_id = o.website_session_id
GROUP BY lp.pageview_url
ORDER BY conversion_rate DESC;

-- 4. Funnel Analysis
SELECT
    pageview_url,
    COUNT(DISTINCT website_session_id) AS sessions
FROM [web_analytics].[website_pageviews]
GROUP BY pageview_url
ORDER BY sessions DESC;

-- Funnel
SELECT
	COUNT(DISTINCT CASE
		WHEN pageview_url='/products'
		THEN website_session_id
	END) AS products,

	COUNT(DISTINCT CASE
		WHEN pageview_url IN (
			'/the-original-mr-fuzzy',
			'/the-forever-love-bear',
			'/the-birthday-sugar-panda',
			'/the-hudson-river-mini-bear'
		)
		THEN website_session_id
	END) AS product_detail,

	COUNT(DISTINCT CASE
		WHEN pageview_url='/cart'
		THEN website_session_id
	END) AS cart,

	COUNT(DISTINCT CASE
		WHEN pageview_url='/shipping'
		THEN website_session_id
	END) AS shipping,

	COUNT(DISTINCT CASE
		WHEN pageview_url IN
		(
			'/billing',
			'/billing-2'
		)
		THEN website_session_id
	END) AS billing,

	COUNT(DISTINCT CASE
		WHEN pageview_url='/thank-you-for-your-order'
		THEN website_session_id
	END) AS orders

FROM [web_analytics].[website_pageviews];

-- 5. Checkout Performance
WITH billing_sessions AS
(
    SELECT DISTINCT
        website_session_id,
        pageview_url AS billing_version
    FROM [web_analytics].[website_pageviews]
    WHERE pageview_url IN
    (
        '/billing',
        '/billing-2'
    )
)

SELECT
    bs.billing_version,
    COUNT(DISTINCT bs.website_session_id) AS billing_sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(100.0 * COUNT(DISTINCT o.order_id) / COUNT(DISTINCT bs.website_session_id), 2) AS checkout_conversion_rate
FROM billing_sessions bs
LEFT JOIN [web_analytics].[orders] o
ON bs.website_session_id = o.website_session_id
GROUP BY bs.billing_version
ORDER BY checkout_conversion_rate DESC;