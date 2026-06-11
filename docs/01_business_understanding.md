# Business Understanding

## Project Background

The company operates an e-commerce platform and tracks the complete customer journey from website visit to purchase and refund.

The business collects detailed web analytics data across the entire funnel:

Website Session → Pageview → Order → Order Item → Refund

This tracking system enables the company to understand how customers interact with the website, evaluate marketing performance, measure conversion effectiveness, and monitor product profitability.

The dataset contains six tables:

* website_sessions
* website_pageviews
* orders
* order_items
* order_item_refunds
* products

Together, these tables provide a complete view of customer acquisition, behavior, conversion, revenue generation, and post-purchase outcomes.

---

## Business Context

As the company grows, management teams require data-driven insights to optimize marketing investment, improve website performance, and increase profitability.

Several departments have raised important business questions:

### Marketing Team

Marketing campaigns generate a significant portion of website traffic.

However, the team does not know:

* Which traffic sources bring the most visitors
* Which campaigns generate the highest conversion rates
* Which channels contribute the most revenue
* Whether current marketing spending is producing sufficient returns

### Product Team

The website conversion funnel consists of multiple steps:

Homepage → Product Page → Cart → Checkout → Thank-you Page

The Product Team suspects that a large number of visitors abandon the funnel before completing a purchase.

They need to identify:

* Where users drop off
* Which pages create friction
* Whether the user experience differs across devices

### Finance Team

Revenue growth alone does not reflect business performance.

Refunds can significantly reduce profitability.

The Finance Team needs visibility into:

* Revenue trends
* Cost of Goods Sold (COGS)
* Refund impact
* Net revenue by product

### Analytics Team

Marketing attribution remains unclear.

A customer may interact with multiple campaigns before purchasing.

The Analytics Team wants to understand:

* First-touch attribution
* Last-touch attribution
* Customer lifetime value (LTV)
* Retention behavior

---

## Business Objectives

This project aims to support business decision-making by addressing the following objectives:

### Objective 1: Improve Marketing Efficiency

Understand which acquisition channels generate high-quality traffic and revenue.

Expected outcomes:

* Better budget allocation
* Higher campaign ROI
* Reduced marketing waste

### Objective 2: Increase Conversion Rate

Identify bottlenecks within the website funnel.

Expected outcomes:

* Reduced abandonment
* Higher checkout completion rate
* Improved customer experience

### Objective 3: Improve Revenue Performance

Understand the key drivers of revenue growth.

Expected outcomes:

* Better visibility into sales performance
* Improved revenue forecasting capability
* Stronger business monitoring

### Objective 4: Reduce Refund Impact

Identify products with abnormal refund behavior.

Expected outcomes:

* Improved product quality monitoring
* Reduced revenue leakage
* Higher profitability

### Objective 5: Understand Customer Value

Measure customer retention and long-term value.

Expected outcomes:

* Improved customer lifecycle understanding
* Better retention strategy
* More effective acquisition investment

---

## Stakeholders

| Stakeholder                   | Business Goal                                    |
| ----------------------------- | ------------------------------------------------ |
| Chief Marketing Officer (CMO) | Improve campaign ROI and acquisition efficiency  |
| Product Manager               | Reduce funnel abandonment and improve conversion |
| Finance Team                  | Monitor profitability and refund impact          |
| Head of Analytics             | Develop attribution and customer value insights  |
| Executive Leadership          | Drive sustainable revenue growth                 |

---

## Core Business Problems

Based on stakeholder requirements, the company currently faces four major challenges.

### Problem 1: Acquisition Effectiveness

The company generates traffic from multiple marketing sources, but the relative effectiveness of each source is unclear.

Key question:

Which channels bring visitors that eventually convert into customers?

### Problem 2: Funnel Performance

Many users visit the website but do not complete a purchase.

Key question:

At which stage of the funnel are users abandoning the purchase journey?

### Problem 3: Product Profitability

Revenue figures alone may be misleading because refunds reduce actual earnings.

Key question:

Which products contribute the most net revenue after accounting for refunds?

### Problem 4: Customer Retention and Attribution

Customers may visit multiple times before purchasing.

Key question:

Which marketing touchpoints deserve credit for driving conversions and long-term value?

---

## Analytical Opportunities

Using the available dataset, the following analyses can be performed:

### Acquisition Analysis

* Sessions by source
* Sessions by campaign
* Device distribution
* Traffic trends

### Funnel Analysis

* Homepage → Product
* Product → Cart
* Cart → Checkout
* Checkout → Purchase

### Conversion Analysis

* Conversion rate by source
* Conversion rate by campaign
* Conversion rate by device

### Revenue Analysis

* Revenue trends
* Average Order Value (AOV)
* Revenue by source
* Revenue by device

### Refund Analysis

* Refund rate by product
* Refund impact on profitability
* Net revenue analysis

### Attribution Analysis

* First-touch attribution
* Last-touch attribution
* Marketing channel contribution

### Customer Analytics

* Repeat user behavior
* Cohort analysis
* Customer Lifetime Value (LTV)

---

## Project Success Criteria

The project will be considered successful if it can provide actionable recommendations that help stakeholders:

* Improve campaign performance
* Increase conversion rate
* Reduce funnel abandonment
* Reduce refund-related losses
* Improve customer retention
* Increase net revenue

The final deliverables will include SQL analysis, Python-based analytics, Power BI dashboards, and business recommendations.