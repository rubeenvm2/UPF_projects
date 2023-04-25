DROP TABLE IF EXISTS OrdersLog;
CREATE TABLE IF NOT EXISTS OrdersLog LIKE Orders;
ALTER TABLE OrdersLog
ADD COLUMN LogID INT(3) AUTO_INCREMENT FIRST,
MODIFY COLUMN OrderID INT(11),
ADD COLUMN DMLAction VARCHAR(10) AFTER ShipCountry,
ADD COLUMN LogTime DATE AFTER DMLAction,
ADD COLUMN DataVersion INT(3),
ADD COLUMN UserModyfing VARCHAR(64) AFTER DataVersion,
AUTO_INCREMENT = 1,
DROP PRIMARY KEY,
ADD CONSTRAINT PK_OrdersLog PRIMARY KEY(LogID);


DROP TRIGGER IF EXISTS insert_trigger;
DELIMITER $$
CREATE TRIGGER insert_trigger 
AFTER INSERT ON Orders
FOR EACH ROW
INSERT INTO OrdersLog (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipperID, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry, DMLAction, LogTime, DataVersion, UserModyfing) VALUES (NEW.OrderID, NEW.CustomerID, NEW.EmployeeID, NEW.OrderDate, NEW.RequiredDate, NEW.ShippedDate, NEW.ShipperID, NEW.Freight, NEW.ShipName, NEW.ShipAddress, NEW.ShipCity, NEW.ShipRegion, NEW.ShipPostalCode, NEW.ShipCountry, 'INSERT', NOW(), 1, USER());
$$
DELIMITER ;

DROP TRIGGER IF EXISTS update_trigger;
DELIMITER $$
CREATE TRIGGER update_trigger 
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
DECLARE DataVersion_ INT(3);
SET DataVersion_ = (SELECT DataVersion FROM OrdersLog WHERE OrderID = NEW.OrderID ORDER BY LogTime DESC LIMIT 1);
INSERT INTO OrdersLog (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipperID, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry, DMLAction, LogTime, DataVersion, UserModyfing) VALUES (NEW.OrderID, NEW.CustomerID, NEW.EmployeeID, NEW.OrderDate, NEW.RequiredDate, NEW.ShippedDate, NEW.ShipperID, NEW.Freight, NEW.ShipName, NEW.ShipAddress, NEW.ShipCity, NEW.ShipRegion, NEW.ShipPostalCode, NEW.ShipCountry, 'UPDATE', NOW(), DataVersion_+1, USER());
END
$$
DELIMITER ;

DROP TRIGGER IF EXISTS delete_trigger;
DELIMITER $$
CREATE TRIGGER delete_trigger
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
DECLARE DataVersion_ INT(3);
SET DataVersion_ = (SELECT DataVersion FROM OrdersLog WHERE OrderID = OLD.OrderID ORDER BY DataVersion DESC LIMIT 1);
INSERT INTO OrdersLog (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipperID, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry, DMLAction, LogTime, DataVersion, UserModyfing) VALUES (OLD.OrderID, OLD.CustomerID, OLD.EmployeeID, OLD.OrderDate, OLD.RequiredDate, OLD.ShippedDate, OLD.ShipperID, OLD.Freight, OLD.ShipName, OLD.ShipAddress, OLD.ShipCity, OLD.ShipRegion, OLD.ShipPostalCode, OLD.ShipCountry, 'DELETE', NOW(), DataVersion_, USER());
END
$$
DELIMITER ;

INSERT INTO Orders VALUES(51032, 'VINET', 5, '1996-07-04 00:00:00', '1996-07-16 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'VINS', 'Roc boronat', 'Reims', NULL, 51100, 'FRANCE');
UPDATE Orders SET ShipCountry = 'SPAIN' WHERE OrderID = 51032;
DELETE FROM Orders WHERE OrderID = 51032;
INSERT INTO Orders VALUES(12341, 'VINET', 5, '1996-07-04 00:00:00', '1996-07-16 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'VINS', 'Roc boronat', 'Reims', NULL, 51100, 'FRANCE');
DELETE FROM Orders WHERE OrderID = 12341;
SELECT * FROM OrdersLog;