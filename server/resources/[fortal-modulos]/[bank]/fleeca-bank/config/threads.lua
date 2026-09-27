CreateThread(function()
	Config.functions["PrepareConsult"]("bank/getInfos", "SELECT bank FROM characters WHERE id = @user_id;")
	Config.functions["PrepareConsult"]("bank/getInfosAll", "SELECT bank FROM characters ;")
	Config.functions["PrepareConsult"]("bank/addBank", "UPDATE characters SET bank = bank + @bank WHERE id = @user_id;")
	Config.functions["PrepareConsult"]("bank/RemBank", "UPDATE characters SET bank = bank - @bank WHERE id = @user_id;")
	Config.functions["PrepareConsult"]("bank/SetBank", "UPDATE characters SET bank = @bank WHERE id = @user_id;")
end)

CreateThread(function()
	Config.functions["ExecuteConsult"]"bs_bank/monthlyIncome"
	Config.functions["ExecuteConsult"]"bs_bank/investments"
	Config.functions["ExecuteConsult"]"bs_bank/fines"
	Config.functions["ExecuteConsult"]"bs_bank/transations"
	Config.functions["ExecuteConsult"]"bs_bank/graphics/create"
	Config.functions["ExecuteConsult"]"bs_bank/imposts/create"
	Config.functions["ExecuteConsult"]"bs_bank/invoices/create"
end)
