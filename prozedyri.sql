USE sbermarket;

-- Перенесм столбцы из таблицы basket и products в одну таблицу.

DROP TABLE IF EXISTS `update`;
CREATE TABLE `update` (
	user_id BIGINT UNSIGNED,
	order_id BIGINT UNSIGNED,
	product_id BIGINT UNSIGNED,
	name VARCHAR(300)
);

DROP PROCEDURE IF EXISTS updatetable;

DELIMITER //
CREATE PROCEDURE updatetable()
BEGIN       
       INSERT INTO `update` (user_id, order_id, product_id, name)
       SELECT b.user_id, b.order_id, b.product_id, p.name 
       FROM basket b  LEFT JOIN products p
       ON b.product_id = p.id;
END//
DELIMITER ;

SELECT * FROM `update`;

CALL updatetable();

SELECT * FROM `update`;