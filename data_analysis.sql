-- 1. Which users signed up for gold membership and when?
SELECT u.userid, u.signup_date, g.gold_signup_date
FROM users u
JOIN goldusers_signup g ON u.userid = g.userid;

-- 2. What is the total sales amount for each user?
SELECT s.userid, SUM(p.price) AS total_sales
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.userid;

-- 3. What are the products purchased by each user?
SELECT u.userid, p.product_name, s.created_date
FROM sales s
JOIN users u ON s.userid = u.userid
JOIN product p ON s.product_id = p.product_id
ORDER BY u.userid, s.created_date;

-- 4. Which user made the highest number of purchases?
SELECT s.userid, COUNT(s.product_id) AS purchase_count
FROM sales s
GROUP BY s.userid
ORDER BY purchase_count DESC
LIMIT 1;

-- 5. What is the total revenue generated from each product?
SELECT p.product_name, SUM(p.price) AS total_revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 6. Find users who made purchases before signing up for gold membership.
SELECT u.userid, s.created_date, g.gold_signup_date
FROM users u
JOIN sales s ON u.userid = s.userid
JOIN goldusers_signup g ON u.userid = g.userid
WHERE s.created_date < g.gold_signup_date;

-- 7. Which users purchased product 'p1'?
SELECT u.userid, u.signup_date, s.created_date
FROM sales s
JOIN users u ON s.userid = u.userid
JOIN product p ON s.product_id = p.product_id
WHERE p.product_name = 'p1';

-- 8. List the number of unique products bought by each user.
SELECT s.userid, COUNT(DISTINCT s.product_id) AS unique_products
FROM sales s
GROUP BY s.userid;

-- 9. What is the average sales value for users who signed up for gold membership?
SELECT g.userid, AVG(p.price) AS avg_sales_value
FROM sales s
JOIN goldusers_signup g ON s.userid = g.userid
JOIN product p ON s.product_id = p.product_id
GROUP BY g.userid;

-- 10. Show the sales details for users who signed up after 2015.
SELECT u.userid, s.created_date, p.product_name, p.price
FROM users u
JOIN sales s ON u.userid = s.userid
JOIN product p ON s.product_id = p.product_id
WHERE u.signup_date > '2015-01-01';

-- 11. Which user generated the most revenue after signing up for gold membership, and what is the total revenue?
SELECT g.userid, SUM(p.price) AS total_revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
JOIN goldusers_signup g ON s.userid = g.userid
WHERE s.created_date >= g.gold_signup_date
GROUP BY g.userid
ORDER BY total_revenue DESC
LIMIT 1;

--12. What is the percentage increase in sales after users became gold members compared to before?
WITH sales_before AS (
    SELECT g.userid, SUM(p.price) AS total_sales_before
    FROM sales s
    JOIN product p ON s.product_id = p.product_id
    JOIN goldusers_signup g ON s.userid = g.userid
    WHERE s.created_date < g.gold_signup_date
    GROUP BY g.userid
),
sales_after AS (
    SELECT g.userid, SUM(p.price) AS total_sales_after
    FROM sales s
    JOIN product p ON s.product_id = p.product_id
    JOIN goldusers_signup g ON s.userid = g.userid
    WHERE s.created_date >= g.gold_signup_date
    GROUP BY g.userid
)
SELECT a.userid,
       (total_sales_after - total_sales_before) / total_sales_before * 100 AS percentage_increase
FROM sales_before b
JOIN sales_after a ON b.userid = a.userid;


--13. Identify users who have purchased all available products.
SELECT s.userid
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.userid
HAVING COUNT(DISTINCT s.product_id) = (SELECT COUNT(product_id) FROM product);


--14.For each product, calculate the total revenue generated from users who signed up after 2016.
SELECT p.product_name, SUM(p.price) AS total_revenue
FROM sales s
JOIN users u ON s.userid = u.userid
JOIN product p ON s.product_id = p.product_id
WHERE u.signup_date > '2016-01-01'
GROUP BY p.product_name;

--15. Which users made repeat purchases of the same product, and how many times did they do so?
SELECT s.userid, p.product_name, COUNT(*) AS purchase_count
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.userid, p.product_name
HAVING COUNT(*) > 1;


--16. Find the average number of days between a user's signup and their first purchase.
WITH first_purchase AS (
    SELECT s.userid, MIN(s.created_date) AS first_purchase_date
    FROM sales s
    GROUP BY s.userid
)
SELECT u.userid, AVG(first_purchase_date - u.signup_date) AS avg_days_to_first_purchase
FROM users u
JOIN first_purchase f ON u.userid = f.userid
GROUP BY u.userid;

--17. Identify the products with sales amounts greater than the average sales amount of all products.
SELECT p.product_name
FROM product p
WHERE p.price > (
    SELECT AVG(price)
    FROM product
);

---18. Find the average sales amount for users who have made purchases of product 'p2'.
SELECT AVG(total_sales) AS avg_sales
FROM (
    SELECT s.userid, SUM(p.price) AS total_sales
    FROM sales s
    JOIN product p ON s.product_id = p.product_id
    WHERE p.product_name = 'p2'
    GROUP BY s.userid
) AS user_sales;

