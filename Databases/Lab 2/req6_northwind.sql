DROP TRIGGER IF EXISTS discontinued_product;
DELIMITER $$
CREATE TRIGGER discontinued_product AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
	IF NEW.Discontinued = 1 THEN
		DELETE FROM OrderDetails
		WHERE ProductID = NEW.ProductID;
	END IF;
END $$
DELIMITER ;