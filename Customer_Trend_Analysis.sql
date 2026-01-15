CREATE DATABASE customer_behavior;
USE customer_behavior;

SELECT * FROM customer;

-- -------------------------------------- Customer Purchase Behavior & Trend Analysis --------------------------------------

-- Q1. Total revenue by gender
SELECT gender, SUM(purchase_amount) AS Total_revenue
FROM customer
GROUP BY gender;

-- Q2. Top 5 products by average review rating
SELECT item_purchased, ROUND(AVG(review_rating),2) AS Avg_review_rating
FROM customer
GROUP BY item_purchased
ORDER BY Avg_review_rating DESC
LIMIT 5;

-- Q3. Customers who used a discount and spent more than average
SELECT customer_id, purchase_amount
FROM customer
WHERE discount_applied = 'Yes' AND (
		SELECT AVG(purchase_amount)
        FROM customer); 
        
-- Q4. Top purchased items per category
SELECT category,
       item_purchased,
       COUNT(*) AS total_orders
FROM customer
GROUP BY category, item_purchased
ORDER BY category, total_orders DESC;

-- Q5. Average Purchase Amounts between Standard and Express Shipping.
SELECT shipping_type, ROUND(AVG(purchase_amount),2) AS Avg_purchase_amount
FROM customer
WHERE shipping_type IN ("Standard", "Express")
GROUP BY shipping_type;

-- Q6. Total revenue per subscription status
SELECT subscription_status,
       ROUND(SUM(purchase_amount), 2) AS total_revenue
FROM customer
GROUP BY subscription_status;

-- Q7. Do subscribed customers spend more?
SELECT subscription_status,
       COUNT(customer_id) AS total_customers,
       ROUND(AVG(purchase_amount), 2) AS avg_spend,
       SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY subscription_status;

-- Q8. Revenue by Age Group
SELECT age_group, SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY age_group
ORDER BY total_revenue DESC;

-- Q9. Are repeat buyers likely to subscribe?
SELECT subscription_status, COUNT(customer_id) AS repeat_customers
FROM customer
WHERE previous_purchases > 5
GROUP BY subscription_status;

-- Q10. Segment customers (New / Returning / Loyal) based on purchase history
SELECT COUNT(customer_id) AS total_customers,
	CASE
		WHEN previous_purchases = 1 THEN 'New'
        WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
        ELSE 'Loyal'
	END AS customer_segment
FROM customer
GROUP BY customer_segment;

-- Q11. Top 10 Spender
SELECT customer_id, SUM(purchase_amount) AS amount_spent
FROM customer
GROUP BY customer_id
ORDER BY amount_spent DESC
LIMIT 10;

-- Q12. Average purchase amount per category
SELECT category, ROUND(AVG(purchase_amount), 2) AS avg_purchase
FROM customer
GROUP BY category
ORDER BY avg_purchase DESC;

-- Q13. Which payment method is used the most and generates the highest revenue?
SELECT payment_method,
       COUNT(customer_id) AS total_transactions,
       ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Q14. Average spending by season (Winter, Summer, etc.)
SELECT season, ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM customer
GROUP BY season
ORDER BY avg_purchase DESC;

-- Q15. Most popular item sizes and colors
SELECT size, color, COUNT(*) AS total_orders
FROM customer
GROUP BY size, color
ORDER BY total_orders DESC
LIMIT 5;

-- Q16. Locations contributing the most revenue
SELECT location,
       ROUND(SUM(purchase_amount),2) AS total_revenue,
       COUNT(customer_id) AS total_customers
FROM customer
GROUP BY location
ORDER BY total_revenue DESC
LIMIT 5;

-- Q17. Frequency of purchases vs. average purchase amount
SELECT frequency_of_purchases, ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customer
GROUP BY frequency_of_purchases
ORDER BY avg_spend DESC;
