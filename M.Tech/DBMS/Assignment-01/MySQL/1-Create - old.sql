CREATE DATABASE MY_BOOKS_SN;
USE  MY_BOOKS_SN;

DROP TABLE IF EXISTS Author CASCADE;
DROP TABLE IF EXISTS Publisher CASCADE;
DROP TABLE IF EXISTS book_language CASCADE;
DROP TABLE IF EXISTS book CASCADE;
DROP TABLE IF EXISTS book_author CASCADE;
DROP TABLE IF EXISTS shipper CASCADE;
DROP TABLE IF EXISTS status CASCADE;
DROP TABLE IF EXISTS distributor_order;
DROP TABLE IF EXISTS distributor_order_line;
DROP TABLE IF EXISTS Distributor_Paymet_Details;
DROP TABLE IF EXISTS cust_order;
DROP TABLE IF EXISTS Customer_order_line;
DROP TABLE IF EXISTS Distributor_Paymet_Details;


-- 1 Author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT,
    author_name VARCHAR(400) NOT NULL,
    CONSTRAINT pk_author PRIMARY KEY (author_id)
);

-- 2 publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT,
    publisher_name VARCHAR(400)  NOT NULL,
    CONSTRAINT pk_publisher PRIMARY KEY (publisher_id)
);

/*
ALTER TABLE publisher
MODIFY COLUMN publisher_name VARCHAR(400)  NOT NULL;
ALTER TABLE publisher DROP CONSTRAINT publisher_name;
desc publisher;
*/

-- 3 book_language
CREATE TABLE book_language (
    language_id  INT AUTO_INCREMENT,
    language_code VARCHAR(8),
    language_name VARCHAR(50),
    CONSTRAINT pk_language PRIMARY KEY (language_id)
);


-- 4 Book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT,
    title VARCHAR(400),
    isbn VARCHAR(13) UNIQUE NOT NULL,
    language_id INT ,
    num_pages INT CHECK (num_pages > 0),
	unit_price DECIMAL(5, 2),
    publication_date DATE Default (CURRENT_DATE -10),
	publication_City VARCHAR(200),
    publisher_id INT,
    CONSTRAINT pk_book PRIMARY KEY (book_id),
    CONSTRAINT fk_book_lang FOREIGN KEY (language_id) REFERENCES book_language (language_id) ON DELETE CASCADE,
    CONSTRAINT fk_book_pub FOREIGN KEY (publisher_id) REFERENCES publisher (publisher_id) ON DELETE CASCADE
);

-- 5 book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    CONSTRAINT pk_bookauthor PRIMARY KEY (book_id, author_id),
    CONSTRAINT fk_ba_book FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE,
    CONSTRAINT fk_ba_author FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE
);


-- 6 Customer

CREATE TABLE customer (
    customer_id 	INT AUTO_INCREMENT,
    first_name 		VARCHAR(200) NOT NULL,
    last_name 		VARCHAR(200) NOT NULL,
    email 			VARCHAR(350) UNIQUE,
	phone_nubmer 	VARCHAR(12)	 UNIQUE NOT NULL,
	Address1		VARCHAR(200) NOT NULL,
	Address2		VARCHAR(200),
	Address3		VARCHAR(200),
    city 			VARCHAR(100) NOT NULL,
	state 			VARCHAR(100) NOT NULL,
	country 		VARCHAR(100) NOT NULL,
    postalcode		INT 		 NOT NULL,
    CONSTRAINT pk_customer PRIMARY KEY (customer_id)
);


-- 7 Store

CREATE TABLE Store (
	store_id		INT AUTO_INCREMENT,
	store_name		VARCHAR(400) NOT NULL,
	Type			VARCHAR(100) CHECK (Type = 'Distributor' OR Type = 'Retailer'),
	phone 			VARCHAR(12),
	email			VARCHAR(200),
	street			VARCHAR(200),
	city			VARCHAR(200),
	state			VARCHAR(200),
	zip_code		INT,
	CONSTRAINT pk_store PRIMARY KEY (store_id)
);


-- 8 Warehouse

CREATE TABLE Warehouse (
	store_id INT,
    book_id INT,
    available_quantity INT,
    CONSTRAINT pk_orderline PRIMARY KEY (book_id,store_id),
	CONSTRAINT fk_warehouse_book_id FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE,
    CONSTRAINT fk_warehouse_store_id FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE CASCADE
);


-- 9 shipper
CREATE TABLE shipper (
    shipper_Id	 	 INT AUTO_INCREMENT,
    shipper_name	 VARCHAR(400),
	phone_number	 VARCHAR(12),
    CONSTRAINT pk_shipper PRIMARY KEY (shipper_Id)
);

