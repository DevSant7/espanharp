-- Tabela para armazenar os avisos do DIP
CREATE TABLE IF NOT EXISTS `ftdip_warns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `author_id` int(11) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `created_at` date NOT NULL DEFAULT (CURRENT_DATE),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela para armazenar o histórico dos jogadores
CREATE TABLE IF NOT EXISTS `ftdip_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'Multa',
  `description` text NOT NULL,
  `amount` decimal(10,2) DEFAULT 0.00,
  `months` int(11) DEFAULT 0,
  `officer_id` int(11) NOT NULL,
  `officer_name` varchar(255) NOT NULL,
  `created_at` date NOT NULL DEFAULT (CURRENT_DATE),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `officer_id` (`officer_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela para armazenar B.O.s (Boletins de Ocorrência)
CREATE TABLE IF NOT EXISTS `ftdip_bo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `occurrence_number` varchar(50) NOT NULL,
  `type` varchar(100) NOT NULL DEFAULT 'Boletim de Ocorrência',
  `description` text NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `applicant_name` varchar(255) DEFAULT NULL,
  `suspect_id` int(11) DEFAULT NULL,
  `suspect_name` varchar(255) DEFAULT NULL,
  `officer_id` int(11) NOT NULL,
  `officer_name` varchar(255) NOT NULL,
  `status` enum('Aberto','Em Andamento','Resolvido','Arquivado') NOT NULL DEFAULT 'Aberto',
  `created_at` date NOT NULL DEFAULT (CURRENT_DATE),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `officer_id` (`officer_id`),
  KEY `applicant_id` (`applicant_id`),
  KEY `suspect_id` (`suspect_id`),
  KEY `created_at` (`created_at`),
  KEY `status` (`status`),
  UNIQUE KEY `occurrence_number` (`occurrence_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela para armazenar membros da corporação
CREATE TABLE IF NOT EXISTS `ftdip_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `charge` varchar(100) NOT NULL DEFAULT 'Agente',
  `rank` int(11) NOT NULL DEFAULT 1,
  `join_date` date NOT NULL DEFAULT (CURRENT_DATE),
  `status` enum('Ativo','Inativo','Suspenso') NOT NULL DEFAULT 'Ativo',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `rank` (`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela para armazenar estatísticas simplificadas
CREATE TABLE IF NOT EXISTS `ftdip_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `type` varchar(50) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_type` (`date`, `type`),
  KEY `date` (`date`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela para armazenar multas aplicadas
CREATE TABLE IF NOT EXISTS `ftdip_fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `fine_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `officer_name` varchar(255) NOT NULL,
  `status` enum('Pendente','Paga','Vencida') NOT NULL DEFAULT 'Pendente',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paid_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `officer_id` (`officer_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===== TABELAS PARA SISTEMA DE PROCURADOS =====

-- Tabela para armazenar pessoas procuradas
CREATE TABLE IF NOT EXISTS `ftdip_wanted_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `last_seen` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `photo` varchar(500) DEFAULT NULL,
  `officer_id` int(11) NOT NULL,
  `status` enum('Ativo','Inativo','Capturado') NOT NULL DEFAULT 'Ativo',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `officer_id` (`officer_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela para armazenar veículos procurados
CREATE TABLE IF NOT EXISTS `ftdip_wanted_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(255) NOT NULL,
  `specifications` text NOT NULL,
  `last_seen` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `status` enum('Ativo','Inativo','Recuperado') NOT NULL DEFAULT 'Ativo',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `officer_id` (`officer_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela para estatísticas dos oficiais
CREATE TABLE IF NOT EXISTS `ftdip_officer_stats` (
  `user_id` int(11) NOT NULL,
  `arrests_made` int(11) DEFAULT 0,
  `fines_applied` int(11) DEFAULT 0,
  `total_fines_value` decimal(10,2) DEFAULT 0.00,
  `total_working_hours` int(11) DEFAULT 0,
  `vehicles_seized` int(11) DEFAULT 0,
  `reports_registered` int(11) DEFAULT 0,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)

);

