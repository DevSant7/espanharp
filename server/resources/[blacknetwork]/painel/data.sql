CREATE TABLE IF NOT EXISTS `panel` (
    `passport` INT(11) NOT NULL,
    `group` VARCHAR(50) COLLATE 'utf8mb4_general_ci' DEFAULT NULL,
    `hierarchy` VARCHAR(50) COLLATE 'utf8mb4_general_ci' DEFAULT NULL,
    PRIMARY KEY (`passport`)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
