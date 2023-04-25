# Rubén Vera - 241456
# Sara Soriano - 240007

# DELIVERABLES
# EXERCISE 13
SELECT s.store_name, COUNT(o.order_id) AS n_orders, SUM(p.list_price) AS total_price, AVG(oi.list_price) AS avg_price
FROM sales.stores AS s
JOIN sales.orders AS o
ON s.store_id = o.store_id
JOIN sales.order_items AS oi
ON o.order_id = oi.order_id
JOIN production.products AS p
ON oi.product_id = p.product_id
GROUP BY o.store_id;


# EXERCISE 14
USE sales; DROP VIEW IF EXISTS ex14;
CREATE VIEW ex14 AS
	SELECT o.customer_id, c.first_name, c.last_name, o.order_id, p.product_name, b.brand_id
	FROM sales.customers AS c
	JOIN sales.orders AS o
	ON o.customer_id = c.customer_id
	JOIN sales.order_items AS oi
	ON o.order_id = oi.order_id
	JOIN production.products AS p
	ON oi.product_id = p.product_id
	JOIN production.brands AS b
	ON p.brand_id = b.brand_id;
# 14.A
SELECT customer_id, first_name, last_name, COUNT(DISTINCT(order_id)) AS n_orders
FROM ex14
GROUP BY customer_id ORDER BY n_orders DESC LIMIT 10; 
# 14.B
SELECT * 
FROM ex14
WHERE brand_id IN 
(SELECT brand_id FROM production.brands AS b WHERE b.brand_name = "Electra");


# EXERCISE 15
# CONTAINING THE WORK 'Bikes'
SELECT *
FROM production.products AS p
WHERE category_id IN 
(SELECT category_id FROM production.categories AS c WHERE c.category_name LIKE "%Bikes%");
# THE OPPOSITE
SELECT *
FROM production.products AS p
WHERE category_id NOT IN 
(SELECT category_id FROM production.categories AS c WHERE c.category_name LIKE "%Bikes%");


# EXERCISE 16
# 16.A
SET SQL_SAFE_UPDATES = 0;
UPDATE sales.orders
SET order_status = 4
WHERE required_date < NOW();
SET SQL_SAFE_UPDATES = 1;

# 16.B
SET SQL_SAFE_UPDATES = 0;
UPDATE sales.orders
SET order_status = 2
WHERE (required_date > NOW() AND order_date < NOW());
SET SQL_SAFE_UPDATES = 1;

# 16.C
SELECT * 
FROM sales.orders
WHERE order_status = 2;