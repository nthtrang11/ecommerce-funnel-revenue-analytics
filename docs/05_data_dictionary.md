# Data Dictionary

## Dataset Overview

Dataset: Web Analytics

Business Process:

Website Session → Pageview → Order → Order Item → Refund

The dataset captures the complete customer journey from website visit to purchase and potential refund, enabling acquisition, conversion, revenue, attribution, and retention analysis.

---

# Table Summary

| Table              | Description                           | Rows       |
| ------------------ | ------------------------------------- | ---------- |
| website_sessions   | Website visit sessions                | ~472,900   |
| website_pageviews  | Individual page views within sessions | ~1,200,000 |
| orders             | Customer orders                       | ~32,300    |
| order_items        | Products purchased within orders      | ~40,000    |
| order_item_refunds | Refunded order items                  | ~1,700     |
| products           | Product master data                   | 4          |

---

## 1. Table website_sessions

Tracks user visits to the website.

| Column             | Description                                      |
| ------------------ | ------------------------------------------------ |
| website_session_id | Unique session identifier (PK)                   |
| created_at         | Session start timestamp                          |
| user_id            | User identifier                                  |
| is_repeat_session  | Indicates whether the visitor has visited before |
| utm_source         | Traffic acquisition source                       |
| utm_campaign       | Marketing campaign                               |
| utm_content        | Ad content variation                             |
| device_type        | Device used during the session                   |
| http_referer       | Referring website URL                            |

---

## 2. Table website_pageviews

Tracks individual page views generated during a session.

| Column              | Description                        |
| ------------------- | ---------------------------------- |
| website_pageview_id | Unique pageview identifier (PK)    |
| created_at          | Pageview timestamp                 |
| website_session_id  | Associated session identifier (FK) |
| pageview_url        | URL viewed by the user             |

---

## 3.Table orders

Stores customer order information.

| Column             | Description                           |
| ------------------ | ------------------------------------- |
| order_id           | Unique order identifier (PK)          |
| created_at         | Order creation timestamp              |
| website_session_id | Session that generated the order (FK) |
| user_id            | Customer identifier                   |
| primary_product_id | Main product purchased                |
| items_purchased    | Number of items purchased             |
| price_usd          | Total order revenue                   |
| cogs_usd           | Total cost of goods sold              |

---

## 4. Table order_items

Stores product-level purchase information.

| Column          | Description                                |
| --------------- | ------------------------------------------ |
| order_item_id   | Unique order item identifier (PK)          |
| created_at      | Order item timestamp                       |
| order_id        | Associated order identifier (FK)           |
| product_id      | Purchased product identifier (FK)          |
| is_primary_item | Indicates primary product within the order |
| price_usd       | Product selling price                      |
| cogs_usd        | Product cost of goods sold                 |

---

## 5. Table order_item_refunds

Stores refund transactions.

| Column               | Description                         |
| -------------------- | ----------------------------------- |
| order_item_refund_id | Unique refund identifier (PK)       |
| created_at           | Refund timestamp                    |
| order_item_id        | Refunded order item identifier (FK) |
| order_id             | Associated order identifier (FK)    |
| refund_amount_usd    | Refunded amount                     |

---

## 6. Table products

Stores product master information.

| Column       | Description                    |
| ------------ | ------------------------------ |
| product_id   | Unique product identifier (PK) |
| created_at   | Product launch date            |
| product_name | Product name                   |

---

# Relationship Summary

| Parent Table     | Child Table        | Relationship |
| ---------------- | ------------------ | ------------ |
| website_sessions | website_pageviews  | One-to-Many  |
| website_sessions | orders             | One-to-Many  |
| orders           | order_items        | One-to-Many  |
| orders           | order_item_refunds | One-to-Many  |
| products         | order_items        | One-to-Many  |