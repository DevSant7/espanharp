function getAllBalance()
	local query = Config.functions["ExecuteConsult"]("bank/getInfosAll", {})

	return query[1] and query[1]["bank"] or 0
end

function getBalance(user_id)
	local query = Config.functions["QueryConsult"]("bank/getInfos", {
		user_id = user_id
	})

	return query[1] and query[1]["bank"] or 0
end

function isBalance(user_id, value)
	if not value then 
		return 
	end
	
	local queryBalance = getBalance(user_id)
	local result = queryBalance - value

	return result >= 0
end

function remBalance(...)
	Config.functions["ExecuteConsult"]("bank/RemBank", ...)
end

function setBalance(...)
	Config.functions["ExecuteConsult"]("bank/addBank", ...)
end
