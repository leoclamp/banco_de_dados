-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA if exists `mydb`;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Steam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Steam` (
  `idPlataforrma` INT NOT NULL,
  `QtdDeJogos` INT NOT NULL,
  PRIMARY KEY (`idPlataforrma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jogo` (
  `idJogo` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Preço` DOUBLE NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Steam_idPlataforrma` INT NOT NULL,
   `Pagamento` DOUBLE NOT NULL,
  PRIMARY KEY (`idJogo`),
  CONSTRAINT `fk_Jogo_Steam`
    FOREIGN KEY (`Steam_idPlataforrma`)
    REFERENCES `mydb`.`Steam` (`idPlataforrma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jogadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jogadores` (
  `idJogadores` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Idade` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idJogadores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Personagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Personagem` (
  `idPersonagem` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Classe` VARCHAR(45) NOT NULL,
  `Vida` DOUBLE NOT NULL,
  `Arma` VARCHAR(45) NOT NULL,
  `Jogadores_idJogadores` INT NOT NULL,
  PRIMARY KEY (`idPersonagem`),
  CONSTRAINT `fk_Personagem_Jogadores1`
    FOREIGN KEY (`Jogadores_idJogadores`)
    REFERENCES `mydb`.`Jogadores` (`idJogadores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jogadores_has_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jogadores_has_Jogo` (
  `Jogadores_idJogadores` INT NOT NULL,
  `Jogo_idJogo` INT NOT NULL,
  PRIMARY KEY (`Jogadores_idJogadores`, `Jogo_idJogo`),
  CONSTRAINT `fk_Jogadores_has_Jogo_Jogadores1`
    FOREIGN KEY (`Jogadores_idJogadores`)
    REFERENCES `mydb`.`Jogadores` (`idJogadores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogadores_has_Jogo_Jogo1`
    FOREIGN KEY (`Jogo_idJogo`)
    REFERENCES `mydb`.`Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `Steam`(`idPlataforrma`, `QtdDeJogos`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

select * from `Steam`;

#Inserindo os dados dos jogos
INSERT INTO `Jogo` values(1, 'League of Legends', 0, 'Moba',1, 0);
INSERT INTO `Jogo` values(2, 'counter strike', 49.50, 'FPS', 2, 50.00);
INSERT INTO `Jogo` values(3, 'Dont Starve', 45.50, 'survival',3, 50.00);
INSERT INTO `Jogo` values(4, 'dota', 198.90, 'Moba', 4, 200.00);

select * from Jogo;

#Inserindo os dados dos jogadores
INSERT INTO `Jogadores` values(1,'Leonardo', 34, 'leozimgameplays@gmail.com');
INSERT INTO `Jogadores` values(2,'Raissa', 20, 'Raissinhaplays@gmail.com');
INSERT INTO `Jogadores` values(3,'Paulo', 21, 'gameplaytryhard@gmail.com');

select * from `Jogadores`;

#Inserindo os dados dos Personagens
INSERT INTO `Personagem` values(1,'Jorge', 'Arqueiro' , 100, 'Arco', 1);
INSERT INTO `Personagem` values(2,'Darius', 'Guerreiro' , 15.5, 'Machado', 2);
INSERT INTO `Personagem` values(3,'Maria', 'Maga' , 50, 'Cajado', 3);
INSERT INTO `Personagem` values(4,'bandit', 'agente' , 80, 'pistola', 4);

select * from `Personagem`;

#pesquisa o nome e arma dos jogadores de FPS
CREATE VIEW fps AS (SELECT p.nome, p.arma from Personagem as p , Jogo as j where j.idJogo = p.idPersonagem and j.tipo like 'FPS');
SELECT * FROM fps;


#CRIANDO A FUNCTION
  DELIMITER $$
  DROP FUNCTION IF EXISTS calcula_troco $$
  CREATE FUNCTION calcula_troco(preco float, pagamen float) RETURNS float
  DETERMINISTIC
  
  
  BEGIN
  
   DECLARE troco float;
   set troco = (pagamen - preco);
   RETURN troco;
   
   END $$
  DELIMITER ;
  
#CHAMANDO A FUNCTION
SELECT nome, preço, pagamento, calcula_troco(preço, pagamento) AS 'Troco'
FROM jogo;

#Atualizar os dados
#UPDATE
UPDATE Jogo SET nome = 'RB', Tipo = 'FPS' WHERE idJogo = 4;
SELECT * FROM Jogo;

#DELETANDO
#DELETE
DELETE FROM Jogo WHERE idJogo = 3;
SELECT * FROM Jogo;

#Selecionando o maior valor
SELECT max(Preço) FROM Jogo;

#Selecionando o menor valor
SELECT min(Preço) FROM Jogo;

#Selecionando a média dos valores
SELECT avg(Preço) FROM Jogo;

#Criando um usuario 
create user 'Leonardo' identified by '123456';

#Dando privilegio para o usuario
Grant all privileges on Jogo.* to 'Leonardo';