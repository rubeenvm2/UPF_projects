DROP VIEW IF EXISTS supplier_biggest_diff_prov_products;
CREATE VIEW supplier_biggest_diff_prov_products AS
	SELECT CompanyName AS Supplier, count(ProductID) AS Count_products FROM Suppliers AS s
	JOIN Products AS p
	ON s.SupplierID = p.SupplierID
	GROUP BY s.SupplierID
	ORDER BY Count_products DESC LIMIT 1;
SELECT * FROM supplier_biggest_diff_prov_products;

DROP VIEW IF EXISTS five_employees_highest_num_orders;
CREATE VIEW five_employees_highest_num_orders AS
	SELECT e.EmployeeID, FirstName, LastName, count(OrderID) AS Count_Orders
	FROM Employees AS e
	JOIN Orders AS o
	ON e.EmployeeID = o.EmployeeID
	GROUP BY e.EmployeeID
	ORDER BY Count_Orders DESC LIMIT 5;
SELECT * FROM five_employees_highest_num_orders;

DROP VIEW IF EXISTS products_supplier_grandma_kellys_homestead;
CREATE VIEW products_supplier_grandma_kellys_homestead AS 
	SELECT * 
	FROM Products
	WHERE SupplierID IN (SELECT SupplierID FROM Suppliers WHERE CompanyName LIKE "Grandma Kelly's Homestead");
SELECT * FROM products_supplier_grandma_kellys_homestead;

DROP VIEW IF EXISTS num_diff_serv_products_for_orders;
CREATE VIEW num_diff_serv_products_for_orders AS 
	SELECT count(ProductID) AS Different_served_products, FirstName, LastName
	FROM OrderDetails AS od
	JOIN Orders AS o
	ON od.OrderID = o.OrderID
	JOIN Employees AS e
	ON e.EmployeeID = o.EmployeeID
	GROUP BY od.OrderID 
	ORDER BY Different_served_products DESC;
SELECT * FROM num_diff_serv_products_for_orders;

DROP VIEW IF EXISTS info_product_sold;
CREATE VIEW info_product_sold AS 
	SELECT ProductName, SUM(Quantity), AVG(od.UnitPrice - od.UnitPrice * Discount) AS Average_unit_price
	FROM Products AS p
	JOIN OrderDetails AS od
	ON p.ProductID = od.ProductID
	GROUP BY p.ProductID
	ORDER BY Average_unit_price DESC;
SELECT * FROM info_product_sold;

DROP VIEW IF EXISTS ordered_and_shipped_in_1997_by_german_customers;
CREATE VIEW ordered_and_shipped_in_1997_by_german_customers AS 
	SELECT *
	FROM Orders
	WHERE OrderID IN (SELECT OrderID FROM Orders AS o
		JOIN Shippers AS s
		ON o.ShipperID = s.ShipperID
		JOIN Customers AS c
		ON o.CustomerID = c.CustomerID
		WHERE (OrderDate LIKE  "1997%" AND ShippedDate LIKE "1997%" AND c.Country LIKE "Germany"))
	ORDER BY OrderDate ASC;
SELECT * FROM ordered_and_shipped_in_1997_by_german_customers;

DROP VIEW IF EXISTS orders_with_products_of_Beverages_category;
CREATE VIEW orders_with_products_of_Beverages_category AS 
	SELECT DISTINCT o.OrderID, OrderDate 
	FROM Orders AS o
	JOIN OrderDetails AS od
	ON o.OrderID = od.OrderID
	JOIN Products AS p
	ON od.ProductID = p.ProductID
	JOIN Categories AS c
	ON p.CategoryID = c.CategoryID
	WHERE CategoryName LIKE "Beverages"
	ORDER BY OrderDate DESC;
SELECT * FROM orders_with_products_of_Beverages_category;

DROP VIEW IF EXISTS orderID_10255_and_total_cost;
CREATE VIEW orderID_10255_and_total_cost AS 
	SELECT o.*, SUM((UnitPrice - UnitPrice * Discount) * Quantity) AS Total_price
	FROM Orders AS o, OrderDetails AS od
    WHERE o.OrderID = od.OrderID
    AND o.OrderID = 10255;
SELECT * FROM orderID_10255_and_total_cost;

DROP VIEW IF EXISTS info_orders_cont_products_from_Japanese_suppliers;
CREATE VIEW info_orders_cont_products_from_Japanese_suppliers AS 
	SELECT *
	FROM Orders
	WHERE OrderID IN (SELECT OrderID
					FROM OrderDetails AS od
					JOIN Products AS p
					ON od.ProductID = p.ProductID
					JOIN Suppliers AS s
					ON s.SupplierID = p.SupplierID
					WHERE Country LIKE 'Japan')
	ORDER BY CustomerID, OrderDate ASC;
SELECT * FROM info_orders_cont_products_from_Japanese_suppliers;

DROP VIEW IF EXISTS cheapest_and_expensive_product;
CREATE VIEW cheapest_and_expensive_product AS 
	SELECT ProductName, UnitPrice
	FROM Products
	WHERE UnitPrice IN (SELECT MIN(UnitPrice) FROM Products)
	OR UnitPrice IN (SELECT MAX(UnitPrice) FROM Products);
SELECT * FROM cheapest_and_expensive_product;

DROP VIEW IF EXISTS full_address_customers;
CREATE VIEW full_address_customers AS 
	SELECT CONCAT(Address, " ", City, " ", PostalCode, " ", Country) AS Full_address_information, CustomerID, ContactName
	FROM Customers;
