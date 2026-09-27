Config.functions["PrepareConsult"]("bs_bank/transations", [[

    CREATE TABLE IF NOT EXISTS `bs_transations` (
	`id` INT NULL AUTO_INCREMENT PRIMARY KEY,
	`reason` VARCHAR(50) NULL DEFAULT NULL,
	`hours` INT NULL DEFAULT NULL,
	`typeReason` VARCHAR(50) NULL DEFAULT NULL,
	`value` INT NULL DEFAULT NULL,
	`user_id` INT NULL DEFAULT NULL
)
]])

Config.functions["PrepareConsult"]("bs_bank/transations/insert", "INSERT INTO bs_transations (reason, hours, typeReason, value, user_id) VALUES (@reason, @hours, @typeReason, @value, @user_id)")
Config.functions["PrepareConsult"]("bs_bank/transations/select", "SELECT * FROM bs_transations WHERE  user_id=@user_id")
Config.functions["PrepareConsult"]("bs_bank/transations/delete", "DELETE FROM bs_transations WHERE  user_id=@auser_id")
