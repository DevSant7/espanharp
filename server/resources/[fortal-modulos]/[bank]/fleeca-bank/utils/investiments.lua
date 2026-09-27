function getInvestments(user_id)
	return Config.functions["QueryConsult"]("bs_bank/investments/select", {
		user_id = user_id
	})[1]
end

function newInvestments(...)
	Config.functions["ExecuteConsult"]("bs_investments/investments/insert",...)
end

function updateInvestments(...)
	Config.functions["ExecuteConsult"]("bs_bank/investments/update",...)
end

function deleteInvestments(...)
	Config.functions["ExecuteConsult"]("bs_bank/investments/delete",...)
end





