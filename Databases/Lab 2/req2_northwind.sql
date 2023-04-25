DROP PROCEDURE IF EXISTS check_over_dates;
DELIMITER $$
CREATE PROCEDURE check_over_dates()
BEGIN
DECLARE vOrderDate, vShippedDate, vRequiredDate datetime;
DECLARE vEmployeeID INT(11); 
DECLARE vOrderID INT(11);
DECLARE done INT DEFAULT 0;
DECLARE temp datetime;
DECLARE cursor_dates CURSOR FOR (SELECT OrderDate, ShippedDate, RequiredDate, OrderID FROM Orders WHERE OrderDate >= ShippedDate OR OrderDate >= RequiredDate OR ShippedDate > RequiredDate);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN cursor_dates;
bucle1:LOOP
FETCH cursor_dates INTO vOrderDate, vShippedDate, vRequiredDate, vOrderID;
IF done = 1 THEN
	LEAVE bucle1;
END IF;
IF vShippedDate > vRequiredDate THEN
	SET temp = vRequiredDate;
	SET vRequiredDate = vShippedDate;
	SET vShippedDate = temp;
END IF;
IF vOrderDate > vRequiredDate THEN
	SET temp = vRequiredDate;
	SET vRequiredDate = vOrderDate;
	SET vOrderDate = temp;
END IF;
IF vOrderDate > vShippedDate THEN
	SET temp = vShippedDate;
	SET vShippedDate = vOrderDate;
	SET vOrderDate = temp;
END IF;
UPDATE Orders 
SET OrderDate = vOrderDate, RequiredDate = vRequiredDate, ShippedDate = vShippedDate
WHERE OrderID = vOrderID;
END LOOP bucle1;
END $$
DELIMITER ;

CALL check_over_dates();
SELECT * FROM OrdersLog;
#Extra
SELECT * FROM Orders GROUP BY EmployeeID HAVING COUNT(OrderID) = (SELECT COUNT(OrderID) FROM Orders GROUP BY EmployeeID ORDER BY COUNT(OrderID) ASC LIMIT 1);
	