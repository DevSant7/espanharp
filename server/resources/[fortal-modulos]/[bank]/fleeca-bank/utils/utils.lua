function formatarNumero(numero)
	local parteInteira, parteDecimal = string.match(numero, "([^.]*)%.(.*)")

	parteInteira = tonumber(numero)

	local formattedNumber = string.format("%d", parteInteira)
	local pos = #formattedNumber % 3
	local result = pos > 0 and formattedNumber:sub(1, pos) or ""

	while pos < #formattedNumber do
		if pos > 0 then
			result = result .. "."
		end

		result = result .. formattedNumber:sub(pos + 1, pos + 3)
		pos = pos + 3
	end

	if parteDecimal and tonumber(parteDecimal) ~= 0 then
		result = result .. "." .. parteDecimal
	end

	return result
end



function formatarDia(date)
	local seconds = date
	local secondsPerDay = 86400000   
	local days = math.floor(seconds  /  secondsPerDay)
	return days
end

function splitString(str,symbol)
	local number = 1
	local tableResult = {}

	if symbol == nil then
		symbol = "-"
	end

	for str in string.gmatch(str,"([^"..symbol.."]+)") do
		tableResult[number] = str
		number = number + 1
	end

	return tableResult
end