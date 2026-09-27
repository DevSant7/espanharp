

Config.functions["PrepareConsult"]("bs_bank/invoices/create", [[
    CREATE TABLE IF NOT EXISTS bs_invoices (
        id INT NOT NULL AUTO_INCREMENT,
        reason VARCHAR(50) NULL DEFAULT NULL,
        value INT NULL,
        user_id INT NULL,
        nuser_id INT NULL,
        PRIMARY KEY (id)
    )
]])

Config.functions["PrepareConsult"]("bs_bank/invoices/insert", [[
   INSERT INTO bs_invoices (reason, value, user_id, nuser_id) VALUES (@reason, @value, @user_id, @nuser_id);
]])

Config.functions["PrepareConsult"]("bs_bank/invoices/select", [[
   SELECT * FROM bs_invoices WHERE  user_id=@user_id
]])

Config.functions["PrepareConsult"]("bs_bank/invoices/selectById", [[
   SELECT * FROM bs_invoices WHERE  id=@id
]])


Config.functions["PrepareConsult"]("bs_bank/invoices/delete", [[
 DELETE FROM bs_invoices WHERE id=@id
]])
