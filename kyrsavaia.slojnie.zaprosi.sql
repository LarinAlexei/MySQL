USE sbermarket;

-- 1. Вывести все продукты(товары) из products соответствующие catalogs.

SELECT id, name,
	(SELECT name FROM catalogs WHERE id = catalog_id) AS 'catalog'
FROM products;

-- Через JOIN

SELECT p.id, p.name, c.name
FROM
	products AS p 
JOIN
	catalogs AS c
ON c.id = p.catalog_id;

-- 2. Покажем содержимое корзины пользователя с id =1 (Елизавета).

SELECT p.name, p.description, p.price, d.discount, ROUND((p.price-d.discount), 2) AS 'price with discount'   
FROM users u 
LEFT JOIN basket b
ON u.id = b.user_id
JOIN products p 
ON b.product_id = p.id
JOIN discounts d
ON p.id = d.product_id
WHERE u.id = 1;  -- Елизавета


-- 3. Получим информацию о количестве продуктов по категориям каталога.

SELECT c.name, COUNT(*) AS 'Количество продуктов в категории' 
FROM catalogs c
LEFT JOIN products p 
ON c.id = p.catalog_id
GROUP BY p.catalog_id ;

-- 4. Выведем статус всех заказов.

SELECT CONCAT(u.firstname, ' ', u.lastname),
		e.status 
FROM users u 
JOIN `order` o 
ON u.id = o.user_id
JOIN employees e 
ON o.employees_id = e.id;


-- 5. Покажем суммарную стоимость продуктов в корзине по каждому пользователю.

SELECT u.firstname, user_id, SUM(price) AS Total, SUM(price_disc) AS Total_and_Discount 
FROM 
	(
	SELECT b.user_id, p.id, p.name, p.price, p.price - IF(d.discount IS NULL, 0, d.discount)  AS price_disc 
	FROM basket b 
	JOIN products p
	ON b.product_id = p.id
	LEFT JOIN discounts d 
	ON p.id = d.discount
	) AS total
	JOIN users u
	ON total.user_id = u.id 
GROUP BY user_id;













