function getAllInvoice(...)
    return Config.functions["QueryConsult"]("bs_bank/invoices/select",...)
end
function getByIdInvoice(...)
    return Config.functions["QueryConsult"]("bs_bank/invoices/selectById",...)
end

function insertInvoice(...)
     Config.functions["ExecuteConsult"]("bs_bank/invoices/insert",...)
end

function deleteInvoice(...)
    Config.functions["ExecuteConsult"]("bs_bank/invoices/delete",...)
end

