CREATE DATABASE  IF NOT EXISTS `g_et_co_bdtheque` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `g_et_co_bdtheque`;
-- MySQL dump 10.13  Distrib 5.7.15, for Linux (x86_64)
--
-- Host: localhost    Database: g_et_co_bdtheque
-- ------------------------------------------------------
-- Server version	5.7.15-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `gco_etat_livre`
--

DROP TABLE IF EXISTS `gco_etat_livre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gco_etat_livre` (
  `id_etat` int(11) NOT NULL AUTO_INCREMENT,
  `eta_value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_etat`),
  UNIQUE KEY `id_etat_UNIQUE` (`id_etat`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gco_etat_livre`
--

LOCK TABLES `gco_etat_livre` WRITE;
/*!40000 ALTER TABLE `gco_etat_livre` DISABLE KEYS */;
INSERT INTO `gco_etat_livre` VALUES (1,'Abimé'),(2,'Moyen'),(3,'Correct'),(4,'Bon'),(5,'Très bon'),(6,'Neuf');
/*!40000 ALTER TABLE `gco_etat_livre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gco_fournisseurs`
--

DROP TABLE IF EXISTS `gco_fournisseurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gco_fournisseurs` (
  `id_fournisseur` int(11) NOT NULL AUTO_INCREMENT,
  `frn_nom` varchar(45) NOT NULL,
  `frn_contact` varchar(128) NOT NULL,
  `frn_telephone` varchar(20) NOT NULL,
  PRIMARY KEY (`id_fournisseur`),
  UNIQUE KEY `id_fournisseur_UNIQUE` (`id_fournisseur`),
  UNIQUE KEY `frn_nom_UNIQUE` (`frn_nom`),
  FULLTEXT KEY `Search_Fournisseur` (`frn_nom`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gco_fournisseurs`
--

LOCK TABLES `gco_fournisseurs` WRITE;
/*!40000 ALTER TABLE `gco_fournisseurs` DISABLE KEYS */;
INSERT INTO `gco_fournisseurs` VALUES (1,'HACHETTE','Jean-Paul HOCHON','33.25.48.36.75'),(2,'Dupuis','Abby DOCHON','16.28.32.44.16'),(3,'Petit-à-petit','Jessica MEMBERT','28.16.38.44.44'),(4,'SePP','Raoul BRISEFER','44.32.16.48.12'),(5,'Casterman','Etore PISSENLIT','85.25.14.96.12'),(6,'BD Trésors','Anatole FRANCE','45.85.63.21.74'),(7,'Lombard','Amélie POULAIN','25.36.98.01.78'),(8,'Dargaud - Lombard','Alain TERIEUR','87.25.96.12.01'),(9,'Vents d\'Ouest','Eda SOUFLEDAZUR','87.20.21.54.56'),(10,'Dargaud','Alain TERIEUR','87.25.96.12.01'),(11,'Ankana','Alex TERIEUR','60.12.98.23.23'),(12,'Delcourt','John YALIDAYE','82.01.01.98.12'),(13,'Clair de lune','Marc OSSOL','45.65.78.32.25'),(14,'Soleil','Hubert REEVES','14.36.96.74.24'),(15,'Urban Comics','Loise LAINE','95.75.35.15.91');
/*!40000 ALTER TABLE `gco_fournisseurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gco_livres`
--

DROP TABLE IF EXISTS `gco_livres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gco_livres` (
  `id_livre` int(11) NOT NULL AUTO_INCREMENT,
  `liv_reference` varchar(10) NOT NULL COMMENT '= concat(cast(id_livre as char), ''-'', substring(liv_titre,1,3), ''-'', substring(liv_auteur,1,3))\n',
  `liv_titre` varchar(150) NOT NULL,
  `liv_auteur` varchar(45) DEFAULT NULL,
  `liv_photo` varchar(255) DEFAULT NULL,
  `liv_en_stock` int(11) NOT NULL DEFAULT '0',
  `liv_appro` int(11) NOT NULL DEFAULT '0',
  `gco_fournisseur_id_fournisseur` int(11) DEFAULT NULL,
  `gco_etat_livre_id_etat` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_livre`),
  UNIQUE KEY `id_livre_UNIQUE` (`id_livre`),
  KEY `fk_gco_livre_gco_fournisseur_idx` (`gco_fournisseur_id_fournisseur`),
  KEY `fk_gco_livres_gco_etat_livre1_idx` (`gco_etat_livre_id_etat`),
  KEY `idx_stock` (`liv_en_stock`),
  KEY `idx_reappro` (`liv_appro`),
  FULLTEXT KEY `idx_auteur` (`liv_auteur`),
  FULLTEXT KEY `idx_titre` (`liv_titre`),
  FULLTEXT KEY `idx_reference` (`liv_reference`),
  CONSTRAINT `fk_gco_livre_gco_fournisseur` FOREIGN KEY (`gco_fournisseur_id_fournisseur`) REFERENCES `gco_fournisseurs` (`id_fournisseur`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_gco_livres_gco_etat_livre1` FOREIGN KEY (`gco_etat_livre_id_etat`) REFERENCES `gco_etat_livre` (`id_etat`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gco_livres`
--

LOCK TABLES `gco_livres` WRITE;
/*!40000 ALTER TABLE `gco_livres` DISABLE KEYS */;
INSERT INTO `gco_livres` VALUES (1,'0','Nouvelle édition',NULL,'0000NEWNEW.jpg',0,0,NULL,NULL),(2,'0001BLAWAL','Blanche-neigne et les 7 nains','Walt DISNEY','0001BLAWAL.jpg',0,5,0,3),(3,'0002BOUJEA','Boule et Bill - 15','Jean ROBA','0002BOUJEA.jpg',6,0,1,5),(4,'0003JIMOLI','Jimy Hendrix en BD','Oliv et Ben','0003JIMOLI.jpg',1,0,2,4),(5,'0004LABCOL','Torpille - La base secrette','(Collectif)','0004LABCOL.jpg',1,4,3,4),(6,'0005BAUCOL','Poèmes de Baudelaire en Bandes dessinées','(Collectif)','0005BAUCOL.jpg',9,0,2,5),(7,'0006CHAGEL','Le Chat 1999,9999','Philippe GELUCK','0006CHAGEL.jpg',6,0,5,5),(8,'0007PIEFOR','Les Nouvelles Aventures des PIEDS NICKELES','Louis FORTON','0007PIEFOR.jpg',5,0,7,5),(9,'0008SCHPEY','Schtroumpf les Bains','Peyo','0008SCHPEY.jpg',5,0,7,5),(10,'0009SPIROB','Spirou et Fantasio - 55','Rob-Vel','0009SPIROB.jpg',4,0,1,5),(11,'0010ETEPRA','Un été Indien','Pratt-Manara','0010ETEPRA.jpg',0,0,4,5),(12,'ACH0208GRE','Achille Talon - Vive les vacances','Greg','ACH0208GRE.jpg',1,8,7,5),(13,'ACH0416GRE','Achille Talon - L\'age ingrat','Greg','ACH0416GRE.jpg',0,0,7,5),(14,'ACH8874GRE','Achille Talon - Le maître est talon','Grep','ACH8874GRE.jpg',0,5,7,5),(15,'BEM6654SEJ','Blake et Mortimer - Le baton de Plutarque','Sente et Juillard','BEM6654SEJ.jpg',3,10,7,5),(16,'BEM6685SEJ','Blake et Mortimer - L\'affaire Francis Blake','Sente et Juillard','BEM6685SEJ.jpg',0,0,7,5),(17,'BEM6602SEJ','Blake et Mortimer - La machination Voronov','Sente et Juillard','BEM6602SEJ.jpg',1,0,7,4),(18,'LEO7798DGT','Léonard - Génie civil','De Groot et Turk','LEO7798DGT.jpg',2,0,7,5),(19,'LEO7702DGT','Leonard - Ciel mon génie !','De Groot et Turk','LEO7702DGT.jpg',8,0,7,5),(20,'LEO7714DGT','Leonard - Y a du Genie dans l\'air','De Groot et Turk','LEO7714DGT.jpg',0,7,7,5),(21,'LEO7785DGT','Léonard - Tour de génie','De Groot et Turk','LEO7785DGT.jpg',1,0,7,5),(22,'AZI5582JAL','Azimut','Jean-Baptiste Andreae - Lupano','AZI5582JAL.jpg',1,0,8,4),(23,'MAS6598LEO','Les mondes d\'Aldebaran Survivants : anomalies quantiques','Léo','MAS6598LEO.jpg',3,1,9,5),(24,'TER8521SJP','Terminus 1','Serge Le Tendre - Jean-Michel Ponzio','TER8521SJP.jpg',0,0,10,5),(25,'CEN7463ZJL','Centaurus','Zoran Janjetov - Léo','CEN7463ZJL.jpg',1,0,11,5),(26,'SGA8533JMO','Space gangsters - 1 Palais aquatique','Julien MOTTELER','SGA8533JMO.jpg',2,0,12,5);
/*!40000 ALTER TABLE `gco_livres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gco_utilisateurs`
--

DROP TABLE IF EXISTS `gco_utilisateurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gco_utilisateurs` (
  `utl_nom` varchar(45) NOT NULL,
  `utl_login` varchar(45) NOT NULL COMMENT 'ATTENTION : contient le MD5 du password !!!',
  PRIMARY KEY (`utl_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gco_utilisateurs`
--

LOCK TABLES `gco_utilisateurs` WRITE;
/*!40000 ALTER TABLE `gco_utilisateurs` DISABLE KEYS */;
INSERT INTO `gco_utilisateurs` VALUES ('Charles','g&co1'),('Jean-romain','marvel'),('Henri','tintin');
/*!40000 ALTER TABLE `gco_utilisateurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_bibliotheque`
--

DROP TABLE IF EXISTS `view_bibliotheque`;
/*!50001 DROP VIEW IF EXISTS `view_bibliotheque`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_bibliotheque` AS SELECT 
 1 AS `id`,
 1 AS `value`,
 1 AS `Référence`,
 1 AS `Auteur`,
 1 AS `liv_photo`,
 1 AS `Stock`,
 1 AS `Réassort`,
 1 AS `is_occas`,
 1 AS `frn_nom`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_reassort`
--

DROP TABLE IF EXISTS `view_reassort`;
/*!50001 DROP VIEW IF EXISTS `view_reassort`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_reassort` AS SELECT 
 1 AS `id`,
 1 AS `value`,
 1 AS `Auteur`,
 1 AS `Référence`,
 1 AS `liv_photo`,
 1 AS `Stock`,
 1 AS `Réassort`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_rupture`
--

DROP TABLE IF EXISTS `view_rupture`;
/*!50001 DROP VIEW IF EXISTS `view_rupture`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_rupture` AS SELECT 
 1 AS `id`,
 1 AS `value`,
 1 AS `Auteur`,
 1 AS `Référence`,
 1 AS `liv_photo`,
 1 AS `Stock`,
 1 AS `Réassort`,
 1 AS `Editeur`,
 1 AS `Contact`,
 1 AS `Téléphone`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'g_et_co_bdtheque'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_fournisseur` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `add_fournisseur`(in nom varchar(45), in phone varchar(20), in ctx varchar(128))
begin
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION begin select "erreur"; end;
	insert into gco_fournisseur(frn_nom, frn_telephone, frn_contact) values (nom,phone,ctx);
    select "ok";
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `book_manage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `book_manage`()
BEGIN

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_stock`(in state boolean)
BEGIN
	if state = false then
		select * from vue_rupture;
	else
		select * from vue_bibliotheque;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_by_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_user_by_login`(in login varchar(45))
BEGIN
	SELECT if(isnull(utl_nom), '', utl_nom) as utl_nom FROM gco_utilisateur WHERE utl_login = @login;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_bibliotheque`
--

/*!50001 DROP VIEW IF EXISTS `view_bibliotheque`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_bibliotheque` AS select `gco_livres`.`id_livre` AS `id`,`gco_livres`.`liv_titre` AS `value`,`gco_livres`.`liv_reference` AS `Référence`,`gco_livres`.`liv_auteur` AS `Auteur`,`gco_livres`.`liv_photo` AS `liv_photo`,`gco_livres`.`liv_en_stock` AS `Stock`,`gco_livres`.`liv_appro` AS `Réassort`,if((`gco_etat_livre`.`eta_value` = 'neuf'),FALSE,TRUE) AS `is_occas`,`gco_fournisseurs`.`frn_nom` AS `frn_nom` from ((`gco_livres` join `gco_fournisseurs` on((`gco_livres`.`gco_fournisseur_id_fournisseur` = `gco_fournisseurs`.`id_fournisseur`))) join `gco_etat_livre` on((`gco_livres`.`gco_etat_livre_id_etat` = `gco_etat_livre`.`id_etat`))) order by `gco_livres`.`liv_titre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_reassort`
--

/*!50001 DROP VIEW IF EXISTS `view_reassort`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_reassort` AS select `gco_livres`.`id_livre` AS `id`,`gco_livres`.`liv_titre` AS `value`,`gco_livres`.`liv_auteur` AS `Auteur`,`gco_livres`.`liv_reference` AS `Référence`,`gco_livres`.`liv_photo` AS `liv_photo`,`gco_livres`.`liv_en_stock` AS `Stock`,`gco_livres`.`liv_appro` AS `Réassort` from `gco_livres` where (`gco_livres`.`liv_appro` > 0) order by `gco_livres`.`liv_titre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_rupture`
--

/*!50001 DROP VIEW IF EXISTS `view_rupture`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_rupture` AS select `gco_livres`.`id_livre` AS `id`,`gco_livres`.`liv_titre` AS `value`,`gco_livres`.`liv_auteur` AS `Auteur`,`gco_livres`.`liv_reference` AS `Référence`,`gco_livres`.`liv_photo` AS `liv_photo`,0 AS `Stock`,0 AS `Réassort`,`gco_fournisseurs`.`frn_nom` AS `Editeur`,`gco_fournisseurs`.`frn_contact` AS `Contact`,`gco_fournisseurs`.`frn_telephone` AS `Téléphone` from (`gco_livres` join `gco_fournisseurs` on((`gco_livres`.`gco_fournisseur_id_fournisseur` = `gco_fournisseurs`.`id_fournisseur`))) where ((`gco_livres`.`liv_en_stock` = 0) and (`gco_livres`.`liv_appro` = 0)) order by `gco_fournisseurs`.`frn_nom`,`gco_livres`.`liv_titre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-12 12:13:22
