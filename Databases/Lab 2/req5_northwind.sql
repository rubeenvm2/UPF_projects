DROP EVENT IF EXISTS update_prices;
CREATE EVENT IF NOT EXISTS update_prices
ON SCHEDULE EVERY 5 MINUTE
STARTS '2022-11-01 08:00:00'
ENDS '2023-08-01 00:00:00'
DO
CALL InsertCurrencies(0);
DROP EVENT IF EXISTS update_prices;