-- 10 status
CREATE TABLE status (
    status_Id	 	 INT AUTO_INCREMENT,
    status			 VARCHAR(400),
    CONSTRAINT pk_status PRIMARY KEY (status_Id)
);


-- 11 distributor_order

CREATE TABLE distributor_order (
    order_id 		INT AUTO_INCREMENT,
    order_date 		DATETIME  Default (CURRENT_DATE),
    store_id	 	INT,
	shipper_Id		INT,
	espected_delivery_date	DATETIME Default (DATE_ADD(order_date, INTERVAL 2 DAY)),
	status_id			INT,
    CONSTRAINT pk_dist_order PRIMARY KEY (order_id),
    CONSTRAINT fk_dist_order_store FOREIGN KEY (store_id) REFERENCES Store (store_id) ON DELETE CASCADE,
    CONSTRAINT fk_dist_order_shipper FOREIGN KEY (shipper_Id) REFERENCES shipper (shipper_Id) ON DELETE CASCADE,
    CONSTRAINT fk_dist_order_status FOREIGN KEY (status_Id) REFERENCES status (status_Id) ON DELETE CASCADE
);

/*
ALTER TABLE distributor_order
DROP COLUMN espected_delivery_date;

ALTER TABLE distributor_order
ADD COLUMN espected_delivery_date DATETIME  Default (DATE_ADD(order_date, INTERVAL 2 DAY)) AFTER shipper_Id;
*/

-- 12 distributor_order_line
CREATE TABLE distributor_order_line (
    dist_line_id INT AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT Default 10,
    check( quantity > 9),
    price DOUBLE,
    CONSTRAINT pk_orderline PRIMARY KEY (dist_line_id),
    CONSTRAINT fk_dist_ordline_order FOREIGN KEY (order_id) REFERENCES distributor_order (order_id) ON DELETE CASCADE,
    CONSTRAINT fk_dist_ordline_book FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE
);

/*
ALTER TABLE distributor_order_line
MODIFY COLUMN price DOUBLE;  
DESC distributor_order_line;
*/

-- 13 Distributor_Paymet_Details
CREATE TABLE Distributor_Paymet_Details (
    payment_id		INT AUTO_INCREMENT,
	payment_type	VARCHAR(200),
	price 			DOUBLE check( price > 0),
	payment_status	VARCHAR(200),
	order_id 		INT,
    status_Id		INT,
    CONSTRAINT pk_Payment_Details PRIMARY KEY (payment_id),
	CONSTRAINT fk_dist_payment_order_id FOREIGN KEY (order_id) REFERENCES distributor_order_line (order_id) ON DELETE CASCADE,
    CONSTRAINT fk_dist_payment_status FOREIGN KEY (status_Id) REFERENCES status (status_Id) ON DELETE CASCADE
);


/*
ALTER TABLE Customer_Paymet_Details
MODIFY COLUMN payment_id INT AUTO_INCREMENT;  
DESC Customer_Paymet_Details;


ALTER TABLE Distributor_Paymet_Details
MODIFY COLUMN price DOUBLE;  
DESC Distributor_Paymet_Details;
*/

