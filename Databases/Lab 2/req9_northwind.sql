DROP PROCEDURE IF EXISTS update_stock;
DELIMITER $$
CREATE PROCEDURE update_stock()
BEGIN
DECLARE vProductID INT(11);
DECLARE vQuantity SMALLINT(6);
DECLARE done INT DEFAULT 0;
DECLARE cursor_dates CURSOR FOR (SELECT ProductID, SUM(Quantity) FROM OrderDetails GROUP BY ProductID);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN cursor_dates;
bucle1:LOOP
FETCH cursor_dates INTO vProductID, vQuantity;
IF done = 1 THEN
	LEAVE bucle1;
END IF;
IF vQuantity <> (SELECT UnitsOnOrder FROM Products WHERE ProductID = vProductID) THEN
	UPDATE Products
	SET UnitsOnOrder = vQuantity
	WHERE ProductID = vProductID;
	IF (SELECT UnitsInStock FROM Products WHERE ProductID = vProductID) < vQuantity THEN
		UPDATE Products
		SET UnitsInStock = -1
		WHERE ProductID = vProductID;
	ELSE 
		UPDATE Products
		SET UnitsInStock = UnitsInStock - UnitsOnOrder
		WHERE ProductID = vProductID;
	END IF;
END IF;
END LOOP bucle1;
END $$
DELIMITER ;

# Entenem que UnitsOnOrder no s'havia restat previament de UnitsInStock.
SELECT * FROM Products;
CALL update_stock();
SELECT * FROM Products;