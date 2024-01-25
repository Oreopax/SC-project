CREATE DATABASE  IF NOT EXISTS `store` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `store`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: store
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryid` int NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`categoryid`),
  UNIQUE KEY `categoryname_UNIQUE` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (2,'Tablet','Light and high performance tablet for school'),(4,'USB Flash Drive','a data storage device that includes flash memory with an integrated USB interface. It is typically removable, rewritable and much smaller than an optical disc. Most weigh less than 30g.'),(10,'Phone','A mobile phone is a wireless handheld device that allows users to make and receive calls'),(12,'Laptop','Light and high performance laptops for school'),(23,'Watch','A watch is a portable timepiece intended to be carried or worn by a person.'),(24,'Speaker','loudspeaker, also called speaker, in sound reproduction, device for converting electrical energy into acoustical signal energy that is radiated into a room or open air.'),(44,'Calculator','Calculator provides simple and advanced mathematical functions ');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount` (
  `discountid` int NOT NULL AUTO_INCREMENT,
  `productid` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` longtext NOT NULL,
  `discount_percentage` double NOT NULL,
  `start_at` timestamp NOT NULL,
  `end_at` timestamp NOT NULL,
  PRIMARY KEY (`discountid`),
  KEY `fk_productid_idx` (`productid`),
  CONSTRAINT `fk_productid2` FOREIGN KEY (`productid`) REFERENCES `product` (`productid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
INSERT INTO `discount` VALUES (6,8,'60% DISCOUNT','60% OFF END AT 20 FEB',60,'2022-01-17 16:00:00','2022-02-19 16:00:00'),(16,14,'5% DISCOUNT','ONLY VALID TIL 28 SEPTEMBER 2022',5,'2021-09-26 16:00:00','2022-09-27 16:00:00'),(25,27,'12% DISCOUNT','12% TILL 18 Jun 2022',12,'2022-01-17 16:00:00','2022-06-17 16:00:00'),(28,14,'25% OFF','25% off till 18 Apr 2022',25,'2022-01-17 16:00:00','2022-04-17 16:00:00'),(29,58,'5% OFF','5% OFF FOR A YEAR',5,'2022-01-17 16:00:00','2023-01-17 16:00:00');
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `userid` int NOT NULL,
  `cart` json NOT NULL,
  `total` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`orderid`),
  KEY `userid_idx` (`userid`),
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (52,66,'[{\"price\": 1330, \"quantity\": \"3\", \"productid\": 27, \"discountid\": null, \"discountPercentage\": 0}, {\"price\": 138.12, \"quantity\": \"4\", \"productid\": 35, \"discountid\": null, \"discountPercentage\": 0}, {\"price\": 737.8, \"quantity\": \"6\", \"productid\": 8, \"discountid\": null, \"discountPercentage\": 0}]',8969.28,'2022-02-06 08:47:10'),(53,66,'[{\"price\": \"1391.81\", \"quantity\": \"1\", \"productid\": 14, \"discountid\": 28, \"discountPercentage\": 25}]',1391.81,'2022-02-06 08:52:59'),(54,66,'[{\"price\": \"295.12\", \"quantity\": \"3\", \"productid\": 8, \"discountid\": 6, \"discountPercentage\": 60}, {\"price\": 1649, \"quantity\": \"1\", \"productid\": 22, \"discountid\": null, \"discountPercentage\": 0}, {\"price\": \"237.49\", \"quantity\": \"3\", \"productid\": 58, \"discountid\": 29, \"discountPercentage\": 5}, {\"price\": \"1391.81\", \"quantity\": \"2\", \"productid\": 14, \"discountid\": 28, \"discountPercentage\": 25}, {\"price\": \"1762.96\", \"quantity\": \"2\", \"productid\": 14, \"discountid\": 16, \"discountPercentage\": 5}]',9556.37,'2022-02-06 09:10:12');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `brand` varchar(100) NOT NULL,
  `price` double NOT NULL,
  `categoryid` int NOT NULL,
  PRIMARY KEY (`productid`),
  KEY `categoryid_idx` (`categoryid`),
  CONSTRAINT `fk_categoryid` FOREIGN KEY (`categoryid`) REFERENCES `category` (`categoryid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (8,'Samsung Galaxy Tab S7','Amazing Tablet','Samsung',737.8,2),(14,'SP AMD Ryzen 3600 Laptop','Best Laptop','SP IT!',1855.75,12),(22,'iPhone 13 Pro','A dramatically more powerful camera system. A display so responsive, every interaction feels new again. The world’s fastest smartphone chip. Exceptional durability. And a huge leap in battery life.','Apple',1649,10),(26,'Nokia 3310','The Nokia 3310 is a GSM mobile phone announced on 1 September 2000, and released in the fourth quarter of the year, replacing the popular Nokia 3210. It sold very well, being one of the most successful phones, with 126 million units sold worldwide, and being one of Nokia\'s most iconic','Nokia',10000,10),(27,'Samsung Galaxy Z Flip3 5G','A full-sized smartphone that folds to fit small-sized pockets. Folded, Galaxy Z Flip3 5G measures 4.2 inches, fitting even in those \"it has pockets!\" outfits with room to spare','Samsung',1330,10),(28,'Samsung Galaxy Watch4 Classic','Galaxy Watch4 Classic combines health/fitness tracking with a refined design, featuring a customizable face and rotating bezel on a stainless steel watch.','Samsung',598,23),(29,'ThinkBook 14s Gen 2','The Lenovo ThinkBook 14s Gen 2 (14\" Intel) laptop is available with cutting-edge 11th Gen Intel® Core™ i7 processors and Iris Xe graphics. You\'ll have everything you need to complete some of the most demanding computing tasks like graphic design, video editing, data mining, and more. And Intelligent Cooling lets you push your processor to its peak performance without overheating.','Lenovo',1428,12),(35,'Lenovo Tab M8','Stunning performance and stylish design combine in this quick, powerful Android tablet, powered by a Quad-Core, 2.0 GHz processor and Android 9 Pie','Lenovo',138.12,2),(36,'Google Pixel 6','6.4 inches, AMOLED, 1080 x 2400 pixels, Corning Gorilla Glass Victus','Google',1189,10),(37,'Acer Swift X','It\'s all about the innovation. Acer products are designed for your needs and accessibility with powerful features fit for your lifestyle. The Acer Swift X laptop is ready to unleash the creativity within. This Acer Ryzen 7 notebook is great for college students majoring in creative pursuits such as design and multimedia. Your inspiration will find the power it needs in the AMD Ryzen 7 5000 Series Mobile Processor. The multi-core processor speeds up rendering and other time-consuming tasks so you can spend your valuable time imagining new ideas and bringing them to life. With the latest NVIDIA GeForce RTX 3050 Ti Laptop GPU, you\'ll experience graphics powered by new RT cores, Tensor cores, and streaming multiprocessors for visuals that look like real life. Start livestreaming or play back your video creations with Acer technologies like PurifiedVoice and TrueHarmony to give you clear audio. Spend the day on the move with long battery life and a sleek, portable chassis. Worried about keeping your ideas safe? The embedded fingerprint reader with Windows Hello Certification makes sure only you can log into your Acer Swift X laptop. ','Acer',1559.01,12),(58,'Action II Bluetooth','Acton II may be compact, but its sound is nothing short of large. This dynamic compact speaker features three dedicated class D amplifiers that power its dual tweeters and subwoofer, for a sound that is nothing short of large. With Bluetooth 5.0 technology you can play your music in glorious, stereo sound with no wires required.','Marshall',249.99,24);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productimages`
--

DROP TABLE IF EXISTS `productimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productimages` (
  `imageid` int NOT NULL AUTO_INCREMENT,
  `productid` int NOT NULL,
  `name` longtext NOT NULL,
  `path` longtext NOT NULL,
  `type` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`imageid`),
  KEY `fk_productid_idx` (`productid`),
  CONSTRAINT `fk_productid3` FOREIGN KEY (`productid`) REFERENCES `product` (`productid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productimages`
--

LOCK TABLES `productimages` WRITE;
/*!40000 ALTER TABLE `productimages` DISABLE KEYS */;
INSERT INTO `productimages` VALUES (59,22,'image-1642883738797-437320279.png','images\\product\\image-1642883738797-437320279.png','image/png','2022-01-22 20:35:38'),(60,8,'image-1642883967139-545684617.png','images\\product\\image-1642883967139-545684617.png','image/png','2022-01-22 20:39:27'),(61,14,'image-1642884440853-800673003.png','images\\product\\image-1642884440853-800673003.png','image/png','2022-01-22 20:47:20'),(64,26,'image-1642947814139-687514236.png','images\\product\\image-1642947814139-687514236.png','image/png','2022-01-23 14:23:34'),(65,27,'image-1642951735210-775230483.png','images\\product\\image-1642951735210-775230483.png','image/png','2022-01-23 15:28:55'),(66,28,'image-1642951813986-573392333.png','images\\product\\image-1642951813986-573392333.png','image/png','2022-01-23 15:30:13'),(68,29,'image-1643537993805-877823283.png','images\\product\\image-1643537993805-877823283.png','image/png','2022-01-30 10:19:53'),(72,35,'image-1643541280646-719557417.jpeg','images\\product\\image-1643541280646-719557417.jpeg','image/jpeg','2022-01-30 11:14:40'),(73,36,'image-1643541518834-635173112.jpeg','images\\product\\image-1643541518834-635173112.jpeg','image/jpeg','2022-01-30 11:18:38'),(74,37,'image-1643541761674-938138594.jpeg','images\\product\\image-1643541761674-938138594.jpeg','image/jpeg','2022-01-30 11:22:41'),(77,36,'image-1643701503653-965822666.jpeg','images\\product\\image-1643701503653-965822666.jpeg','image/jpeg','2022-02-01 07:45:03'),(78,22,'image-1643702394381-94848052.png','images\\product\\image-1643702394381-94848052.png','image/png','2022-02-01 07:59:54'),(79,22,'image-1643702437678-783911843.jpeg','images\\product\\image-1643702437678-783911843.jpeg','image/jpeg','2022-02-01 08:00:37'),(86,58,'image-1644053777099-253758651.png','images\\product\\image-1644053777099-253758651.png','image/png','2022-02-05 09:42:56'),(88,58,'image-1644054194303-997016240.png','images\\product\\image-1644054194303-997016240.png','image/png','2022-02-05 09:43:14'),(89,58,'image-1644054391066-493190126.png','images\\product\\image-1644054391066-493190126.png','image/png','2022-02-05 09:46:31');
/*!40000 ALTER TABLE `productimages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `reviewid` int NOT NULL AUTO_INCREMENT,
  `rating` double NOT NULL,
  `review` longtext NOT NULL,
  `userid` int NOT NULL,
  `productid` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reviewid`),
  KEY `fk_userid_idx` (`userid`),
  KEY `fk_productid_idx` (`productid`),
  CONSTRAINT `fk_productid` FOREIGN KEY (`productid`) REFERENCES `product` (`productid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_userid` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (17,3,'Laggy tablet, keeps crashing',38,8,'2021-12-03 09:41:48'),(20,5,'Good Laptop, super fast and can play game in class!',45,14,'2021-12-04 19:58:31'),(55,4,'Nice watch',66,28,'2022-01-29 23:26:51'),(58,5,'Durable!',66,26,'2022-01-30 00:15:59'),(63,5,'I ended up buying two of these. First one was for me, the second one was for my son who is in the military.  I can say that my power brick works fine and the \"pigtail\" fits into the brick just fine. I think that reviewer was unlucky and got a dud.  RAM is soldered on, so there aren\'t any upgrades. However, it\'s low power DDR4 4266, so it\'s fast and also in dual channel. 16 GB should be enough for most people.  The SSD is a PCIe 3.0 x4, so it\'s relatively quick. HWinfo64 reports it\'s also NVMe 1.3, which isn\'t the latest spec. The SSD itself is made by SK Hynix and performs reasonably well. There are two M.2 slots inside. Slot 1 is NVMe/SATA. Second is NVMe only. Both slots are PCIe 3.0 as the AMD Ryzen 5000 series only supports PCIe 3.0. If you want to upgrade your storage, don\'t waste your money on a Gen 4/PCIe 4.0 SSD unless you plan on moving it to a faster computer later. I recommend the SK Hynix P31 Gold 1 TB for a second drive. I put one in my son\'s Swift X and it performs very well.  The Wifi is made by Mediatek. I had a lot of issues with this card. It wouldn\'t connect to my Fios wireless network (it\'d connect to the guest network though - go figure). Card was very slow. I bought an Intel AX210 for my son\'s laptop and it fixed the problems. Speed and connectivity is significantly better with an Intel card.  The laptop is a little short on ports, including an Ethernet and an SD card slot. You may want to get a USB dock that has these and additional USB ports.  Now the graphics card. First off, this is NOT a gaming laptop nor does it claim to be. This is a low power version of the RTX 3050 Ti. If you buy this with gaming as your primary focus, you\'ll be disappointed. There are dedicated gaming laptops that will do a much better job.  With that being said, this laptop is one that is capable of doing some lighter gaming and doing it reasonably well. It will perform better than other thin and light graphics solutions like the Nvidia MX450 or the Intel Xe. Think more of playing a game in your hotel after a day of work. The lower power edition will have lower performance than other RTX 3050 Ti\'s running at a higher wattage. The graphics card is there to give a boost to creator software like Photoshop and Premier. This laptop is primarily a work laptop. Still gaming will be significantly better than with the onboard Radeon graphics, or a comparable laptop with Intel Xe graphics.  Screen is pretty good for its segment. Sound is ok. Headphones would be advised for better sound.  Keyboard backlight was another issue for me. The white backlight with the gold keys can make it hard to read with the backlight on. I found the keyboard more readable with the backlight off in a lit room. The middle right section of the keyboard was significantly dimmer than the left side and right edge. It made the keyboard even more difficult to read and quite frankly, it drove me nuts. My son\'s laptop didn\'t have the issue.  Acer offered to do a warranty repair for me, but a tech at an authorized Acer repair shop told me to just send it back as I\'d have the situation resolved much more quickly. I ended up exchanging it for a laptop that better meets my needs (IA testing and development). I bought another Acer as I still like the brand. I just needed something a bit beefier and a bit more upgradeable. It\'s a great laptop for my son who has much more \"normal\" computing needs than I do.  Overall, it seems like a solid laptop for the price. It\'s not fancy but should do it\'s primary tasks well (business) with a little extra for entertainment. Compared to other thin and lights I\'ve owned (an Aspire 5 and a Lenovo Ideapad 720S), this outperforms them.  If you go in with reasonable expectations, you should be quite happy with the purchase.',66,37,'2022-01-30 19:30:26'),(80,4,'1',66,22,'2022-02-04 09:39:13'),(105,2,'Seems to lag once in a while',37,14,'2022-02-05 17:12:29'),(106,5,'Amazing quality!',66,58,'2022-02-05 18:43:35'),(107,5,'Excellent Product!',38,58,'2022-02-05 18:44:32'),(109,3,'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',38,14,'2022-02-05 18:58:33'),(111,3,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',38,14,'2022-02-05 18:59:29'),(112,1,'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. ',38,14,'2022-02-05 18:59:51'),(113,5,'nice',68,27,'2022-02-05 20:43:13'),(114,3,'Amazing product',66,35,'2022-02-06 13:24:34'),(115,2,'Bad quality',71,58,'2022-02-07 01:17:08');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact` int NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `profile_pic_url` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'Johnson','johnson@gmail.com',97821333,'abcd8734','Customer','https://i.imgur.com/lus3hWV.jpg','2021-11-27 07:38:41'),(36,'Marry','marry@gmail.com',91234567,'IJd89hi3f3dwa','Customer','https://i.imgur.com/LApAGif_d.webp?maxwidth=1520&fidelity=grand','2021-11-27 13:09:01'),(37,'Garry','garry@hotmail.com',87832144,'poojohd98q3h','Customer','https://i.imgur.com/gcPqyRO.png','2021-11-27 14:59:33'),(38,'Joshua','joshua1273@gmail.com',84637283,'jos123','Customer','https://www.abc.com/jos.jpg','2021-12-03 01:38:36'),(39,'User127','user127@gmail.com',84327894,'d83cnh3e9j903j','Customer','https://www.abc.com/user127.jpg','2021-12-03 09:54:33'),(41,'User1274','user1274@gmail.com',83271893,'dh893chdcwojce','Customer','https://www.abc.com/user1274.jpg','2021-12-03 09:59:19'),(43,'User12745','User12745@gmail.com',84728304,'ndiwdu3ch9di3c','Customer','https://www.abc.com/newuser12745.jpg','2021-12-04 12:32:36'),(45,'Terry Tan','terry@gmail.com',91234567,'abc123456','Customer','https://www.abc.com/terry.jpg','2021-12-04 11:33:51'),(64,'Jerry tan','User12745@gmail.com2',84728304,'ndiwdu3ch9di3c','Customer','https://www.abc.com/newuser12745.jpg','2022-01-07 04:50:15'),(66,'user','user@gmail.com',98765432,'123','Admin','https://www.abc.com/newuser12745.jpg','2022-02-06 06:58:31'),(67,'user1','user1@gmail.com',98765432,'123','Customer','https://i.imgur.com/EzcLTUH.jpg','2022-01-29 18:30:49'),(68,'Yuhong','yuhong@mail.com',81234567,'123','Customer','https://www.abc.com/newuser12745.jpg','2022-02-05 12:42:21'),(71,'Harrison','Harrison@gmail.com',97351626,'123','Customer','http://localhost:3001/login.html','2022-02-06 17:16:33');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userinterest`
--

DROP TABLE IF EXISTS `userinterest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userinterest` (
  `userinterestid` int NOT NULL AUTO_INCREMENT,
  `userid` int NOT NULL,
  `categoryid` int NOT NULL,
  PRIMARY KEY (`userinterestid`),
  UNIQUE KEY `PreventDuplicate` (`userid`,`categoryid`),
  KEY `fk_userid_idx` (`userid`),
  KEY `fk_categoryid_idx` (`categoryid`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_categoryid2` FOREIGN KEY (`categoryid`) REFERENCES `category` (`categoryid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_userid2` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=818 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userinterest`
--

LOCK TABLES `userinterest` WRITE;
/*!40000 ALTER TABLE `userinterest` DISABLE KEYS */;
INSERT INTO `userinterest` VALUES (778,37,10),(779,37,24),(780,37,44),(126,38,4),(128,43,4),(202,45,4),(201,45,10),(640,64,2),(641,64,4),(642,64,10),(643,64,12),(809,66,4),(810,66,12),(811,66,23),(748,67,10),(749,67,12),(813,68,10),(814,68,12),(815,68,24),(816,71,10),(817,71,23);
/*!40000 ALTER TABLE `userinterest` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-07  1:47:50
