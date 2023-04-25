DROP PROCEDURE IF EXISTS employees_info;
DELIMITER $$
CREATE PROCEDURE employees_info()
BEGIN
DECLARE vEmployeeID INT(11);
DECLARE done INT DEFAULT 0;
DECLARE cursor_dates CURSOR FOR (SELECT EmployeeID FROM Employees);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN cursor_dates;
bucle1:LOOP
FETCH cursor_dates INTO vEmployeeID;
IF done = 1 THEN
	LEAVE bucle1;
END IF;
SELECT e.EmployeeID, LastName, FirstName, BirthDate, HireDate, PostalCode, ReportsTo, YEAR(OrderDate) AS Year_OrderDate,
	Month(OrderDate) AS Month_OrderDate, COUNT(DISTINCT(o.OrderID)) AS Prepared_Orders, SUM(UnitPrice*Quantity*(1-Discount)) AS Price_prepared_orders
    FROM Employees AS e
    JOIN Orders AS o
    ON e.EmployeeID = o.EmployeeID
    JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
    WHERE e.EmployeeID = vEmployeeID
    GROUP BY Year_OrderDate, Month_OrderDate
    ORDER BY Year_OrderDate, Month_OrderDate ASC;
END LOOP bucle1;
END $$
DELIMITER ;

CALL employees_info();
