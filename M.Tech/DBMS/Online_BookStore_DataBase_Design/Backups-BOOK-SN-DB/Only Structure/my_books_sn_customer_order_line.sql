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
-- Table structure for table `customer_order_line`
--

DROP TABLE IF EXISTS `customer_order_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_order_line` (
  `cust_line_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `price` double DEFAULT NULL,
  PRIMARY KEY (`cust_line_id`),
  KEY `fk_cust_ordline_order` (`order_id`),
  KEY `fk_cust_ordline_book` (`book_id`),
  CONSTRAINT `fk_cust_ordline_book` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cust_ordline_order` FOREIGN KEY (`order_id`) REFERENCES `cust_order` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `customer_order_line_chk_1` CHECK ((`quantity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=569 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_is_available` BEFORE INSERT ON `customer_order_line` FOR EACH ROW begin
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
IF ( NEW.quantity > avl_qty )  -- Checking condition when Ordered Quantity is grather than available quantity or 
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
end */;;
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

-- Dump completed on 2023-02-17 17:22:44
