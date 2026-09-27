Config.functions["PrepareConsult"]("bs_bank/graphics/create", [[

    CREATE TABLE IF NOT EXISTS bs_graphics (
	id INT NULL AUTO_INCREMENT PRIMARY KEY ,
	value INT NULL,
	user_id INT NOT NULL
)
]])

Config.functions["PrepareConsult"]("bs_bank/graphics/insert", "INSERT INTO bs_graphics (value, user_id) VALUES (@value, @user_id)")
Config.functions["PrepareConsult"]("bs_bank/graphics/select", "SELECT * FROM bs_graphics WHERE  user_id=@user_id")
