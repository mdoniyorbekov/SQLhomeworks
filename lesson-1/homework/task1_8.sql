--1----------------------------
DROP TABLE IF EXISTS student;
CREATE TABLE student 
			(ID int, 
			 name VARCHAR(250),
			 age INT);
SELECT * FROM student
ALTER TABLE student 
ALTER COLUMN ID int NOT NULL;

--2----------------------------
DROP TABLE IF EXISTS product;
CREATE TABLE product (product_id INT CONSTRAINT UNIQ UNIQUE, 
					  product_name VARCHAR(100), 
					  price DECIMAL(10,2));
ALTER TABLE product
	drop constraint UNIQ;
ALTER TABLE product
	ADD CONSTRAINT UNIQ UNIQUE (product_id);

--3----------------------------
DROP TABLE IF EXISTS orders;
 CREATE TABLE orders (order_id INT CONSTRAINT PRIM PRIMARY KEY,
					  customer_name VARCHAR(100),
					  order_date DATE);
ALTER TABLE orders
	DROP CONSTRAINT PRIM;
ALTER TABLE orders
	ADD CONSTRAINT PRIM PRIMARY KEY(order_id);

--4----------------------------
DROP TABLE IF EXISTS item, category;
CREATE TABLE category (category_id int primary key,
						category_name VARCHAR(250));

CREATE TABLE item (item_id int primary key,
				   item_name VARCHAR(250),
				   category_id INT, 
				   CONSTRAINT FOREG FOREIGN KEY (category_id) REFERENCES category(category_id));

ALTER TABLE item
	DROP CONSTRAINT FOREG;

ALTER TABLE item
	ADD CONSTRAINT FOREG FOREIGN KEY (category_id) REFERENCES category(category_id);


--5----------------------------

DROP TABLE IF EXISTS account;
CREATE TABLE account (account_id int primary key,
					  balance DECIMAL(10,2) CONSTRAINT checking1 CHECK (balance>=0),
					  account_type VARCHAR(100) CONSTRAINT checking2 CHECK (account_type IN ('Savings', 'Checking')));
ALTER TABLE account
	DROP CONSTRAINT checking1;
ALTER TABLE account
	DROP CONSTRAINT checking2;

ALTER TABLE account
	ADD CONSTRAINT checking1 CHECK (balance>=0);
ALTER TABLE account
	ADD CONSTRAINT checking2 CHECK (account_type IN ('Savings', 'Checking'));

 
--6----------------------------
DROP TABLE IF EXISTS customer;
CREATE TABLE customer ( customer_id INT PRIMARY KEY,
						name VARCHAR(250),
						city VARCHAR(250) DEFAULT 'Unknown' 
						);
ALTER TABLE customer
ALTER COLUMN city DROP DEFAULT;

ALTER TABLE customer
ALTER COLUMN city ADD DEFAULT 'Unknown';



--7----------------------------
DROP TABLE IF EXISTS invoice;
CREATE TABLE invoice (invoice_id INT IDENTITY(1, 1), 
					  amount DECIMAL(10, 2));

INSERT INTO invoice (amount) VALUES (100);
INSERT INTO invoice (amount) VALUES (150);
INSERT INTO invoice (amount) VALUES (200);
INSERT INTO invoice (amount) VALUES (300);
INSERT INTO invoice (amount) VALUES (400);

SET IDENTITY_INSERT invoice ON;
INSERT INTO invoice(invoice_id, amount) VALUES (100, 200);
SET IDENTITY_INSERT invoice OFF;


--8----------------------------
DROP TABLE IF EXISTS books;
CREATE TABLE books (
					book_id INT PRIMARY KEY IDENTITY(1, 1),
					title VARCHAR(150) NOT NULL,
					price DECIMAL(10,2) CHECK (price>0),
					genre VARCHAR(150) DEFAULT 'Unknown');

INSERT INTO books(title, price, genre) VALUES ('1984', 100, 'Politics')

SELECT * FROM books;