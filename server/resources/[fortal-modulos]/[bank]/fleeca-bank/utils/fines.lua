function getFines(...)
	return Config.functions["QueryConsult"]("bs_bank/fines/select", ...)
end

function newFines(...)
	Config.functions["ExecuteConsult"]("bs_bank/fines/insert", ...)
end

function deleteFines(...)
	Config.functions["ExecuteConsult"]("bs_bank/fines/delete", ...)
end