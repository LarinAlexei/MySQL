USE sbermarket;

-- 1. Представление для таблицы products извлечем из неё раздел с бытовой техникой. 

DROP VIEW IF EXISTS appliances;

CREATE VIEW appliances AS
SELECT id, name, price
FROM products
WHERE catalog_id = 6; -- Бытовая техника

SELECT id, name, price FROM appliances;

-- 2. Заменим название столбцов и поменяем их местами в таблице products.

DROP VIEW IF EXISTS name_change;

CREATE VIEW name_change (title, price_tag, number_id) AS
SELECT name, price, id FROM products;

SELECT title, price_tag, number_id FROM name_change;
