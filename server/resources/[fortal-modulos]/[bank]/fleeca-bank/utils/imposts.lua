
function getImposts(...)
     return Config.functions["QueryConsult"]("bs_bank/imposts/select",...)
end

function getImpostsByType(...)
    return Config.functions["QueryConsult"]("bs_bank/imposts/select_by_type",...)
end

function getImpostsById(id)
    return Config.functions["QueryConsult"]("bs_bank/imposts/selectById",{id = id})[1]
end

function newImposts(...)
	Config.functions["ExecuteConsult"]("bs_bank/imposts/insert", ...)
end

function deleteImposts(...)
	Config.functions["ExecuteConsult"]("bs_bank/imposts/delete", ...)
end



