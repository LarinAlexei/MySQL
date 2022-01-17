DROP DATABASE IF EXISTS SBERMARKET;
CREATE DATABASE SBERMARKET;
USE SBERMARKET;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(200) COMMENT 'Имя',
	lastname VARCHAR(200) COMMENT 'Фамилия',
	email VARCHAR(250) UNIQUE,
	phone BIGINT UNSIGNED,
	birthday DATE,
	city VARCHAR(100),
	street VARCHAR(100)
); -- Покупатели

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(300) COMMENT 'Наименование',
	description TEXT COMMENT 'Общая Информация',
	price DECIMAL (11,2) COMMENT 'Цена',
	catalog_id BIGINT UNSIGNED,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),
	KEY index_catalog_id (catalog_id)
); -- Товары

DROP TABLE IF EXISTS basket;
CREATE TABLE basket (
	PRIMARY KEY(user_id, product_id),
	user_id BIGINT UNSIGNED,
	order_id BIGINT UNSIGNED, -- Номер заказа
	product_id BIGINT UNSIGNED, -- id заказаного товара
	total INT UNSIGNED DEFAULT 1, -- Количество товара
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE
); -- Корзина

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(300) COMMENT 'Название раздела',
	UNIQUE unique_name(name(10)),
	FOREIGN KEY(id) REFERENCES products(catalog_id) ON UPDATE CASCADE ON DELETE CASCADE
); -- 'Разделы интернет-магазина'

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
	id SERIAL PRIMARY KEY,
	product_id BIGINT UNSIGNED, -- id Товара
	discount FLOAT UNSIGNED, -- Cкидка
	started_at DATETIME, -- Начало скидки
	finished_at DATETIME, -- Конец скидки
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT NOW(),
	FOREIGN KEY(product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE 
); -- Скидки

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	employee_name VARCHAR(250), -- Имя работника
	phone_employee BIGINT UNSIGNED, -- Телефон работника
	status ENUM('picker', 'deliveryman'), -- Должность
	created_at DATETIME DEFAULT NOW()
);  -- Работники

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
	id SERIAL PRIMARY KEY, -- Номер заказа
	user_id BIGINT UNSIGNED, -- Чей заказ
	employees_id BIGINT UNSIGNED, -- Статус заказа находится на (сборке, доставке)
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(employees_id) REFERENCES employees(id) ON UPDATE CASCADE ON DELETE CASCADE
); -- Заказ

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
	order_id BIGINT UNSIGNED,
	product_id BIGINT UNSIGNED, -- id заказаного товара
	total INT UNSIGNED DEFAULT 1, -- Количество товара
	PRIMARY KEY(order_id, product_id),
	FOREIGN KEY(order_id) REFERENCES `order`(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE
); -- Заказанные продукты




















































