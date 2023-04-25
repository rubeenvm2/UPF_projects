SELECT first_name, last_name, store_name
FROM sales.staffs AS staffs
JOIN sales.stores AS stores
ON staffs.store_id = stores.store_id
WHERE staffs.active = 1;


SELECT order_id
FROM sales.orders AS o
WHERE o.staff_id = ANY(SELECT manager_id FROM sales.staffs);


SELECT store_name, COUNT(store_name)
FROM sales.staffs AS staff
JOIN sales.stores AS stores
ON stores.store_id = staff.store_id WHERE active = 1
GROUP BY staff.store_id;


SELECT product_name, SUM(sales.order_items.quantity) AS n_sales
FROM sales.order_items AS order_items
JOIN production.products AS products
ON products.product_id = order_items.product_id
GROUP BY products.product_id
ORDER BY n_sales DESC LIMIT 10;


SELECT brand_name, SUM(list_price)
FROM production.products AS products
JOIN production.brands AS brands
ON products.brand_id = brands.brand_id
GROUP BY products.brand_id;

DROP VIEW IF EXISTS brand_price_view;
CREATE VIEW brand_price_view AS 
	SELECT brand_name, SUM(list_price) AS price, SUM(quantity) AS quantity
	FROM production.products AS products
	JOIN production.brands AS brands
	ON products.brand_id = brands.brand_id
	JOIN production.stocks AS stocks
	ON products.product_id = stocks.product_id
	GROUP BY products.brand_id ORDER BY SUM(quantity) DESC;

SELECT brand_name
FROM brand_price_view AS b
WHERE quantity > 100 AND quantity < 300; 

SELECT brand_name, quantity, price
FROM brand_price_view AS b
WHERE brand_name LIKE "S%";

SELECT brand_name
FROM brand_price_view AS b
WHERE price > 500000 OR quantity < 250; 

#DELIVERIES
# 13
SELECT s.store_name, COUNT(o.order_id) AS n_orders, SUM(p.list_price) AS total_price, AVG(oi.list_price) AS avg_price
FROM sales.stores AS s
JOIN sales.orders AS o
ON s.store_id = o.store_id
JOIN sales.order_items AS oi
ON o.order_id = oi.order_id
JOIN production.products AS p
ON oi.product_id = p.product_id
GROUP BY o.store_id;

# 14
USE sales; DROP VIEW IF EXISTS ex14;
CREATE VIEW ex14 AS
	SELECT o.customer_id, s.first_name, s.last_name, o.order_id, p.product_name, b.brand_id
	FROM sales.staffs AS s
	JOIN sales.orders AS o
	ON s.staff_id = o.staff_id
	JOIN sales.order_items AS oi
	ON o.order_id = oi.order_id
	JOIN production.products AS p
	ON oi.product_id = p.product_id
	JOIN production.brands AS b
	ON p.brand_id = b.brand_id;

# 14.A
SELECT customer_id, first_name, last_name, COUNT(order_id) AS n_orders
FROM ex14
GROUP BY customer_id ORDER BY n_orders DESC LIMIT 10;

# 14.B
SELECT * 
FROM ex14
WHERE brand_id IN (SELECT brand_id FROM production.brands AS b WHERE b.brand_name = "Electra");

# 15
SELECT *
FROM production.products AS p
WHERE category_id IN (SELECT category_id FROM production.categories AS c WHERE c.category_name LIKE "%Bikes%");
# 15.2
SELECT *
FROM production.products AS p
WHERE category_id NOT IN (SELECT category_id FROM production.categories AS c WHERE c.category_name LIKE "%Bikes%");