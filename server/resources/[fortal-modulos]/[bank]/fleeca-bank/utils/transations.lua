function newTransation(...)
	Config.functions["ExecuteConsult"]("bs_bank/transations/insert", ...)
end

function getTransation(...)
	return Config.functions["QueryConsult"]("bs_bank/transations/select", ...)
end

function deleteTransation(...)
	Config.functions["ExecuteConsult"]("bs_bank/transations/delete", ...)
end
