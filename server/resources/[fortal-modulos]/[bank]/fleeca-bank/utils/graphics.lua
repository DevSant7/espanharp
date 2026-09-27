function getAllGraphics(...)
	return Config.functions["QueryConsult"]("bs_bank/graphics/select", ...)
end

function insertGraphics(...)
	return Config.functions["ExecuteConsult"]("bs_bank/graphics/insert", ...)
end
