Config.functions["PrepareConsult"]("bs_bank/fines", [[
  
    CREATE TABLE IF NOT EXISTS bs_fines (
        user_id INT NULL,
        service VARCHAR(50) NULL DEFAULT NULL,
        reason VARCHAR(50) NULL DEFAULT NULL,
        fine INT NULL,
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
    )
  
]]);

Config.functions["PrepareConsult"]("bs_bank/fines/insert", "UPDATE characters SET fines = fines + @fines WHERE id = @user_id")
Config.functions["PrepareConsult"]("bs_bank/fines/select", [[

    SELECT fines FROM characters WHERE id=@user_id 

]])
Config.functions["PrepareConsult"]("bs_bank/fines/selectById", [[
    SELECT * FROM bs_fines WHERE  id=@id
]])

Config.functions["PrepareConsult"]("bs_bank/fines/delete", "UPDATE characters SET fines = 0 WHERE id=@user_id")
