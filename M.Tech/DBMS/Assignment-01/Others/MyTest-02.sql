SET @order_id := 257;
SELECT Warehouse.available_quantity
                   FROM Warehouse
                   WHERE Warehouse.book_id = 1
                   and Warehouse.store_id = (select store_id from Cust_Order where Cust_Order.order_id = @order_id)
                   LIMIT 1;
                   
create table a ( col1 varchar(20), col2 varchar(20));
create table b ( col1 INT, col2 INT);
select * from a;
select * from b;

DROP TRIGGER before_update_a;
delimiter //
CREATE TRIGGER before_update_a BEFORE INSERT
ON b
FOR EACH ROW
begin
declare
order_id int default null;
set @order_id := NEW.col1;
IF NEW.col2 > 1
THEN
UPDATE a SET col2 = '6' WHERE a.col1 = @order_id;
END IF;
end; //
delimiter ;

drop table b;
insert into b VALUES (257,10);

select * from Warehouse WHERE book_id = 1 and store_id = 4;

select * from distributor_order order by 1 desc limit 10;
select * from distributor_order_line order by 1 desc limit 10;
select * from Distributor_Paymet_Details order by 1 desc limit 10;

select * from distributor_order_line order by 1 desc limit 1;

-- in store_id int,in book_id int,in quantity int
CALL sp_GetBooks (4, 1, 10);

DROP TABLE A;
DROP TABLE B;
SHOW TABLES;
COMMIT;


desc book;

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