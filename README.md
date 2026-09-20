# Swiggy-Orders
SQL practice on a 200-row Swiggy food-delivery orders dataset in MySQL. Covers filtering (WHERE, BETWEEN, IN, AND/OR) and string functions (LENGTH, CONCAT, SUBSTRING, SUBSTRING_INDEX, INSTR, etc.) through 20 business-style questions, such as city audits, payment analysis and email/name parsing.

/* ============================================================
   SWIGGY ORDERS - SQL PRACTICE (MySQL)
   Topics : Filtering (WHERE, comparison, AND/OR, BETWEEN, IN)
            String functions (LENGTH, UPPER, LOWER, CONCAT,
            LEFT, RIGHT, SUBSTRING, SUBSTRING_INDEX, INSTR)
   Table  : swiggy_orders (200 rows, 1 row = 1 food-delivery order)

   Columns:
     order_id, order_code (e.g. SWG-BLR-0001), customer_name,
     email, city, restaurant, cuisine, item, quantity, price,
     amount, payment_method, order_status, rating,
     delivery_time (minutes), is_member (1/0), discount
   ============================================================ */


/* ------------------------------------------------------------
   SETUP
   ------------------------------------------------------------ */
CREATE DATABASE IF NOT EXISTS swiggy_db;
USE swiggy_db;

-- Import the CSV as table `swiggy_orders` using
-- MySQL Workbench > Table Data Import Wizard, then verify:
DESCRIBE swiggy_orders;
SELECT * FROM swiggy_orders;   -- expect 200 rows


/* ============================================================
   PART A - FILTERING
   ============================================================ */

-- Q1. All orders from Hyderabad
SELECT order_id, order_code, customer_name, cuisine, item, amount
FROM swiggy_orders
WHERE city = 'Hyderabad';


-- Q2. All orders paid with Wallet
SELECT order_id, order_code, customer_name, cuisine, item, amount
FROM swiggy_orders
WHERE payment_method = 'Wallet';


-- Q3. Big-ticket orders: amount greater than 1200
SELECT order_id, order_code, customer_name, cuisine, item, amount
FROM swiggy_orders
WHERE amount > 1200
ORDER BY amount DESC;


-- Q4. Unhappy customers: rating of 3 or lower
SELECT order_id, order_code, customer_name, cuisine, item, rating, amount
FROM swiggy_orders
WHERE rating <= 3
ORDER BY rating ASC;


-- Q5. Exclude exactly-30-minute deliveries
SELECT order_id, order_code, customer_name, cuisine, item, delivery_time, amount
FROM swiggy_orders
WHERE delivery_time <> 30
ORDER BY delivery_time;


-- Q6. Mid-value orders: amount between 300 and 700 (both ends included)
SELECT order_id, order_code, customer_name, cuisine, item, amount
FROM swiggy_orders
WHERE amount BETWEEN 300 AND 700
ORDER BY amount;


-- Q7. Mid-priced items: price between 200 and 300
SELECT order_id, order_code, customer_name, cuisine, item, price, amount
FROM swiggy_orders
WHERE price BETWEEN 200 AND 300
ORDER BY price;


-- Q8. Orders from Pune, Chennai and Kolkata (IN)
SELECT order_id, order_code, customer_name, cuisine, item, city, amount
FROM swiggy_orders
WHERE city IN ('Pune', 'Chennai', 'Kolkata')
ORDER BY city;


-- Q9. Orders paid by UPI or Cash (IN)
SELECT order_id, order_code, customer_name, cuisine, item, payment_method, amount
FROM swiggy_orders
WHERE payment_method IN ('UPI', 'Cash');


-- Q10. High-value card orders: Credit Card AND amount over 900
SELECT order_id, order_code, customer_name, cuisine, item, payment_method, amount
FROM swiggy_orders
WHERE payment_method = 'Credit Card'
  AND amount > 900
ORDER BY amount DESC;


-- Q11. Broad loyalty list: members OR 5-star ratings
SELECT order_id, order_code, customer_name, cuisine, item, is_member, rating, amount
FROM swiggy_orders
WHERE is_member = 1
   OR rating = 5
ORDER BY customer_name, rating DESC;


-- Q12. Best Delhi UPI orders: Delhi AND UPI AND rating 4 or higher
SELECT order_id, order_code, customer_name, cuisine, item, payment_method, rating, amount
FROM swiggy_orders
WHERE city = 'Delhi'
  AND payment_method = 'UPI'
  AND rating >= 4
ORDER BY rating DESC;


/* ============================================================
   PART B - STRING FUNCTIONS
   ============================================================ */

-- Q13. Length of each customer name (LENGTH - spaces count too)
SELECT customer_name,
       LENGTH(customer_name) AS name_length
FROM swiggy_orders;


-- Q14. City in UPPERCASE, cuisine in lowercase (UPPER, LOWER)
SELECT UPPER(city)   AS city_upper,
       LOWER(cuisine) AS cuisine_lower
FROM swiggy_orders;


-- Q15. Friendly label, e.g. "Nikhil Nair from Bengaluru" (CONCAT)
SELECT CONCAT(customer_name, ' from ', city) AS friendly_label
FROM swiggy_orders;


-- Q16. Split order_code: first 3 and last 4 characters (LEFT, RIGHT)
SELECT LEFT(order_code, 3)  AS prefix,
       RIGHT(order_code, 4) AS suffix
FROM swiggy_orders;


-- Q17. Extract city code from the middle of order_code (SUBSTRING)
--      'SWG-BLR-0001' -> 'BLR'  (start at position 5, take 3 characters)
SELECT SUBSTRING(order_code, 5, 3) AS city_code
FROM swiggy_orders;


-- Q18. Split email into username and domain (SUBSTRING_INDEX)
SELECT SUBSTRING_INDEX(email, '@', 1)  AS username,
       SUBSTRING_INDEX(email, '@', -1) AS domain
FROM swiggy_orders;


-- Q19. Split customer_name into first and last name (SUBSTRING_INDEX)
SELECT SUBSTRING_INDEX(customer_name, ' ', 1)  AS first_name,
       SUBSTRING_INDEX(customer_name, ' ', -1) AS last_name
FROM swiggy_orders;


-- Q20. Position of '@' in each email (INSTR)
SELECT email,
       INSTR(email, '@') AS at_position
FROM swiggy_orders;
