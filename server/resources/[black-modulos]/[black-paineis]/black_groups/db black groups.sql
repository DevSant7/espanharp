-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando estrutura para tabela creativev5.bsgroupmanager-announces
CREATE TABLE IF NOT EXISTS `bsgroupmanager-announces` (
  `orgName` varchar(50) NOT NULL,
  `user_id` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(500) NOT NULL,
  `description` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando estrutura para tabela creativev5.bsgroupmanager-blacklist
CREATE TABLE IF NOT EXISTS `bsgroupmanager-blacklist` (
  `user_id` INT(11) PRIMARY KEY,
  `removed_in` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela creativev5.bsgroupmanager-farms
CREATE TABLE IF NOT EXISTS `bsgroupmanager-farms` (
  `orgName` varchar(50) NOT NULL,
  `taskId` text DEFAULT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `item` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `gift` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `users_finished` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela creativev5.bsgroupmanager-logs
CREATE TABLE IF NOT EXISTS `bsgroupmanager-logs` (
  `orgName` varchar(50) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `item` varchar(50) NOT NULL,
  `value` int(11) NOT NULL DEFAULT 0,
  `date` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela creativev5.bsgroupmanager-members
CREATE TABLE IF NOT EXISTS `bsgroupmanager-members` (
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `group` varchar(50) NOT NULL DEFAULT '',
  `orgName` varchar(50) NOT NULL DEFAULT '',
  `image` text NOT NULL,
  `lastLogin` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela creativev5.bsgroupmanager-orgs
CREATE TABLE IF NOT EXISTS `bsgroupmanager-orgs` (
  `orgName` varchar(50) NOT NULL,
  `bank` int(11) NOT NULL,
  `founder` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando estrutura para tabela creativev5.bsgroupmanager-orgs
CREATE TABLE IF NOT EXISTS `bsgroupmanager-chests` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(50),
  `weight` int(11) DEFAULT '0',
  `perm` varchar(50),
  `logs` int(1) DEFAULT '0' ,
  `coords` varchar(150)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando estrutura para tabela creativev5.bsgroupmanager-orgs
CREATE TABLE IF NOT EXISTS `chests` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(50),
  `weight` int(11) DEFAULT '0',
  `perm` varchar(50),
  `logs` int(1) DEFAULT '0' 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando estrutura para tabela creativev5.bsgroupmanager-orgs
CREATE TABLE IF NOT EXISTS `founders_chests` (
  `id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `founder_id` int(11),
  `name` varchar(50),
  `weight` int(11) DEFAULT '0',
  `perm` varchar(50),
  `logs` int(1) DEFAULT '0' 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
