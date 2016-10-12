-- MySQL Script generated by MySQL Workbench
-- 10/11/16 21:22:51
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema g_et_co_bdtheque
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `g_et_co_bdtheque` ;

-- -----------------------------------------------------
-- Schema g_et_co_bdtheque
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `g_et_co_bdtheque` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `g_et_co_bdtheque` ;

-- -----------------------------------------------------
-- Table `g_et_co_bdtheque`.`gco_fournisseurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `g_et_co_bdtheque`.`gco_fournisseurs` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `g_et_co_bdtheque`.`gco_fournisseurs` (
  `id_fournisseur` INT NOT NULL AUTO_INCREMENT,
  `frn_nom` VARCHAR(45) NOT NULL,
  `frn_contact` VARCHAR(128) NOT NULL,
  `frn_telephone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_fournisseur`),
  UNIQUE INDEX `id_fournisseur_UNIQUE` (`id_fournisseur` ASC),
  FULLTEXT INDEX `Search_Fournisseur` (`frn_nom` ASC),
  UNIQUE INDEX `frn_nom_UNIQUE` (`frn_nom` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `g_et_co_bdtheque`.`gco_etat_livre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `g_et_co_bdtheque`.`gco_etat_livre` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `g_et_co_bdtheque`.`gco_etat_livre` (
  `id_etat` INT NOT NULL AUTO_INCREMENT,
  `eta_value` VARCHAR(45) NULL,
  PRIMARY KEY (`id_etat`),
  UNIQUE INDEX `id_etat_UNIQUE` (`id_etat` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `g_et_co_bdtheque`.`gco_livres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `g_et_co_bdtheque`.`gco_livres` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `g_et_co_bdtheque`.`gco_livres` (
  `id_livre` INT NOT NULL AUTO_INCREMENT,
  `liv_reference` VARCHAR(10) NOT NULL COMMENT '= concat(cast(id_livre as char), \'-\', substring(liv_titre,1,3), \'-\', substring(liv_auteur,1,3))\n',
  `liv_titre` VARCHAR(150) NOT NULL,
  `liv_auteur` VARCHAR(45) NULL,
  `liv_photo` VARCHAR(255) NULL,
  `liv_en_stock` INT NOT NULL DEFAULT 0,
  `liv_appro` INT NOT NULL DEFAULT 0,
  `gco_fournisseur_id_fournisseur` INT NULL,
  `gco_etat_livre_id_etat` INT NULL,
  PRIMARY KEY (`id_livre`),
  INDEX `fk_gco_livre_gco_fournisseur_idx` (`gco_fournisseur_id_fournisseur` ASC),
  FULLTEXT INDEX `idx_auteur` (`liv_auteur` ASC),
  FULLTEXT INDEX `idx_titre` (`liv_titre` ASC),
  INDEX `fk_gco_livres_gco_etat_livre1_idx` (`gco_etat_livre_id_etat` ASC),
  INDEX `idx_stock` (`liv_en_stock` ASC),
  FULLTEXT INDEX `idx_reference` (`liv_reference` ASC),
  INDEX `idx_reappro` (`liv_appro` ASC),
  UNIQUE INDEX `id_livre_UNIQUE` (`id_livre` ASC),
  CONSTRAINT `fk_gco_livre_gco_fournisseur`
    FOREIGN KEY (`gco_fournisseur_id_fournisseur`)
    REFERENCES `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gco_livres_gco_etat_livre1`
    FOREIGN KEY (`gco_etat_livre_id_etat`)
    REFERENCES `g_et_co_bdtheque`.`gco_etat_livre` (`id_etat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `g_et_co_bdtheque`.`gco_utilisateurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `g_et_co_bdtheque`.`gco_utilisateurs` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `g_et_co_bdtheque`.`gco_utilisateurs` (
  `utl_nom` VARCHAR(45) NOT NULL,
  `utl_login` VARCHAR(45) NOT NULL COMMENT 'ATTENTION : contient le MD5 du password !!!',
  PRIMARY KEY (`utl_login`))
ENGINE = InnoDB;

SHOW WARNINGS;
USE `g_et_co_bdtheque` ;

-- -----------------------------------------------------
-- Placeholder table for view `g_et_co_bdtheque`.`view_rupture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `g_et_co_bdtheque`.`view_rupture` (`id` INT, `'value'` INT, `'Auteur'` INT, `'Référence'` INT, `liv_photo` INT, `'Stock'` INT, `'Réassort'` INT, `'Editeur'` INT, `'Contact'` INT, `'Téléphone'` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `g_et_co_bdtheque`.`view_bibliotheque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `g_et_co_bdtheque`.`view_bibliotheque` (`id` INT, `'value'` INT, `'Référence'` INT, `'Auteur'` INT, `liv_photo` INT, `'Stock'` INT, `'Réassort'` INT, `is_occas` INT, `frn_nom` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `g_et_co_bdtheque`.`view_reassort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `g_et_co_bdtheque`.`view_reassort` (`id` INT, `'value'` INT, `'Auteur'` INT, `'Référence'` INT, `liv_photo` INT, `'Stock'` INT, `'Réassort'` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure add_fournisseur
-- -----------------------------------------------------

USE `g_et_co_bdtheque`;
DROP procedure IF EXISTS `g_et_co_bdtheque`.`add_fournisseur`;
SHOW WARNINGS;

DELIMITER $$
USE `g_et_co_bdtheque`$$
create procedure add_fournisseur(in nom varchar(45), in phone varchar(20), in ctx varchar(128))
begin
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION begin select "erreur"; end;
	insert into gco_fournisseur(frn_nom, frn_telephone, frn_contact) values (nom,phone,ctx);
    select "ok";
end;$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure get_user_by_login
-- -----------------------------------------------------

USE `g_et_co_bdtheque`;
DROP procedure IF EXISTS `g_et_co_bdtheque`.`get_user_by_login`;
SHOW WARNINGS;

DELIMITER $$
USE `g_et_co_bdtheque`$$
CREATE PROCEDURE `get_user_by_login` (in login varchar(45))
BEGIN
	SELECT if(isnull(utl_nom), '', utl_nom) as utl_nom FROM gco_utilisateur WHERE utl_login = @login;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure get_stock
-- -----------------------------------------------------

USE `g_et_co_bdtheque`;
DROP procedure IF EXISTS `g_et_co_bdtheque`.`get_stock`;
SHOW WARNINGS;

DELIMITER $$
USE `g_et_co_bdtheque`$$
CREATE PROCEDURE `get_stock` (in state boolean)
BEGIN
	if state = false then
		select * from vue_rupture;
	else
		select * from vue_bibliotheque;
	end if;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure book_manage
-- -----------------------------------------------------

USE `g_et_co_bdtheque`;
DROP procedure IF EXISTS `g_et_co_bdtheque`.`book_manage`;
SHOW WARNINGS;

DELIMITER $$
USE `g_et_co_bdtheque`$$
/*
Opérations possibles :
	- "add" : ajout un livre inexistant
    - "mor" : rajoute des livres existants
    - "sel" : vend un livre
    - "frn" : coordonnées du fournisseur
    - "pho" : vue photos
*/
CREATE PROCEDURE `book_manage` ()
BEGIN

END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `g_et_co_bdtheque`.`view_rupture`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `g_et_co_bdtheque`.`view_rupture` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `g_et_co_bdtheque`.`view_rupture`;
SHOW WARNINGS;
USE `g_et_co_bdtheque`;
CREATE  OR REPLACE VIEW `view_rupture` AS
    SELECT 
        id_livre AS id,
        liv_titre AS 'value',
        liv_auteur AS 'Auteur',
        liv_reference AS 'Référence',
        liv_photo,
        0 AS 'Stock',
        0 AS 'Réassort',
        frn_nom AS 'Editeur',
        frn_contact AS 'Contact',
        frn_telephone AS 'Téléphone'
    FROM
        gco_livres
            INNER JOIN
        gco_fournisseurs ON gco_fournisseur_id_fournisseur = id_fournisseur
    WHERE
        (liv_en_stock = 0) AND (liv_appro = 0)
    ORDER BY frn_nom , liv_titre;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `g_et_co_bdtheque`.`view_bibliotheque`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `g_et_co_bdtheque`.`view_bibliotheque` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `g_et_co_bdtheque`.`view_bibliotheque`;
SHOW WARNINGS;
USE `g_et_co_bdtheque`;
CREATE  OR REPLACE VIEW `view_bibliotheque` AS
    SELECT 
        id_livre AS id,
        liv_titre AS 'value',
        liv_reference AS 'Référence',
        liv_auteur AS 'Auteur',
        liv_photo,
        liv_en_stock AS 'Stock',
        liv_appro AS 'Réassort',
        IF(eta_value = 'neuf', FALSE, TRUE) AS is_occas,
        frn_nom
    FROM
        gco_livres
            INNER JOIN
        gco_fournisseurs ON gco_fournisseur_id_fournisseur = id_fournisseur
            INNER JOIN
        gco_etat_livre ON gco_etat_livre_id_etat = id_etat
    ORDER BY liv_titre ASC;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `g_et_co_bdtheque`.`view_reassort`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `g_et_co_bdtheque`.`view_reassort` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `g_et_co_bdtheque`.`view_reassort`;
SHOW WARNINGS;
USE `g_et_co_bdtheque`;
CREATE  OR REPLACE VIEW `view_reassort` AS
    SELECT 
        id_livre AS id,
        liv_titre AS 'value',
        liv_auteur AS 'Auteur',
        liv_reference AS 'Référence',
        liv_photo,
        liv_en_stock AS 'Stock',
        liv_appro AS 'Réassort'
    FROM
        gco_livres
    WHERE
        liv_appro > 0
    ORDER BY liv_titre;
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `g_et_co_bdtheque`.`gco_fournisseurs`
-- -----------------------------------------------------
START TRANSACTION;
USE `g_et_co_bdtheque`;
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'HACHETTE', 'Jean-Paul HOCHON', '33.25.48.36.75');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Dupuis', 'Abby DOCHON', '16.28.32.44.16');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Petit-à-petit', 'Jessica MEMBERT', '28.16.38.44.44');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'SePP', 'Raoul BRISEFER', '44.32.16.48.12');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Casterman', 'Etore PISSENLIT', '85.25.14.96.12');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'BD Trésors', 'Anatole FRANCE', '45.85.63.21.74');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Lombard', 'Amélie POULAIN', '25.36.98.01.78');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Dargaud - Lombard', 'Alain TERIEUR', '87.25.96.12.01');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Vents d\'Ouest', 'Eda SOUFLEDAZUR', '87.20.21.54.56');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Dargaud', 'Alain TERIEUR', '87.25.96.12.01');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Ankana', 'Alex TERIEUR', '60.12.98.23.23');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Delcourt', 'John YALIDAYE', '82.01.01.98.12');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Clair de lune', 'Marc OSSOL', '45.65.78.32.25');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Soleil', 'Hubert REEVES', '14.36.96.74.24');
INSERT INTO `g_et_co_bdtheque`.`gco_fournisseurs` (`id_fournisseur`, `frn_nom`, `frn_contact`, `frn_telephone`) VALUES (DEFAULT, 'Urban Comics', 'Loise LAINE', '95.75.35.15.91');

