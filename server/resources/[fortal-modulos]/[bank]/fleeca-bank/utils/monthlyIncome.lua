function getMonthlyIncome(...)
	return Config.functions["QueryConsult"]("bs_bank/monthlyIncome/select",...)[1]
end

function newMonthlyIncome(...)
	Config.functions["ExecuteConsult"]("bs_bank/monthlyIncome/insert", ...)
end


function updateMonthlyIncome(...)
	Config.functions["ExecuteConsult"]("bs_bank/monthlyIncome/update", ...)
end