SELECT * FROM full_address_customers;

DROP VIEW IF EXISTS more_proc_orders_than_employee_8;
CREATE VIEW more_proc_orders_than_employee_8 AS 
	SELECT *
	FROM Employees
	WHERE EmployeeID IN (SELECT EmployeeID
						FROM Orders
						GROUP BY EmployeeID
						HAVING COUNT(OrderID) > (SELECT COUNT(OrderID)
												FROM Orders
												WHERE EmployeeID = 8
												GROUP BY EmployeeID));
SELECT * FROM more_proc_orders_than_employee_8;

DROP VIEW IF EXISTS orders_more_three_dif_products;
CREATE VIEW orders_more_three_dif_products AS 
	SELECT OrderID
	FROM OrderDetails 
	GROUP BY OrderID
	HAVING COUNT(ProductID) > 3;
SELECT * FROM orders_more_three_dif_products;

DROP VIEW IF EXISTS orders_of_customers_in_London_and_suppliers_New_Orleans;
CREATE VIEW orders_of_customers_in_London_and_suppliers_New_Orleans AS 
	SELECT DISTINCT o.OrderID
	FROM Orders AS o
	JOIN Customers AS c
	ON o.CustomerID = c.CustomerID
	JOIN OrderDetails AS od
	ON o.OrderID = od.OrderID
	JOIN Products AS p
	ON p.ProductID = od.ProductID
	JOIN Suppliers AS s
	ON s.SupplierID = p.SupplierID
	WHERE c.City LIKE 'London' 
	AND s.City LIKE 'New Orleans';
SELECT * FROM orders_of_customers_in_London_and_suppliers_New_Orleans;

DROP VIEW IF EXISTS info_prod_price_above_20_and_linked_min_category;
CREATE VIEW info_prod_price_above_20_and_linked_min_category AS 
	SELECT ProductName, CategoryName, UnitPrice
	FROM Products AS p
	JOIN Categories AS c
	ON c.CategoryID = p.CategoryID
	WHERE UnitPrice > 20 
	AND c.CategoryID = (SELECT CategoryID
						FROM Products
						GROUP BY CategoryID
						ORDER BY COUNT(ProductID) ASC LIMIT 1);
SELECT * FROM info_prod_price_above_20_and_linked_min_category;

DROP VIEW IF EXISTS name_employees_proc_max_num_orders;
CREATE VIEW name_employees_proc_max_num_orders AS 
	SELECT FirstName, LastName
	FROM Employees AS e
	JOIN Orders AS o
	ON e.EmployeeID = o.EmployeeID
	GROUP BY e.EmployeeID
	HAVING COUNT(o.OrderID) = (SELECT COUNT(OrderID)
						FROM Orders
						GROUP BY EmployeeID
						ORDER BY COUNT(OrderID) DESC LIMIT 1);
SELECT * FROM name_employees_proc_max_num_orders;

DROP VIEW IF EXISTS VIP_customers;
CREATE VIEW VIP_customers AS 
	SELECT c.CustomerID
	FROM Customers AS c
	JOIN Orders AS o
	ON c.CustomerID = o.CustomerID
	GROUP BY c.CustomerID
	HAVING COUNT(o.OrderID) > 25
	AND COUNT(ShipperID) > 2
	AND COUNT(EmployeeID) >= 4;
SELECT * FROM VIP_customers;

DROP VIEW IF EXISTS name_employees_work_with_all_shipping_companies;
CREATE VIEW name_employees_work_with_all_shipping_companies AS 
	SELECT FirstName
	FROM Employees AS e
	JOIN Orders AS o
	ON e.EmployeeID = o.EmployeeID
	JOIN Shippers AS s
	ON o.ShipperID = s.ShipperID
	GROUP BY o.EmployeeID
	HAVING COUNT(DISTINCT(s.ShipperID)) = (SELECT COUNT(ShipperID) FROM Shippers);
SELECT * FROM name_employees_work_with_all_shipping_companies;

DROP VIEW IF EXISTS order_ID_required_more_7_days;
CREATE VIEW order_ID_required_more_7_days AS 
	SELECT OrderID
	FROM Orders
	WHERE DATEDIFF(RequiredDate, OrderDate) > 7;
SELECT * FROM order_ID_required_more_7_days;

DROP VIEW IF EXISTS info_order_detail;
CREATE VIEW info_order_detail AS 
	SELECT ProductName, su.CompanyName AS SupplierName, CategoryName, FirstName, LastName, s.CompanyName AS ShipperCompanyName, c.CompanyName AS CostumerCompanyName
	FROM OrderDetails AS od
	LEFT JOIN Products AS p
	ON od.ProductID = p.ProductID
	LEFT JOIN Categories AS cat
	ON cat.CategoryID = p.CategoryID
	LEFT JOIN Suppliers AS su
	ON su.SupplierID = p.SupplierID
	LEFT JOIN Orders AS o
	ON o.OrderID = od.OrderID
	LEFT JOIN Employees AS e
	ON e.EmployeeID = o.EmployeeID
	LEFT JOIN Customers AS c
	ON c.CustomerID = o. CustomerID
	LEFT JOIN Shippers AS s
	ON s.ShipperID = o.ShipperID
	ORDER BY o.OrderID, ProductName ASC;
SELECT * FROM info_order_detail;