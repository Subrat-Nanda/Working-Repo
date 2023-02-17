SELECT * FROM BOOK LIMIT 10;
SELECT * FROM STATUS;

-- INSERT INTO distributor_order_line ;

INSERT INTO distributor_order_line (order_id, book_id, quantity,price)
SELECT A.order_id,A.BOOK_ID, A.QUANTITY, calculate_order_price(A.BOOK_ID, A.QUANTITY) as price FROM (
SELECT
    d.order_id,
    FLOOR(RAND() * 11127) AS book_id,
    ROUND(RAND()*(25-10)+10) AS quantity
FROM distributor_order d) AS A;

select * from distributor_order_line;


-- INSERT INTO Customer_Paymet_Details
INSERT INTO Distributor_Paymet_Details (payment_type, price,order_id,status_Id)
SELECT 
'ONLINE',
DOL.price,
DOL.order_id,
2
FROM distributor_order_line DOL 
ORDER BY RAND()
LIMIT 100;


INSERT INTO Distributor_Paymet_Details (payment_type, price,order_id,status_Id)
SELECT 
'ONLINE',
DOL.price,
DOL.order_id,
5
FROM distributor_order_line DOL 
ORDER BY RAND()
LIMIT 20;


INSERT INTO Distributor_Paymet_Details (payment_type, price,order_id,status_Id)
SELECT 
'CASH',
DOL.price,
DOL.order_id,
2
FROM distributor_order_line DOL 
ORDER BY RAND()
LIMIT 50;

SELECT * FROM Distributor_Paymet_Details;