Config.functions["PrepareConsult"]("bs_bank/monthlyIncome", [[
	CREATE TABLE IF NOT EXISTS bs_monthlyIncome (
		user_id INT NULL,
		value INT NULL
	)
]])

Config.functions["PrepareConsult"]("bs_bank/monthlyIncome/insert", "INSERT INTO bs_monthlyincome (user_id,value) VALUES (@user_id,@value);")
Config.functions["PrepareConsult"]("bs_bank/monthlyIncome/select", "SELECT * FROM bs_monthlyincome WHERE  user_id=@user_id;")
Config.functions["PrepareConsult"]("bs_bank/monthlyIncome/update", "UPDATE bs_monthlyincome SET value= value +@value WHERE user_id=@user_id")
