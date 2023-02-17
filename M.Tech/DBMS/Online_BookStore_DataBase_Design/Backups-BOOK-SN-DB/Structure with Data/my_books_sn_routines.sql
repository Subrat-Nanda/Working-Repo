CREATE DATABASE  IF NOT EXISTS `my_books_sn` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `my_books_sn`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: my_books_sn
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping events for database 'my_books_sn'
--

--
-- Dumping routines for database 'my_books_sn'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_order_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_order_price`(bookid int, qnty int) RETURNS double
    DETERMINISTIC
BEGIN
    DECLARE 
      order_value,unit_price DOUBLE DEFAULT null;
      SET unit_price = (SELECT book.unit_price FROM book WHERE book.book_id = bookid limit 1);
	  SET order_value = unit_price * qnty;
     RETURN order_value;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetBooks`(in storeid int,in bookid int,in quantity int)
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

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-17 17:20:53
