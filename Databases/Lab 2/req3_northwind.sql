DROP TABLE IF EXISTS ProductCurrencies;
CREATE TABLE IF NOT EXISTS ProductCurrencies SELECT * FROM Products;
ALTER TABLE ProductCurrencies
RENAME COLUMN UnitPrice TO UnitPriceUSD;
ALTER TABLE ProductCurrencies
MODIFY COLUMN UnitPriceUSD DOUBLE DEFAULT '0',
ADD COLUMN UnitPriceEUR DOUBLE AFTER UnitPriceUSD,
ADD COLUMN UnitPriceGBP DOUBLE AFTER UnitPriceEUR,
ADD COLUMN UnitPriceJPY DOUBLE AFTER UnitPriceGBP;

DROP PROCEDURE IF EXISTS insert_currencies;
DELIMITER $$
CREATE PROCEDURE insert_currencies(IN vProductID INT)
BEGIN
SET SQL_SAFE_UPDATES = 0;
IF vProductID = 0 THEN
	UPDATE ProductCurrencies SET UnitPriceEUR = UnitPriceUSD*0.96, UnitPriceGBP = UnitPriceUSD*0.84, UnitPriceJPY = UnitPriceUSD*140;
ELSEIF vProductID IN (SELECT ProductID FROM ProductCurrencies) THEN
	UPDATE ProductCurrencies SET UnitPriceEUR = UnitPriceUSD*0.96, UnitPriceGBP = UnitPriceUSD*0.84, UnitPriceJPY = UnitPriceUSD*140
    WHERE ProductID = vProductID;
ELSE 
	SELECT 'Warning Message: There is no product with this identifier.' AS '';
END IF;
SET SQL_SAFE_UPDATES = 1;

END $$
DELIMITER ;


SET @p_id = 7;
CALL insert_currencies(@p_id);
SELECT * FROM ProductCurrencies;
SET @p_id = 0;
CALL insert_currencies(@p_id);
SELECT * FROM ProductCurrencies;
SET @p_id = 86;
CALL insert_currencies(@p_id);

#EXTRA
DROP TABLE IF EXISTS CurrencyExchanges;
CREATE TABLE IF NOT EXISTS CurrencyExchanges(
	CurrencyName VARCHAR(64)  PRIMARY KEY,
	ExchangeFromUSD DOUBLE);
    
DROP TABLE IF EXISTS ProductCurrencies;
CREATE TABLE IF NOT EXISTS ProductCurrencies SELECT * FROM Products;
ALTER TABLE ProductCurrencies
RENAME COLUMN UnitPrice TO UnitPriceUSD;
ALTER TABLE ProductCurrencies
MODIFY COLUMN UnitPriceUSD DOUBLE DEFAULT '0',
ADD COLUMN UnitPriceEUR DOUBLE AFTER UnitPriceUSD,
ADD COLUMN UnitPriceGBP DOUBLE AFTER UnitPriceEUR,
ADD COLUMN UnitPriceJPY DOUBLE AFTER UnitPriceGBP;    

INSERT INTO CurrencyExchanges VALUES('EUR', 0.96),('GBP', 0.84),('JPY', 140);

DROP PROCEDURE IF EXISTS insert_currencies;
DELIMITER $$
CREATE PROCEDURE insert_currencies(IN vProductID INT)
BEGIN
SET SQL_SAFE_UPDATES = 0;
IF vProductID = 0 THEN
	UPDATE ProductCurrencies SET UnitPriceEUR = UnitPriceUSD*(SELECT ExchangeFromUSD FROM CurrencyExchanges WHERE CurrencyName LIKE 'EUR'), UnitPriceGBP = UnitPriceUSD*(SELECT ExchangeFromUSD FROM CurrencyExchanges WHERE CurrencyName LIKE 'GBP'), UnitPriceJPY = UnitPriceUSD*(SELECT ExchangeFromUSD FROM CurrencyExchanges WHERE CurrencyName LIKE 'JPY');
ELSEIF vProductID IN (SELECT ProductID FROM ProductCurrencies) THEN
	UPDATE ProductCurrencies SET UnitPriceEUR = UnitPriceUSD*(SELECT ExchangeFromUSD FROM CurrencyExchanges WHERE CurrencyName LIKE 'EUR'), UnitPriceGBP = UnitPriceUSD*(SELECT ExchangeFromUSD FROM CurrencyExchanges WHERE CurrencyName LIKE 'GBP'), UnitPriceJPY = UnitPriceUSD*(SELECT ExchangeFromUSD FROM CurrencyExchanges WHERE CurrencyName LIKE 'JPY')
    WHERE ProductID = vProductID;
ELSE 
	SELECT 'Warning Message: There is no product with this identifier.' AS '';
END IF;
SET SQL_SAFE_UPDATES = 1;

END $$
DELIMITER ;


SET @p_id = 20;
CALL insert_currencies(@p_id);
SELECT * FROM ProductCurrencies;
SET @p_id = 0;
CALL insert_currencies(@p_id);
SELECT * FROM ProductCurrencies;
SET @p_id = 86;
CALL insert_currencies(@p_id);
