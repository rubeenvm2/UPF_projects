DROP EVENT IF EXISTS default_employees;
CREATE EVENT IF NOT EXISTS default_employees
ON SCHEDULE AT '2023-01-01 00:00:00'
DO
CALL set_default_employees();
DROP EVENT IF EXISTS default_employees;

