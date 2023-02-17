/* TESTING */

SELECT * FROM warehouse WHERE BOOK_ID = 1 AND store_id=4;

INSERT INTO cust_order (order_date,customer_id,store_id, shipper_Id,status_id)
VALUES (NOW(),1,4,1,7);

SELECT * FROM cust_order ORDER BY 1 desc LIMIT 1;
desc cust_order;
select * from cust_order where order_id = 257;
select * from Customer_order_line where order_id = 257;
select available_quantity from warehouse where BOOK_ID = 1 AND store_id=4;

INSERT INTO Customer_order_line  (order_id, book_id, quantity,price)VALUES
(257,1,2,calculate_order_price(1,1));

delete from Customer_order_line where order_id = 257;
select * from Customer_order_line order by 1 desc;
ALTER TABLE Customer_order_line AUTO_INCREMENT = 566;

select store_id from Cust_Order where Cust_Order.order_id = 257 limit 1;
select store_id from Cust_Order where Cust_Order.order_id = NEW.order_id limit 1;

SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = 1
                   and Warehouse.store_id = (select store_id from Cust_Order where Cust_Order.order_id = 257 limit 1)
                   LIMIT 1
                   ;
                   
select * from Cust_Order  where Cust_Order.order_id = 257;
SELECT  * from  Warehouse    WHERE Warehouse.book_id = 1 and Warehouse.store_id = 4;    
select * from Customer_order_line where order_id = 257;
SELECT * FROM BOOK WHERE book_id = 1;

select calculate_order_price(17,5);

UPDATE cust_order SET STATUS_ID = 7 WHERE cust_order.order_id = 257;

update Warehouse  set available_quantity=1 WHERE Warehouse.book_id = 1 and Warehouse.store_id = 4; 

select * from Warehouse WHERE Warehouse.book_id = 1 and Warehouse.store_id = 4; 




-- Inserting book with no unit price
INSERT INTO book (title, isbn, language_id, num_pages, publication_date, publisher_id) VALUES
('Test-01','7104300569878',2,112,'2023-02-17', 354);
select * from Book where title = 'Test-01';