-- 14 cust_order
CREATE TABLE cust_order (
    order_id 		INT AUTO_INCREMENT,
    order_date 		DATETIME Default (CURRENT_DATE),
    customer_id 	INT,
    store_id	 	INT,
	shipper_Id		INT,
	espected_delivery_date		DATETIME Default (DATE_ADD(order_date, INTERVAL 5 DAY)),
	status_id			INT Default (1),
    CONSTRAINT pk_custorder PRIMARY KEY (order_id),
    CONSTRAINT fk_order_cust FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_store FOREIGN KEY (store_id) REFERENCES Store (store_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_shipper FOREIGN KEY (shipper_Id) REFERENCES shipper (shipper_Id) ON DELETE CASCADE,
    CONSTRAINT fk_order_status FOREIGN KEY (status_Id) REFERENCES status (status_Id) ON DELETE CASCADE
);

/*
ALTER TABLE cust_order
DROP COLUMN espected_delivery_date;

ALTER TABLE cust_order
ADD COLUMN espected_delivery_date DATETIME  Default (DATE_ADD(order_date, INTERVAL 5 DAY)) AFTER shipper_Id;
*/

-- 15 Customer_order_line
CREATE TABLE Customer_order_line (
    cust_line_id INT AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT Default 1,
    check( quantity > 0),
    price DOUBLE,
    CONSTRAINT pk_orderline PRIMARY KEY (cust_line_id),
    CONSTRAINT fk_cust_ordline_order FOREIGN KEY (order_id) REFERENCES cust_order (order_id) ON DELETE CASCADE,
    CONSTRAINT fk_cust_ordline_book FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE
);

/*
ALTER TABLE Customer_order_line
MODIFY COLUMN price DOUBLE;  
DESC Customer_order_line;
*/


-- 16 Distributor_Paymet_Details
CREATE TABLE Customer_Paymet_Details (
    payment_id		INT AUTO_INCREMENT,
	payment_type	VARCHAR(200),
	price 			DOUBLE check( price > 0),
	payment_status	VARCHAR(200),
	order_id 		INT,
    status_Id		INT,
    CONSTRAINT pk_Payment_Details PRIMARY KEY (payment_id),
	CONSTRAINT fk_cust_payment_order_id FOREIGN KEY (order_id) REFERENCES Customer_order_line (order_id) ON DELETE CASCADE,
    CONSTRAINT fk_cust_payment_status FOREIGN KEY (status_Id) REFERENCES status (status_Id) ON DELETE CASCADE
);

/*
ALTER TABLE Customer_Paymet_Details
MODIFY COLUMN price DOUBLE;  
DESC Customer_Paymet_Details;
*/


/* Trigger */

delimiter //
CREATE  TRIGGER before_genrate_book_unit_price BEFORE INSERT
ON book
FOR EACH ROW
	IF (new.unit_price is null) OR (new.unit_price <=0) 
	THEN
	SET NEW.unit_price = round(RAND()*(500-100)+100);
    END IF;
//
delimiter ;

delimiter //
CREATE TRIGGER before_is_available BEFORE INSERT
ON Customer_order_line
FOR EACH ROW
begin
declare
order_id,avl_qty int default null;
set @order_id := NEW.order_id;
IF NEW.quantity <= 0 THEN
SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'PLEASE ENTER A VALID BOOK QUANTITY';
END IF; 
SELECT Warehouse.available_quantity into avl_qty
                   FROM Warehouse
                   WHERE Warehouse.book_id = NEW.book_id
                   and Warehouse.store_id =  (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1)
                   LIMIT 1;
/*
IF NEW.quantity > (SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = NEW.book_id
                   and Warehouse.store_id =  (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1)
                   LIMIT 1)
*/
IF ( (NEW.quantity > avl_qty) OR ((avl_qty - NEW.quantity) < 0) )
THEN
begin
UPDATE cust_order SET status_Id = 6 WHERE cust_order.order_id = @order_id;
set @message_text = concat('NOT AVAILABLE - ORDER QUANTITY EXCEEDS AVAILABLE QUANTITY - AVAILABLE_BOOK_QTY = ' , avl_qty);
SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = @message_text;
end;
END IF;
IF NEW.quantity <= (SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = NEW.book_id
                   and Warehouse.store_id =  (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1)
                   LIMIT 1)
THEN
UPDATE Warehouse SET Warehouse.available_quantity = Warehouse.available_quantity-new.quantity 
WHERE new.book_id = Warehouse.book_id and store_id = (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1) limit 1;
END IF;
end; //
delimiter ;

/* Function */
DELIMITER //
CREATE FUNCTION calculate_order_price (bookid int, qnty int)
  RETURNS DOUBLE
  DETERMINISTIC
  BEGIN
    DECLARE 
      order_value,unit_price DOUBLE DEFAULT null;
      SET unit_price = (SELECT book.unit_price FROM book WHERE book.book_id = bookid limit 1);
	  SET order_value = unit_price * qnty;
     RETURN order_value;
    END
    //
delimiter ;

/* Store Procedure */

delimiter //
CREATE PROCEDURE sp_GetBooks(in storeid int,in bookid int,in quantity int)
begin
-- DECLARE status_id INT DEFAULT 7 ;

INSERT INTO distributor_order (order_date, store_id, shipper_Id,status_id)
SELECT
    NOW() - INTERVAL FLOOR(RAND() * 365 * 3 * 24 * 60 * 60) SECOND AS order_date,
    storeid AS store_id,
    FLOOR(1 + RAND() * 13) AS shipping_method_id,
    7 AS status_id ;

INSERT INTO distributor_order_line (order_id, book_id, quantity,price)
SELECT A.order_id,A.BOOK_ID, A.QUANTITY, calculate_order_price(A.BOOK_ID, A.QUANTITY) as price FROM (
SELECT
    d.order_id,
    bookid AS book_id,
    quantity AS quantity
FROM distributor_order d order by order_id desc limit 1) AS A;

INSERT INTO Distributor_Paymet_Details (payment_type, price,order_id,status_Id)
SELECT 
'ONLINE',
DOL.price,
DOL.order_id,
2
FROM distributor_order_line AS DOL 
order by dist_line_id desc limit 1;

UPDATE Warehouse SET Warehouse.available_quantity = Warehouse.available_quantity + quantity 
WHERE Warehouse.book_id = bookid and Warehouse.store_id = storeid;


select * from distributor_order order by 1 desc limit 1;
select * from distributor_order_line order by 1 desc limit 1;
select * from Distributor_Paymet_Details order by 1 desc limit 1;
select * from Warehouse WHERE Warehouse.book_id = bookid and Warehouse.store_id = storeid;

end; //
delimiter ;



SHOW TRIGGERS;
DROP TRIGGER before_is_available;
DROP TRIGGER before_genrate_book_unit_price;
DROP TRIGGER before_is_available;
DROP TRIGGER after_insert_update_Dis_Payment;
DROP TRIGGER after_update_warehouse;








-- -----------------End-------------------------------
/*

drop trigger after_update_warehouse;
delimiter //
CREATE TRIGGER after_update_warehouse AFTER UPDATE
ON Warehouse
FOR EACH ROW
begin
-- declare
IF NEW.available_quantity <= 0
THEN
INSERT INTO distributor_order (order_date, store_id, shipper_Id,status_id)
SELECT
    NOW() - INTERVAL FLOOR(RAND() * 365 * 3 * 24 * 60 * 60) SECOND AS order_date,
    OLD.store_id AS store_id,
    FLOOR(1 + RAND() * 13) AS shipping_method_id,
    7 AS status_id;

INSERT INTO distributor_order_line (order_id, book_id, quantity,price)
SELECT A.order_id,A.BOOK_ID, A.QUANTITY, calculate_order_price(A.BOOK_ID, A.QUANTITY) as price FROM (
SELECT
    d.order_id,
    OLD.book_id AS book_id,
    10 AS quantity
FROM distributor_order d order by order_id desc limit 1) AS A;

INSERT INTO Distributor_Paymet_Details (payment_type, price,order_id,status_Id)
SELECT 
'ONLINE',
DOL.price,
DOL.order_id,
2
FROM distributor_order_line AS DOL 
order by dist_line_id desc limit 1;

END IF;
end; //
delimiter ;

drop PROCEDURE sp_GetBooks;







DELIMITER $$
CREATE TRIGGER after_insert_update_Dis_Payment AFTER INSERT 
ON Distributor_Paymet_Details
FOR EACH ROW
BEGIN
  DECLARE quantity INT;
  SELECT quantity INTO quantity
  FROM distributor_order_line
  WHERE order_id = NEW.order_id limit 1;
 
 IF NEW.status_id = 2 THEN
    UPDATE Warehouse SET Warehouse.available_quantity = Warehouse.available_quantity + quantity 
	WHERE book_id = (select book_id from distributor_order_line dol where dol.order_id = @order_id limit 1) and 
    store_id = (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1) limit 1;
  END IF;
END$$
DELIMITER ;




delimiter //
CREATE TRIGGER after_update_warehouse AFTER UPDATE
ON Warehouse
FOR EACH ROW
begin
-- declare
IF NEW.available_quantity < (SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = OLD.book_id
                   and Warehouse.store_id =  OLD.store_id
                   LIMIT 1)
THEN
INSERT INTO distributor_order (order_date, store_id, shipper_Id,status_id)
SELECT
    NOW() - INTERVAL FLOOR(RAND() * 365 * 3 * 24 * 60 * 60) SECOND AS order_date,
    NEW.store_id AS store_id,
    FLOOR(1 + RAND() * 13) AS shipping_method_id,
    7 AS status_id
FROM store s
LIMIT 1;

INSERT INTO distributor_order_line (order_id, book_id, quantity,price)
SELECT A.order_id,A.BOOK_ID, A.QUANTITY, calculate_order_price(A.BOOK_ID, A.QUANTITY) as price FROM (
SELECT
    d.order_id,
    FLOOR(RAND() * 11127) AS book_id,
    10 AS quantity
FROM distributor_order d order by 1 desc limit 1) AS A;

INSERT INTO Distributor_Paymet_Details (payment_type, price,order_id,status_Id)
SELECT 
'ONLINE',
DOL.price,
DOL.order_id,
2
FROM distributor_order_line DOL 
order by 1 desc limit 1;

update Warehouse set Warehouse.available_quantity = new.available_quantity + 10  
                   WHERE Warehouse.book_id = OLD.book_id
                   and Warehouse.store_id =  OLD.store_id;
END IF;
end; //
delimiter ;
*/

-- ------------------------------------------------------------------------------------------------------------------


DELIMITER //
CREATE FUNCTION sf_past_movie_return_date (return_date DATE)
  RETURNS VARCHAR(3)
   DETERMINISTIC
    BEGIN
     DECLARE sf_value VARCHAR(3);
        IF curdate() > return_date
            THEN SET sf_value = 'Yes';
        ELSEIF  curdate() <= return_date
            THEN SET sf_value = 'No';
        END IF;
     RETURN sf_value;
    END
    
    //
delimiter ;

drop FUNCTION calculate_order_price;




drop trigger before_is_available;
drop trigger before_update_cust_order;

delimiter //
CREATE TRIGGER before_is_available BEFORE INSERT
ON Customer_order_line
FOR EACH ROW
begin
declare
order_id int default null;
set @order_id := NEW.order_id;
IF NEW.quantity <= 0 THEN
SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'PLEASE ENTER A VALID BOOK QUANTITY';
END IF; 
IF NEW.quantity > (SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = NEW.book_id
                   and Warehouse.store_id =  (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1)
                   LIMIT 1)
THEN
begin
SIGNAL SQLSTATE '50003' SET MESSAGE_TEXT = @order_id;
UPDATE cust_order SET status_Id = 6 WHERE cust_order.order_id = @order_id;
SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'NOT AVAILABLE - ORDER QUANTITY EXCEEDS AVAILABLE QUANTITY';
end;
-- UPDATE cust_order SET status_Id = 6 WHERE cust_order.order_id = @order_id;
-- UPDATE `NOT AVAILABLE - ORDER QUANTITY EXCEEDS AVAILABLE QUANTITY` set x=1;
END IF;

IF NEW.quantity <= (SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = NEW.book_id
                   and Warehouse.store_id =  (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1)
                   LIMIT 1)
THEN
UPDATE Warehouse SET Warehouse.available_quantity = Warehouse.available_quantity-new.quantity 
WHERE new.book_id = Warehouse.book_id and store_id = (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1) limit 1;
END IF;
end; //
delimiter ;



delimiter //
CREATE TRIGGER before_update_cust_order BEFORE INSERT
ON Customer_order_line
FOR EACH ROW
 PRECEDES before_is_available
begin
declare
order_id int default null;
set @order_id := NEW.order_id;
IF NEW.quantity > (SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = NEW.book_id
                   and Warehouse.store_id =  (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1)
                   LIMIT 1)
THEN
UPDATE cust_order SET status_Id = 6 WHERE cust_order.order_id = @order_id;
END IF;
end; //
delimiter ;






SHOW TRIGGERS;

drop trigger check_availability;

DELIMITER $$
CREATE TRIGGER check_availability
BEFORE INSERT ON Customer_order_line
FOR EACH ROW
BEGIN
  DECLARE available_qty INT;
  SELECT available_quantity INTO available_qty
  FROM Warehouse
  WHERE book_id = NEW.book_id
        and store_id = (select store_id from Cust_Order where Cust_Order.order_id = new.order_id limit 1) limit 1;
  IF available_qty < NEW.quantity THEN
    UPDATE cust_order SET STATUS_ID = 6 WHERE cust_order.order_id = NEW.order_id;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order quantity exceeds available quantity-';
  ELSE
	UPDATE Warehouse SET Warehouse.available_quantity = Warehouse.available_quantity - new.quantity 
	WHERE new.book_id = Warehouse.book_id and store_id = (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1) limit 1;
  END IF;
END$$
DELIMITER ;

/*
delimiter //
CREATE TRIGGER before_is_available BEFORE INSERT
ON Customer_order_line
FOR EACH ROW
begin
declare
order_id int default null;
set @order_id := NEW.order_id;
IF NEW.quantity <= 0 THEN
SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'PLEASE ENTER A VALID BOOK QUANTITY';
END IF; 
IF NEW.quantity > (SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = NEW.book_id
                   and Warehouse.store_id =  (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1)
                   LIMIT 1)
THEN
begin
UPDATE cust_order SET status_Id = 6 WHERE cust_order.order_id = @order_id;
SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'NOT AVAILABLE - ORDER QUANTITY EXCEEDS AVAILABLE QUANTITY';
end;
END IF;

IF NEW.quantity <= (SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = NEW.book_id
                   and Warehouse.store_id =  (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1)
                   LIMIT 1)
THEN
UPDATE Warehouse SET Warehouse.available_quantity = Warehouse.available_quantity-new.quantity 
WHERE new.book_id = Warehouse.book_id and store_id = (select store_id from Cust_Order where Cust_Order.order_id = @order_id limit 1) limit 1;
END IF;
end; //
delimiter ;

*/


