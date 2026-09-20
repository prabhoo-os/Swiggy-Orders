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
 
-- Import the CSV as table `swiggy_orders` using
-- MySQL Workbench > Table Data Import Wizard, then verify:

Create database swiggy_db;

use	swiggy_db;

describe swiggy_orders;

SELECT * FROM swiggy_orders;

  #--PART A - FILTERING
  
  -- Q1. All orders from Hyderabad
  
select order_id, order_code, customer_name, cuisine, item, Amount
from swiggy_orders
where city= 'Hyderabad';

-- Q2. All orders paid with Wallet

select order_id, order_code, customer_name, cuisine, item, Amount
from swiggy_orders
where Payment_method = 'Wallet';

-- Q3. Big-ticket orders: amount greater than 1200

select order_id, order_code, customer_name, cuisine, item, Amount
from swiggy_orders
where Amount > 1200
ORDER BY amount DESC;

-- Q4. Unhappy customers: rating of 3 or lower

select order_id, order_code, customer_name, cuisine, item, rating, Amount
from swiggy_orders
where rating  <= 3
ORDER BY rating  ASC;

-- Q5. Exclude exactly-30-minute deliveries

select order_id, order_code, customer_name, cuisine, item, delivery_time, Amount
from swiggy_orders
where delivery_time <> 30
ORDER BY delivery_time;

-- Q6. Mid-value orders: amount between 300 and 700 (both ends included)

	select order_id, order_code, customer_name, cuisine, item, Amount
	from swiggy_orders
	where Amount BETWEEN 300 AND 700
	ORDER BY amount;

-- Q7. Mid-priced items: price between 200 and 300

select order_id, order_code, customer_name, cuisine, item, price, Amount
from swiggy_orders
where price BETWEEN 200 AND 300
ORDER BY price;

-- Q8. Orders from Pune, Chennai and Kolkata (IN)

select order_id, order_code, customer_name, cuisine, item, city, Amount
from swiggy_orders
where city in ( 'pune', 'Chennai', 'Kolkata')
ORDER BY City;

-- Q9. Orders paid by UPI or Cash (IN)

select order_id, order_code, customer_name, cuisine, item, payment_method, Amount
from swiggy_orders
where payment_method in ( 'UPI', 'Cash');

-- Q10. High-value card orders: Credit Card AND amount over 900

select order_id, order_code, customer_name, cuisine, item, payment_method, Amount
from swiggy_orders
where payment_method = 'Credit Card' and amount > 900 
ORDER BY amount DESC;

-- Q11. Broad loyalty list: members OR 5-star ratings

select order_id, order_code, customer_name, cuisine, item, rating, Amount
from swiggy_orders
where rating  = 5
ORDER BY customer_name, rating DESC;

-- Q12. Best Delhi UPI orders: Delhi AND UPI AND rating 4 or higher

select order_id, order_code, customer_name, cuisine, item, payment_method, rating, Amount
from swiggy_orders
WHERE city = 'Delhi' and payment_method = 'UPI' AND rating >= 4
order by payment_method DESC, rating desc;

#--PART B - STRING FUNCTIONS

-- Q13. Length of each customer name (LENGTH - spaces count too)

SELECT customer_name,
       LENGTH(customer_name) AS name_length
FROM swiggy_orders;

-- Q14. City in UPPERCASE, cuisine in lowercase (UPPER, LOWER)

Select upper(city) as city_upper,
Lower(cuisine) as cuisine_lower
FROM swiggy_orders; 

-- Q15. Friendly label, e.g. "Nikhil Nair from Bengaluru" (CONCAT)

SELECT CONCAT(customer_name, ' from ', city) AS friendly_label
FROM swiggy_orders;

-- Q16. Split order_code: first 3 and last 4 characters (LEFT, RIGHT)

SELECT LEFT(order_code, 3) AS prefix,
       RIGHT(order_code, 4) AS suffix
FROM swiggy_orders;

-- Q17. Extract city code from the middle of order_code (SUBSTRING)

SELECT SUBSTRING(order_code, 5, 3) AS city_code
FROM swiggy_orders;

-- Q18. Split email into username and domain (SUBSTRING_INDEX)

SELECT 
    SUBSTRING_INDEX(email, '@', 1) AS username,
    SUBSTRING_INDEX(email, '@', -1) AS domain
FROM swiggy_orders;

-- Q19. Split customer_name into first and last name (SUBSTRING_INDEX)

SELECT 
    SUBSTRING_INDEX(customer_name, ' ', 1) AS first_name,
    SUBSTRING_INDEX(customer_name, ' ', -1) AS last_name
FROM swiggy_orders;

-- Q20. Position of '@' in each email (INSTR)

SELECT email,
       INSTR(email, '@') AS at_position
FROM swiggy_orders;










