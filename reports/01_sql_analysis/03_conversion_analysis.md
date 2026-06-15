# Conversion Analysis Report

## Objective

The objective of this analysis is to evaluate website conversion performance, identify key funnel bottlenecks, and assess how device type, landing pages, and checkout experiences influence customer purchase behavior.

---

# 1. Overall Conversion Performance

## Results

| Metric          |   Value |
| --------------- | ------: |
| Sessions        | 472,871 |
| Orders          |  32,313 |
| Conversion Rate |   6.83% |

## Findings

The website generated 32,313 orders from 472,871 sessions, resulting in an overall conversion rate of 6.83%.

While the website successfully converts a portion of visitors into customers, the majority of sessions do not result in purchases. Further funnel analysis is required to identify where users exit the purchasing journey.

---

# 2. Device Conversion Analysis

## Results

| Device Type | Orders | Sessions | Conversion Rate |
| ----------- | -----: | -------: | --------------: |
| Desktop     | 27,805 |  327,027 |           8.50% |
| Mobile      |  4,508 |  145,844 |           3.09% |

## Findings

Desktop users demonstrate substantially stronger purchasing behavior than mobile users.

Although mobile devices account for approximately 31% of total traffic, they generate only 14% of total orders.

Desktop conversion performance is nearly three times higher than mobile conversion performance, suggesting that mobile users encounter greater friction during the purchase process.

## Hypothesis Evaluation

### H5 — Mobile Users Convert Less Efficiently Than Desktop Users

**Supported**

The data shows a significantly lower conversion rate for mobile users compared with desktop users.

## Business Implications

* Review the mobile user experience across key purchase stages.
* Investigate potential usability issues on product, cart, and checkout pages.
* Prioritize mobile optimization initiatives to improve conversion performance.

---

# 3. Landing Page Performance

## Results

| Landing Page | Sessions | Orders | Conversion Rate |
| ------------ | -------: | -----: | --------------: |
| /lander-5    |   68,166 |  6,930 |          10.17% |
| /lander-2    |  131,170 | 10,128 |           7.72% |
| /lander-4    |    9,385 |    708 |           7.54% |
| /home        |  137,576 |  9,711 |           7.06% |
| /lander-1    |   47,574 |  2,157 |           4.53% |
| /lander-3    |   79,000 |  2,679 |           3.39% |

## Findings

Landing page performance varies considerably across the website.

The highest-performing landing page is **/lander-5**, achieving a conversion rate of 10.17%, substantially above the website average of 6.83%.

Conversely, **/lander-3** records the lowest conversion rate at 3.39%, indicating that visitors entering through this page are significantly less likely to complete a purchase.

The results suggest that landing page design, messaging, and user experience play an important role in influencing conversion outcomes.

## Business Implications

* Increase traffic allocation toward high-performing landing pages such as **/lander-5**.
* Investigate why **/lander-3** and **/lander-1** underperform.
* Apply successful design and content elements from high-performing pages to lower-performing variants.

---

# 4. Funnel Analysis

## Results

| Funnel Step    | Sessions |
| -------------- | -------: |
| Products       |  261,231 |
| Product Detail |  210,214 |
| Cart           |   94,953 |
| Shipping       |   64,484 |
| Billing        |   52,058 |
| Orders         |   32,313 |

## Step-to-Step Conversion

| Transition                | Conversion Rate |
| ------------------------- | --------------: |
| Products → Product Detail |          80.47% |
| Product Detail → Cart     |          45.17% |
| Cart → Shipping           |          67.91% |
| Shipping → Billing        |          80.73% |
| Billing → Order           |          62.07% |

## Findings

The largest drop-off occurs between the **Product Detail** and **Cart** stages.

Only 45.17% of users who view a product detail page proceed to add a product to their cart. This represents the most significant loss of potential customers throughout the purchasing journey.

A second notable drop-off occurs during checkout, where only 62.07% of users who reach the billing stage complete their purchase.

These findings indicate that purchase decision-making at the product page and checkout completion are the two most critical conversion challenges.

## Hypothesis Evaluation

### H4 — Checkout Is the Largest Funnel Bottleneck

**Not Supported**

Although checkout contributes to customer drop-off, the largest funnel bottleneck occurs between the Product Detail and Cart stages.

## Business Implications

* Improve product detail pages by optimizing product descriptions, images, pricing presentation, and calls-to-action.
* Analyze user behavior on product pages to identify friction points before cart addition.
* Continue monitoring checkout performance as a secondary conversion bottleneck.

---

# 5. Checkout Performance

## Results

| Billing Version | Billing Sessions | Orders | Checkout Conversion Rate |
| --------------- | ---------------: | -----: | -----------------------: |
| /billing-2      |           48,441 | 30,693 |                   63.36% |
| /billing        |            3,617 |  1,620 |                   44.79% |

## Findings

The checkout experience differs substantially between billing page versions.

Version **/billing-2** achieves a checkout conversion rate of 63.36%, outperforming **/billing** by 18.57 percentage points.

The magnitude of this difference suggests that modifications introduced in the second billing version significantly improved checkout completion behavior.

## Business Implications

* Continue using **/billing-2** as the primary checkout experience.
* Consider retiring or redesigning the original **/billing** page.
* Apply ongoing experimentation and A/B testing to further improve checkout performance.

---

# Key Insights

1. The website achieves an overall conversion rate of 6.83%.
2. Desktop users convert at a substantially higher rate than mobile users.
3. Landing page performance varies significantly and strongly influences conversion outcomes.
4. **/lander-5** is the most effective landing page, while **/lander-3** is the weakest performer.
5. The largest funnel bottleneck occurs between Product Detail and Cart.
6. Checkout is a significant source of customer loss but is not the primary bottleneck.
7. Hypothesis H4 is not supported by the data.
8. Hypothesis H5 is supported by the data.
9. **/billing-2** delivers substantially better checkout performance than **/billing**.
10. Product page optimization and mobile experience improvements represent the largest opportunities for future conversion growth.