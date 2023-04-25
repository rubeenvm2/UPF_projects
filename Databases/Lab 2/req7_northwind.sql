ALTER TABLE Customers
ADD COLUMN DefEmployee INT(11);

DROP PROCEDURE IF EXISTS set_default_employees;
DELIMITER $$
CREATE PROCEDURE set_default_employees()
BEGIN
DECLARE vCustomerID CHAR(5);
DECLARE done INT DEFAULT 0;
DECLARE cursor_dates CURSOR FOR (SELECT CustomerID FROM Customers);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN cursor_dates;
bucle1:LOOP
FETCH cursor_dates INTO vCustomerID;
IF done = 1 THEN
	LEAVE bucle1;
END IF;
SET SQL_SAFE_UPDATES = 0;
UPDATE Customers SET DefEmployee = 
(SELECT EmployeeID FROM Orders WHERE CustomerID = vCustomerID GROUP BY EmployeeID ORDER BY COUNT(OrderID) DESC LIMIT 1 )
WHERE CustomerID = vCustomerID;
SET SQL_SAFE_UPDATES = 1;

END LOOP bucle1;

SELECT *
INTO OUTFILE 'Customers_New.csv'
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM Customers;
END $$
DELIMITER ;
SELECT * FROM Customers;
CALL set_default_employees();
SELECT * FROM Customers;

