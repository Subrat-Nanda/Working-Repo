/* 01 - Testing Store_Procedure  */
-- Get Book Availabity details before Calling Store_Procedure
select * from Warehouse WHERE book_id = 1 and store_id = 4;

-- in store_id int,in book_id int,in quantity int
CALL sp_GetBooks (4, 1, 10);

-- Get Book Availabity details  After Calling Store_Procedure
select * from Warehouse WHERE book_id = 1 and store_id = 4;

/* ========================================================================================= */

/* 02 - Testing Function */

-- Get Book details 
SELECT * FROM BOOK WHERE book_id = 17;

-- Call Function
select calculate_order_price(17,5);

/* ========================================================================================= */

/* 03 - Testing Trigger */

/* Note - we need to pass unique & not null value for isbn */

-- Inserting book with no unit price
INSERT INTO book (title, isbn, language_id, num_pages, publication_date, publisher_id) VALUES
('Test-01','7104300569878',2,112,'2023-02-17', 354);

-- Get Book Details with Randomly generated Price
select * from Book where title = 'Test-01';



-- 02  before_is_available 

-- Condition 01 : Invalid Quantity
    
INSERT INTO Customer_order_line  (order_id, book_id, quantity,price)VALUES
(257,1,-2,calculate_order_price(1,1));

INSERT INTO Customer_order_line  (order_id, book_id, quantity,price)VALUES
(257,1,0,calculate_order_price(1,1));


-- Condition 02 : Ord_Quantity > Available Quantity 
-- Get Book Availabity details
select * from Warehouse WHERE book_id = 1 and store_id = 4;

INSERT INTO Customer_order_line  (order_id, book_id, quantity,price)VALUES
(257,1,12,calculate_order_price(1,1));


-- Condition 03 : Ord_Quantity <= Available Quantity 
-- Get Book Availabity details
INSERT INTO Customer_order_line  (order_id, book_id, quantity,price)VALUES
(257,1,2,calculate_order_price(1,1));

-- Get Order_line Details
select * from Customer_order_line where order_id = 257;

-- Get Current Book Available Quantity
select * from Warehouse WHERE book_id = 1 and store_id = 4;



/*
Write PYTHON codes that connects to this database and use SQL commands to select and
retrieve information about availability of books identified by title, author, publisher or year
of publication
*/

SELECT B.BOOK_ID,B.TITLE,B.publication_date,A.author_NAME, P.publisher_name,S.store_name, W.available_quantity FROM BOOK B INNER JOIN Publisher P ON B.publisher_id = P.publisher_id
INNER JOIN Book_Author BA ON B.BOOK_ID = BA.BOOK_ID
INNER JOIN AUTHOR A ON A.author_id = BA.author_id
INNER JOIN Warehouse W ON W.BOOK_ID = B.BOOK_ID
INNER JOIN STORE S ON S.STORE_ID = W.STORE_ID 
WHERE B.BOOK_ID IN (1,2,3,4,5,6,7,8,9,10);