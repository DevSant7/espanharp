CREATE TABLE IF NOT EXISTS `bank_transactions` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `value` DECIMAL(15,2) NOT NULL,
    `type` VARCHAR(50) NOT NULL,
    `account_type` ENUM('personal', 'joint') DEFAULT 'personal',
    `joint_account_id` INT NULL,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `user_id_index` (`user_id`),
    INDEX `joint_account_id_index` (`joint_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela para histórico de saldo (pessoais e conjuntas)
CREATE TABLE IF NOT EXISTS `bank_balance_history` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `balance` DECIMAL(15,2) NOT NULL,
    `period_value` VARCHAR(20) NOT NULL,
    `period_type` ENUM('weekly', 'monthly') NOT NULL,
    `account_type` ENUM('personal', 'joint') DEFAULT 'personal',
    `joint_account_id` INT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_user_period` (`user_id`, `period_type`, `period_value`, `account_type`, `joint_account_id`),
    INDEX `idx_period_lookup` (`period_type`, `period_value`),
    UNIQUE KEY `unique_user_period` (`user_id`, `period_value`, `period_type`, `account_type`, `joint_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela para informações do perfil bancário
CREATE TABLE IF NOT EXISTS `bank_accounts` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `profile_photo` VARCHAR(500) DEFAULT NULL,
    `full_name` VARCHAR(255) NOT NULL,
    `nickname` VARCHAR(255) NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `gender` ENUM('masculino', 'feminino') NOT NULL DEFAULT 'masculino',
    `transfer_key_type` ENUM('usuario', 'passaporte', 'registro') NOT NULL DEFAULT 'usuario',
    `security_pin` VARCHAR(4) DEFAULT '0000',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `user_id_index` (`user_id`),
    UNIQUE KEY `unique_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela unificada para contas em sociedade (mais simples e performática)
CREATE TABLE IF NOT EXISTS `bank_joint_accounts` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `account_name` VARCHAR(255) NOT NULL,
    `account_type` ENUM('casal', 'familia', 'empresarial', 'conjunto') NOT NULL,
    `balance` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    `members` TEXT NOT NULL,
    `created_by` INT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `created_by_index` (`created_by`),
    INDEX `account_type_index` (`account_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Tabela de faturas/multas (invoices/fines)
CREATE TABLE IF NOT EXISTS `bank_invoices` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `issuer_id` INT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `amount` DECIMAL(15,2) NOT NULL,
    `status` ENUM('pending','paid','cancelled') DEFAULT 'pending',
    `due_date` DATETIME NULL,
    `paid_at` DATETIME NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_user_status` (`user_id`, `status`),
    INDEX `idx_due_date` (`due_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


