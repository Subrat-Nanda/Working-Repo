select * from customer;
select * from shipper;

-- Customer_order
INSERT INTO cust_order (order_date,customer_id,store_id, shipper_Id,status_id)
SELECT
    NOW() - INTERVAL FLOOR(RAND() * 365 * 3 * 24 * 60 * 60) SECOND AS order_date,
    -- FLOOR(1 + RAND() * 1000) AS customer_id,
    c.customer_id,
    FLOOR(1 + RAND() * 299) AS store_id,
    FLOOR(1 + RAND() * 13) AS shipping_id,
    FLOOR(1 + RAND() * 7) AS status_id
FROM customer c
LIMIT 250;

select * from cust_order;


-- INSERT INTO Customer_order_line ;

INSERT INTO Customer_order_line (order_id, book_id, quantity,price)
SELECT A.order_id,A.BOOK_ID, A.QUANTITY, calculate_order_price(A.BOOK_ID, A.QUANTITY) as price FROM (
SELECT
    d.order_id,
    FLOOR(RAND() * 11127) AS book_id,
    ROUND(1 + RAND() * 5) AS quantity
FROM cust_order d order by rand() limit 10) AS A;

select * from Customer_order_line WHERE ORDER_ID = 1;

SELECT ORDER_ID ,COUNT(*) FROM Customer_order_line GROUP BY ORDER_ID;



-- INSERT INTO Distributor_Paymet_Details
INSERT INTO Customer_Paymet_Details (payment_type, price,order_id,status_Id)
SELECT 
'ONLINE',
COL.price,
COL.order_id,
2
FROM Customer_order_line COL 
ORDER BY RAND()
LIMIT 100;


INSERT INTO Customer_Paymet_Details (payment_type, price,order_id,status_Id)
SELECT 
'ONLINE',
COL.price,
COL.order_id,
5
FROM Customer_order_line COL 
ORDER BY RAND()
LIMIT 20;


INSERT INTO Customer_Paymet_Details (payment_type, price,order_id,status_Id)
SELECT 
'CASH',
COL.price,
COL.order_id,
2
FROM Customer_order_line COL 
ORDER BY RAND()
LIMIT 50;


SELECT * FROM Customer_Paymet_Details;