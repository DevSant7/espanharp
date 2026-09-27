Config.functions["PrepareConsult"]("bs_bank/investments", [[

		CREATE TABLE IF NOT EXISTS 	bs_investments (
			user_id INT NULL,
			investments INT NULL,
			investmentsInitial INT NULL,
			date INT(100) NULL,
			lastInitial VARCHAR(100) NULL,
			datePreview VARCHAR(100) NULL,
			profit INT NULL
		)

	]])

Config.functions["PrepareConsult"]("bs_investments/investments/insert", "INSERT INTO bs_investments (user_id,investments,investmentsInitial,date,lastInitial,datePreview,profit) VALUES (@user_id,@investments,@investmentsInitial,@date,@lastInitial,@datePreview,@profit);")
Config.functions["PrepareConsult"]("bs_bank/investments/select", "SELECT *  FROM bs_investments WHERE  user_id=@user_id;")
Config.functions["PrepareConsult"]("bs_bank/investments/update", "UPDATE  bs_investments  SET  investments = @investments,date = @date ,  datePreview = @datePreview , profit = profit +@profit WHERE   user_id = @user_id ;")
Config.functions["PrepareConsult"]("bs_bank/investments/delete", "DELETE FROM bs_investments  WHERE  user_id = @user_id;")
