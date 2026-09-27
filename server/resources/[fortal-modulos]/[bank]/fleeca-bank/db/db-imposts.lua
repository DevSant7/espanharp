Config.functions["PrepareConsult"]("bs_bank/imposts/create", [[
   
    CREATE TABLE IF NOT EXISTS bs_imposts (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        reason VARCHAR(50) NULL DEFAULT NULL,
        value INT NULL DEFAULT NULL,
        type VARCHAR(50) NULL DEFAULT NULL,
        `car` VARCHAR(50) NULL DEFAULT NULL,
        user_id INT NOT NULL
    )
    
]]);

Config.functions["PrepareConsult"]("bs_bank/imposts/insert",[[
    INSERT INTO bs_imposts (reason, value, type, car,user_id) VALUES (@reason, @value, @type, @car,@user_id)
]])

Config.functions["PrepareConsult"]("bs_bank/imposts/selectById",[[
    SELECT * FROM bs_imposts WHERE  id=@id
]])

Config.functions["PrepareConsult"]("bs_bank/imposts/select",[[
    SELECT * FROM bs_imposts WHERE  user_id=@user_id
]])

Config.functions["PrepareConsult"]("bs_bank/imposts/select_by_type",[[
    SELECT * FROM bs_imposts WHERE  user_id=@user_id AND type=@type
]])

Config.functions["PrepareConsult"]("bs_bank/imposts/delete",[[
    DELETE FROM bs_imposts WHERE  id=@id
]])