COMMIT;


-- -----------------------------------------------------
-- Data for table `g_et_co_bdtheque`.`gco_etat_livre`
-- -----------------------------------------------------
START TRANSACTION;
USE `g_et_co_bdtheque`;
INSERT INTO `g_et_co_bdtheque`.`gco_etat_livre` (`id_etat`, `eta_value`) VALUES (DEFAULT, 'Abimé');
INSERT INTO `g_et_co_bdtheque`.`gco_etat_livre` (`id_etat`, `eta_value`) VALUES (DEFAULT, 'Moyen');
INSERT INTO `g_et_co_bdtheque`.`gco_etat_livre` (`id_etat`, `eta_value`) VALUES (DEFAULT, 'Correct');
INSERT INTO `g_et_co_bdtheque`.`gco_etat_livre` (`id_etat`, `eta_value`) VALUES (DEFAULT, 'Bon');
INSERT INTO `g_et_co_bdtheque`.`gco_etat_livre` (`id_etat`, `eta_value`) VALUES (DEFAULT, 'Très bon');
INSERT INTO `g_et_co_bdtheque`.`gco_etat_livre` (`id_etat`, `eta_value`) VALUES (DEFAULT, 'Neuf');

COMMIT;


-- -----------------------------------------------------
-- Data for table `g_et_co_bdtheque`.`gco_livres`
-- -----------------------------------------------------
START TRANSACTION;
USE `g_et_co_bdtheque`;
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0', 'Nouvelle édition', NULL, '0000NEWNEW.jpg', DEFAULT, DEFAULT, NULL, NULL);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0001BLAWAL', 'Blanche-neigne et les 7 nains', 'Walt DISNEY', '0001BLAWAL.jpg', 0, 5, 0, 3);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0002BOUJEA', 'Boule et Bill - 15', 'Jean ROBA', '0002BOUJEA.jpg', 6, 0, 1, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0003JIMOLI', 'Jimy Hendrix en BD', 'Oliv et Ben', '0003JIMOLI.jpg', 1, 0, 2, 4);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0004LABCOL', 'Torpille - La base secrette', '(Collectif)', '0004LABCOL.jpg', 1, 4, 3, 4);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0005BAUCOL', 'Poèmes de Baudelaire en Bandes dessinées', '(Collectif)', '0005BAUCOL.jpg', 9, 0, 2, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0006CHAGEL', 'Le Chat 1999,9999', 'Philippe GELUCK', '0006CHAGEL.jpg', 6, 0, 5, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0007PIEFOR', 'Les Nouvelles Aventures des PIEDS NICKELES', 'Louis FORTON', '0007PIEFOR.jpg', 5, 0, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0008SCHPEY', 'Schtroumpf les Bains', 'Peyo', '0008SCHPEY.jpg', 5, 0, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0009SPIROB', 'Spirou et Fantasio - 55', 'Rob-Vel', '0009SPIROB.jpg', 4, 0, 1, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, '0010ETEPRA', 'Un été Indien', 'Pratt-Manara', '0010ETEPRA.jpg', 0, 0, 4, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'ACH0208GRE', 'Achille Talon - Vive les vacances', 'Greg', 'ACH0208GRE.jpg', 1, 8, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'ACH0416GRE', 'Achille Talon - L\'age ingrat', 'Greg', 'ACH0416GRE.jpg', 0, 0, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'ACH8874GRE', 'Achille Talon - Le maître est talon', 'Grep', 'ACH8874GRE.jpg', 0, 5, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'BEM6654SEJ', 'Blake et Mortimer - Le baton de Plutarque', 'Sente et Juillard', 'BEM6654SEJ.jpg', 3, 10, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'BEM6685SEJ', 'Blake et Mortimer - L\'affaire Francis Blake', 'Sente et Juillard', 'BEM6685SEJ.jpg', 0, 0, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'BEM6602SEJ', 'Blake et Mortimer - La machination Voronov', 'Sente et Juillard', 'BEM6602SEJ.jpg', 1, 0, 7, 4);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'LEO7798DGT', 'Léonard - Génie civil', 'De Groot et Turk', 'LEO7798DGT.jpg', 2, 0, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'LEO7702DGT', 'Leonard - Ciel mon génie !', 'De Groot et Turk', 'LEO7702DGT.jpg', 8, 0, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'LEO7714DGT', 'Leonard - Y a du Genie dans l\'air', 'De Groot et Turk', 'LEO7714DGT.jpg', 0, 7, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'LEO7785DGT', 'Léonard - Tour de génie', 'De Groot et Turk', 'LEO7785DGT.jpg', 1, 0, 7, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'AZI5582JAL', 'Azimut', 'Jean-Baptiste Andreae - Lupano', 'AZI5582JAL.jpg', 1, 0, 8, 4);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'MAS6598LEO', 'Les mondes d\'Aldebaran Survivants : anomalies quantiques', 'Léo', 'MAS6598LEO.jpg', 3, 1, 9, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'TER8521SJP', 'Terminus 1', 'Serge Le Tendre - Jean-Michel Ponzio', 'TER8521SJP.jpg', 0, 0, 10, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'CEN7463ZJL', 'Centaurus', 'Zoran Janjetov - Léo', 'CEN7463ZJL.jpg', 1, 0, 11, 5);
INSERT INTO `g_et_co_bdtheque`.`gco_livres` (`id_livre`, `liv_reference`, `liv_titre`, `liv_auteur`, `liv_photo`, `liv_en_stock`, `liv_appro`, `gco_fournisseur_id_fournisseur`, `gco_etat_livre_id_etat`) VALUES (DEFAULT, 'SGA8533JMO', 'Space gangsters - 1 Palais aquatique', 'Julien MOTTELER', 'SGA8533JMO.jpg', 2, 0, 12, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `g_et_co_bdtheque`.`gco_utilisateurs`
-- -----------------------------------------------------
START TRANSACTION;
USE `g_et_co_bdtheque`;
INSERT INTO `g_et_co_bdtheque`.`gco_utilisateurs` (`utl_nom`, `utl_login`) VALUES ('Charles', 'g&co1');
INSERT INTO `g_et_co_bdtheque`.`gco_utilisateurs` (`utl_nom`, `utl_login`) VALUES ('Henri', 'tintin');
INSERT INTO `g_et_co_bdtheque`.`gco_utilisateurs` (`utl_nom`, `utl_login`) VALUES ('Jean-romain', 'marvel');

COMMIT;

