DROP TRIGGER IF EXISTS insert_product;
DELIMITER $$
CREATE TRIGGER insert_product AFTER INSERT ON Products
FOR EACH ROW
BEGIN

    INSERT INTO ProductCurrencies VALUES(
    NEW.ProductID,
    NEW.ProductName,
    NEW.SupplierID,
    NEW.CategoryID,
    NEW.QuantityPerUnit,
    NEW.UnitPrice,
    NEW.UnitPrice * 0.96,
    NEW.UnitPrice * 0.84,
    NEW.UnitPrice * 140,
    NEW.UnitsInStock,
    NEW.UnitsOnOrder,
    NEW.ReorderLevel,
    NEW.Discontinued);

END $$  
DELIMITER ;

DROP TRIGGER IF EXISTS update_product;
DELIMITER $$
CREATE TRIGGER update_product AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
	IF NEW.UnitPrice <> OLD.UnitPrice THEN
		UPDATE ProductCurrencies
		SET UnitPriceUSD = NEW.UnitPrice,
        UnitPriceEUR = NEW.UnitPrice * 0.96,
		UnitPriceGBP = NEW.UnitPrice * 0.84,
		UnitPriceJPY = NEW.UnitPrice* 140
		WHERE ProductID = NEW.ProductID;
	END IF;
END $$
DELIMITER ;


