local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)
clientAPI = Tunnel.getInterface(GetCurrentResourceName())

-- Migração da tabela bank_balance_history (comentada para evitar erros)
-- Execute manualmente: bank_migration

-- Preparar consultas SQL necessárias
CreateThread(function()
    vRP.prepare("bank/getInfos", "SELECT bank FROM characters WHERE id = @user_id;")
    vRP.prepare("bank/SetBank", "UPDATE characters SET bank = @bank WHERE id = @user_id;")
    
    -- Transações (pessoais e conjuntas)
    vRP.prepare("bank/insertTransaction", "INSERT INTO bank_transactions (user_id, description, value, type, account_type, joint_account_id) VALUES (@user_id, @description, @value, @type, @account_type, @joint_account_id);")
    vRP.prepare("bank/getTransactions", "SELECT * FROM bank_transactions WHERE user_id = @user_id AND account_type = @account_type AND (@joint_account_id IS NULL OR joint_account_id = @joint_account_id) ORDER BY date DESC LIMIT 50;")
    vRP.prepare("bank/getExpensesLast4Weeks", "SELECT SUM(value) as total_expenses FROM bank_transactions WHERE user_id = @user_id AND account_type = @account_type AND (@joint_account_id IS NULL OR joint_account_id = @joint_account_id) AND type = 'Saque' AND date >= DATE_SUB(NOW(), INTERVAL 4 WEEK);")
    vRP.prepare("bank/deleteTransactions", "DELETE FROM bank_transactions WHERE user_id = @user_id;")
    vRP.prepare("bank/getBalanceHistory", "SELECT period_value, balance FROM bank_balance_history WHERE user_id = @user_id AND period_type = @period_type AND account_type = @account_type AND (@joint_account_id IS NULL OR joint_account_id = @joint_account_id) ORDER BY created_at DESC LIMIT @limit;")
    vRP.prepare("bank/insertBalanceHistory", "INSERT INTO bank_balance_history (user_id, balance, period_value, period_type, account_type, joint_account_id) VALUES (@user_id, @balance, @period_value, @period_type, @account_type, @joint_account_id);")

    -- Upsert manual (evita duplicação quando joint_account_id é NULL)
    vRP.prepare("bank/getBalanceHistoryOnePersonal", "SELECT id FROM bank_balance_history WHERE user_id = @user_id AND period_value = @period_value AND period_type = @period_type AND account_type = 'personal' AND joint_account_id IS NULL LIMIT 1;")
    vRP.prepare("bank/getBalanceHistoryOneJoint", "SELECT id FROM bank_balance_history WHERE user_id = @user_id AND period_value = @period_value AND period_type = @period_type AND account_type = 'joint' AND joint_account_id = @joint_account_id LIMIT 1;")
    vRP.prepare("bank/updateBalanceHistoryPersonal", "UPDATE bank_balance_history SET balance = @balance WHERE user_id = @user_id AND period_value = @period_value AND period_type = @period_type AND account_type = 'personal' AND joint_account_id IS NULL;")
    vRP.prepare("bank/updateBalanceHistoryJoint", "UPDATE bank_balance_history SET balance = @balance WHERE user_id = @user_id AND period_value = @period_value AND period_type = @period_type AND account_type = 'joint' AND joint_account_id = @joint_account_id;")
    
    -- Perfil bancário
    vRP.prepare("bank/getAccountInfo", "SELECT * FROM bank_accounts WHERE user_id = @user_id;")
    vRP.prepare("bank/getAccountInfoByUsername", "SELECT * FROM bank_accounts WHERE username = @username;")
    vRP.prepare("bank/insertAccountInfo", "INSERT INTO bank_accounts (user_id, profile_photo, full_name, nickname, username, gender, transfer_key_type, security_pin) VALUES (@user_id, @profile_photo, @full_name, @nickname, @username, @gender, @transfer_key_type, @security_pin);")
    vRP.prepare("bank/updateAccountInfo", "UPDATE bank_accounts SET profile_photo = @profile_photo, full_name = @full_name, nickname = @nickname, username = @username, gender = @gender, transfer_key_type = @transfer_key_type, security_pin = @security_pin WHERE user_id = @user_id;")

    -- Faturas
    vRP.prepare("bank/getUserInvoices", "SELECT * FROM bank_invoices WHERE user_id = @user_id ORDER BY created_at DESC LIMIT 50;")
    vRP.prepare("bank/getPendingInvoicesTotal", "SELECT COALESCE(SUM(amount),0) AS total FROM bank_invoices WHERE user_id = @user_id AND status = 'pending';")
    vRP.prepare("bank/insertInvoice", "INSERT INTO bank_invoices (user_id, issuer_id, title, description, amount, status, due_date) VALUES (@user_id, @issuer_id, @title, @description, @amount, 'pending', @due_date);")
    vRP.prepare("bank/payInvoice", "UPDATE bank_invoices SET status = 'paid', paid_at = NOW() WHERE id = @id AND user_id = @user_id AND status = 'pending';")
    vRP.prepare("bank/getPaidInvoicesLast4Weeks", "SELECT COALESCE(SUM(amount),0) AS total FROM bank_invoices WHERE user_id = @user_id AND status = 'paid' AND paid_at >= DATE_SUB(NOW(), INTERVAL 4 WEEK);")
    
    -- Contas em sociedade (estrutura simplificada)
    vRP.prepare("bank/createJointAccount", "INSERT INTO bank_joint_accounts (account_name, account_type, members, created_by) VALUES (@account_name, @account_type, @members, @created_by);")
    vRP.prepare("bank/getUserJointAccounts", "SELECT * FROM bank_joint_accounts WHERE members LIKE @user_id_pattern;")
    vRP.prepare("bank/updateJointAccountBalance", "UPDATE bank_joint_accounts SET balance = @balance WHERE id = @account_id;")
    vRP.prepare("bank/getJointAccountBalance", "SELECT balance FROM bank_joint_accounts WHERE id = @account_id;")
    vRP.prepare("bank/checkUserInJointAccount", "SELECT * FROM bank_joint_accounts WHERE id = @account_id AND members LIKE @user_id_pattern;")
    
end)

-- Funções para transações
function registerTransaction(user_id, description, value, type, account_type, joint_account_id)
    print("^3[FORTAL_BANK] registerTransaction chamado:")
    print("^3[FORTAL_BANK] user_id:", user_id)
    print("^3[FORTAL_BANK] description:", description)
    print("^3[FORTAL_BANK] value:", value)
    print("^3[FORTAL_BANK] type:", type)
    print("^3[FORTAL_BANK] account_type:", account_type)
    print("^3[FORTAL_BANK] joint_account_id:", joint_account_id)
    
    vRP.execute("bank/insertTransaction", {
        user_id = user_id,
        description = description,
        value = value,
        type = type,
        account_type = account_type or "personal",
        joint_account_id = joint_account_id or nil
    })
end

function src.getTransactions(accountType, accountId)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        return {}
    end
    
    if accountType == "joint" and accountId then
        -- Buscar transações da conta conjunta
        print("^3[FORTAL_BANK] Buscando transações da conta conjunta ID:", accountId)
        
        local hasAccess = vRP.query("bank/checkUserInJointAccount", { 
            account_id = tonumber(accountId),
            user_id_pattern = "%" .. user_id .. "%" 
        })
        
        if not hasAccess or #hasAccess == 0 then
            print("^1[FORTAL_BANK] Usuário sem acesso à conta conjunta")
            return {}
        end
        
        -- Buscar transações da conta conjunta
        local transactions = vRP.query("bank/getTransactions", { 
            user_id = user_id, 
            account_type = "joint",
            joint_account_id = tonumber(accountId)
        })
        return transactions or {}
    else
        -- Buscar transações da conta pessoal
        print("^3[FORTAL_BANK] Buscando transações da conta pessoal")
        local transactions = vRP.query("bank/getTransactions", { 
            user_id = user_id, 
            account_type = "personal",
            joint_account_id = nil
        })
        return transactions or {}
    end
end

function src.getExpensesLast4Weeks(accountType, accountId)
    local source = source
    local user_id = Utils.functions.getUserId(source)

    if not user_id then
        return 0
    end

    if accountType == "joint" and accountId then
        -- Para contas conjuntas, calcular despesas baseado nas transações da conta conjunta
        print("^3[FORTAL_BANK] Calculando despesas da conta conjunta ID:", accountId)
        
        local hasAccess = vRP.query("bank/checkUserInJointAccount", { 
            account_id = tonumber(accountId),
            user_id_pattern = "%" .. user_id .. "%" 
        })
        
        if not hasAccess or #hasAccess == 0 then
            print("^1[FORTAL_BANK] Usuário sem acesso à conta conjunta")
            return 0
        end
        
        -- Buscar despesas da conta conjunta
        local result = vRP.query("bank/getExpensesLast4Weeks", { 
            user_id = user_id, 
            account_type = "joint",
            joint_account_id = tonumber(accountId)
        })
        
        if result and result[1] and result[1].total_expenses then
            print("^3[FORTAL_BANK] Total de despesas da conta conjunta:", result[1].total_expenses)
            return result[1].total_expenses
        end
        
        return 0
    else
        -- Despesas da conta pessoal
        print("^3[FORTAL_BANK] Calculando despesas da conta pessoal")
        local result = vRP.query("bank/getExpensesLast4Weeks", { 
            user_id = user_id, 
            account_type = "personal",
            joint_account_id = nil
        })
        local cardExpenses = 0
        if result and result[1] and result[1].total_expenses then
            cardExpenses = result[1].total_expenses
        end
        -- Somar faturas pagas nas últimas 4 semanas
        local invoices = vRP.query("bank/getPaidInvoicesLast4Weeks", { user_id = user_id })
        local invoicesTotal = (invoices and invoices[1] and invoices[1].total) and tonumber(invoices[1].total) or 0
        return cardExpenses + invoicesTotal
    end
end

-- Função para calcular semana do ano (Lua não tem %V nativo)
function getWeekOfYear()
    local now = os.time()
    local year = tonumber(os.date("%Y", now))
    local jan1 = os.time({year = year, month = 1, day = 1})
    local daysSinceJan1 = math.floor((now - jan1) / (24 * 60 * 60))
    local weekNum = math.floor(daysSinceJan1 / 7) + 1
    
    -- Ajustar para que a primeira semana seja 1
    if weekNum < 1 then
        weekNum = 1
    elseif weekNum > 52 then
        weekNum = 52
    end
    
    return string.format("%d-W%d", year, weekNum)
end

-- Função para calcular semana do mês (1-4)
function getWeekOfMonth()
    local now = os.time()
    local day = tonumber(os.date("%d", now))
    local weekOfMonth = math.ceil(day / 7)
    
    -- Ajustar para que seja entre 1 e 4
    if weekOfMonth < 1 then
        weekOfMonth = 1
    elseif weekOfMonth > 4 then
        weekOfMonth = 4
    end
    
    return weekOfMonth
end

-- Função para salvar histórico de saldo
function saveBalanceHistory(user_id, balance, account_type, joint_account_id)
    print("^3[FORTAL_BANK] Salvando histórico de saldo para user_id:", user_id, "balance:", balance, "account_type:", account_type, "joint_account_id:", joint_account_id)

    local accType = account_type or "personal"
    local jointId = joint_account_id or nil

    -- Weekly: chave = data (YYYY-MM-DD)
    local today = os.date("%Y-%m-%d")
    local existsWeekly
    if accType == "joint" and jointId then
        existsWeekly = vRP.query("bank/getBalanceHistoryOneJoint", { user_id = user_id, period_value = today, period_type = "weekly", joint_account_id = jointId })
    else
        existsWeekly = vRP.query("bank/getBalanceHistoryOnePersonal", { user_id = user_id, period_value = today, period_type = "weekly" })
    end

    if existsWeekly and #existsWeekly > 0 then
        if accType == "joint" and jointId then
            vRP.execute("bank/updateBalanceHistoryJoint", { user_id = user_id, balance = balance, period_value = today, period_type = "weekly", joint_account_id = jointId })
        else
            vRP.execute("bank/updateBalanceHistoryPersonal", { user_id = user_id, balance = balance, period_value = today, period_type = "weekly" })
        end
    else
        vRP.execute("bank/insertBalanceHistory", { user_id = user_id, balance = balance, period_value = today, period_type = "weekly", account_type = accType, joint_account_id = jointId })
    end

    -- Monthly: chave = YYYY-MM-Wn
    local yearMonth = os.date("%Y-%m")
    local weekOfMonth = getWeekOfMonth()
    local monthWeekKey = yearMonth .. "-W" .. weekOfMonth

    local existsMonthly
    if accType == "joint" and jointId then
        existsMonthly = vRP.query("bank/getBalanceHistoryOneJoint", { user_id = user_id, period_value = monthWeekKey, period_type = "monthly", joint_account_id = jointId })
    else
        existsMonthly = vRP.query("bank/getBalanceHistoryOnePersonal", { user_id = user_id, period_value = monthWeekKey, period_type = "monthly" })
    end

    if existsMonthly and #existsMonthly > 0 then
        if accType == "joint" and jointId then
            vRP.execute("bank/updateBalanceHistoryJoint", { user_id = user_id, balance = balance, period_value = monthWeekKey, period_type = "monthly", joint_account_id = jointId })
        else
            vRP.execute("bank/updateBalanceHistoryPersonal", { user_id = user_id, balance = balance, period_value = monthWeekKey, period_type = "monthly" })
        end
    else
        vRP.execute("bank/insertBalanceHistory", { user_id = user_id, balance = balance, period_value = monthWeekKey, period_type = "monthly", account_type = accType, joint_account_id = jointId })
    end
end

function src.getBalanceHistory(period, accountType, accountId)
    local source = source
    local user_id = Utils.functions.getUserId(source)

    print("^3[FORTAL_BANK] getBalanceHistory chamado:")
    print("^3[FORTAL_BANK] - period:", period)
    print("^3[FORTAL_BANK] - user_id:", user_id)
    print("^3[FORTAL_BANK] - accountType:", accountType)
    print("^3[FORTAL_BANK] - accountId:", accountId)

    if not user_id then
        print("^1[FORTAL_BANK] user_id não encontrado")
        return {}
    end

    local limit = 8 -- incluir 1 registro anterior para carry-over
    if period == "monthly" then limit = 5 -- incluir 1 semana anterior para carry-over
    end

    print("^3[FORTAL_BANK] Buscando histórico com limit:", limit)
    print("^3[FORTAL_BANK] Query params:")
    print("^3[FORTAL_BANK] - user_id:", user_id)
    print("^3[FORTAL_BANK] - period_type:", period)
    print("^3[FORTAL_BANK] - limit:", limit)

    -- Buscar histórico para qualquer tipo de conta
    local result
    if accountType == "joint" and accountId then
        result = vRP.query("bank/getBalanceHistory", { 
            user_id = user_id, 
            period_type = period, 
            account_type = "joint",
            joint_account_id = tonumber(accountId),
            limit = limit 
        })
    else
        result = vRP.query("bank/getBalanceHistory", { 
            user_id = user_id, 
            period_type = period, 
            account_type = "personal",
            joint_account_id = nil,
            limit = limit 
        })
    end

    print("^3[FORTAL_BANK] Resultado da query:")
    print("^3[FORTAL_BANK] - Número de registros:", result and #result or 0)
    if result and #result > 0 then
        for i, record in ipairs(result) do
            print("^3[FORTAL_BANK] - Registro", i, ":", json.encode(record))
        end
    end

    return result or {}
end

-- Comando para executar migração manualmente
RegisterCommand("bank_migration", function(source, args)
    if source == 0 then -- Apenas console
        print("^3[FORTAL_BANK] Executando migração manual...")
        
        local success1 = pcall(function()
            vRP.execute("ALTER TABLE `bank_balance_history` ADD COLUMN `account_type` ENUM('personal', 'joint') DEFAULT 'personal' AFTER `period_type`")
            print("^2[FORTAL_BANK] Coluna account_type adicionada!")
        end)
        
        local success2 = pcall(function()
            vRP.execute("ALTER TABLE `bank_balance_history` ADD COLUMN `joint_account_id` INT NULL AFTER `account_type`")
            print("^2[FORTAL_BANK] Coluna joint_account_id adicionada!")
        end)
        
        print("^2[FORTAL_BANK] Migração manual concluída!")
    end
end, true)

-- Função para buscar a chave de transferência de um usuário
function getTransferKey(user_id)
    if not user_id then
        return nil
    end
    
    local accountInfo = vRP.query("bank/getAccountInfo", { user_id = user_id })
    
    if accountInfo and #accountInfo > 0 then
        local account = accountInfo[1]
        local transferKeyType = account.transfer_key_type or "usuario"
        
        print("^3[FORTAL_BANK] getTransferKey - user_id:", user_id, "transfer_key_type:", transferKeyType)
        
        if transferKeyType == "passaporte" then
            -- Para passaporte, usar o user_id
            print("^3[FORTAL_BANK] getTransferKey - retornando passaporte:", user_id)
            return user_id
        else
            -- Para usuário, usar o username
            local username = account.username or "Usuario" .. user_id
            print("^3[FORTAL_BANK] getTransferKey - retornando username:", username)
            return username
        end
    else
        -- Se não tem conta bancária, usar username padrão
        local username = Utils.functions.getUserName(user_id) or "Usuario" .. user_id
        print("^3[FORTAL_BANK] getTransferKey - conta não encontrada, usando username padrão:", username)
        return username
    end
end

-- Função para encontrar usuário por chave de transferência
function findUserByTransferKey(transfer_key)
    if not transfer_key then
        return nil
    end
    
    print("^3[FORTAL_BANK] findUserByTransferKey - buscando por:", transfer_key)
    
    -- Primeiro, tentar buscar por user_id (passaporte)
    local user_id = tonumber(transfer_key)
    if user_id then
        local identity = vRP.getUserIdentity(user_id)
        if identity then
            print("^3[FORTAL_BANK] findUserByTransferKey - encontrado por passaporte:", user_id)
            return user_id
        end
    end
    
    -- Se não encontrou por ID, buscar por username usando prepared statement
    local allAccounts = vRP.query("bank/getAccountInfoByUsername", { username = transfer_key })
    
    if allAccounts and #allAccounts > 0 then
        local user_id = allAccounts[1].user_id
        print("^3[FORTAL_BANK] findUserByTransferKey - encontrado por username:", transfer_key, "user_id:", user_id)
        return user_id
    end
    
    print("^1[FORTAL_BANK] findUserByTransferKey - não encontrado:", transfer_key)
    return nil
end

-- Funções para informações da conta bancária
function src.getAccountInfo()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        return {}
    end
    
    local result = vRP.query("bank/getAccountInfo", { user_id = user_id })
    
    if result and #result > 0 then
        return result[1]
    else
        -- Se não existe, criar registro básico
        local identity = vRP.getUserIdentity(user_id)
        local username = Utils.functions.getUserName(user_id) or vRP.getPlayerName(source) or "Usuario" .. user_id
        
        print("^3[FORTAL_BANK] Debug - user_id:", user_id)
        print("^3[FORTAL_BANK] Debug - identity:", json.encode(identity))
        print("^3[FORTAL_BANK] Debug - username:", username)
        
        -- Puxar dados reais do jogador
        local fullName = "Nome não definido"
        local nickname = "Apelido não definido"
        
        if identity then
            -- VRP identity structure: name = full name, firstname = first name
            if identity.name and identity.name ~= "" then
                fullName = identity.name
                print("^3[FORTAL_BANK] Debug - fullName definido:", fullName)
            else
                print("^1[FORTAL_BANK] Debug - identity.name vazio ou nil")
            end
            
            if identity.firstname and identity.firstname ~= "" then
                nickname = identity.firstname
                print("^3[FORTAL_BANK] Debug - nickname definido:", nickname)
            else
                print("^1[FORTAL_BANK] Debug - identity.firstname vazio ou nil")
            end
        else
            print("^1[FORTAL_BANK] Debug - identity é nil, tentando usar username como nome")
            -- Se não tem identity, usar username como nome
            if username and username ~= "" and username ~= "Usuario" .. user_id then
                fullName = username
                nickname = username
                print("^3[FORTAL_BANK] Debug - usando username como nome:", username)
            end
        end
        
        local accountData = {
            profile_photo = nil,
            full_name = fullName,
            nickname = nickname, 
            username = username,
            gender = "masculino",
            transfer_key_type = "usuario",
            security_pin = "0000"
        }
        
        vRP.execute("bank/insertAccountInfo", {
            user_id = user_id,
            profile_photo = accountData.profile_photo,
            full_name = accountData.full_name,
            nickname = accountData.nickname,
            username = accountData.username,
            gender = accountData.gender,
            transfer_key_type = accountData.transfer_key_type,
            security_pin = accountData.security_pin
        })
        
        return accountData
    end
end

-- Faturas: listar
function src.getUserInvoices()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if not user_id then return {} end
    local rows = vRP.query("bank/getUserInvoices", { user_id = user_id })
    return rows or {}
end

-- Faturas: total pendente
function src.getPendingInvoicesTotal()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if not user_id then return 0 end
    local res = vRP.query("bank/getPendingInvoicesTotal", { user_id = user_id })
    local total = (res and res[1] and res[1].total) and tonumber(res[1].total) or 0
    return total
end

-- Faturas: pagar
function src.payInvoice(id)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if not user_id or not id then return false end

    -- Buscar fatura
    local invoices = vRP.query("bank/getUserInvoices", { user_id = user_id })
    local invoice
    for _,inv in ipairs(invoices or {}) do
        if tonumber(inv.id) == tonumber(id) and inv.status == 'pending' then
            invoice = inv
            break
        end
    end
    if not invoice then return false end

    -- Verificar saldo e debitar
    local bank = vRP.getBank(user_id) or 0
    if bank < invoice.amount then return false end
    vRP.execute("bank/SetBank", { user_id = user_id, bank = bank - invoice.amount })

    -- Atualizar fatura para paga
    vRP.execute("bank/payInvoice", { id = invoice.id, user_id = user_id })

    -- Registrar transação e histórico
    registerTransaction(user_id, invoice.title or 'Fatura paga', invoice.amount, 'Fatura', 'personal', nil)
    saveBalanceHistory(user_id, bank - invoice.amount, 'personal', nil)

    return true
end

function src.updateAccountInfo(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        return false
    end
    
    -- Validar dados
    if not data.full_name or not data.nickname or not data.username then
        return false
    end
    
    -- Verificar se PIN é válido (se fornecido) - PIN deve ter 4 dígitos
    if data.security_pin and (string.len(data.security_pin) ~= 4 or not string.match(data.security_pin, "^%d+$")) then
        return false
    end
    
    -- Atualizar ou inserir
    local existing = vRP.query("bank/getAccountInfo", { user_id = user_id })
    
    if existing and #existing > 0 then
        -- Atualizar
        vRP.execute("bank/updateAccountInfo", {
            user_id = user_id,
            profile_photo = data.profile_photo or existing[1].profile_photo,
            full_name = data.full_name,
            nickname = data.nickname,
            username = data.username,
            gender = data.gender or "masculino",
            transfer_key_type = data.transfer_key_type or "usuario",
            security_pin = data.security_pin or existing[1].security_pin
        })
    else
        -- Inserir novo
        vRP.execute("bank/insertAccountInfo", {
            user_id = user_id,
            profile_photo = data.profile_photo,
            full_name = data.full_name,
            nickname = data.nickname,
            username = data.username,
            gender = data.gender or "masculino",
            transfer_key_type = data.transfer_key_type or "usuario",
            security_pin = data.security_pin
        })
    end
    
    return true
end

-- Funções para contas em sociedade (simplificadas)
function src.getUserJointAccounts()
    local source = source
    
    -- 🔥 Verificação 1: source existe?
    if not source then
        print("^1[FORTAL_BANK] getUserJointAccounts: source é nil")
        return {}
    end
    
    -- 🔥 Verificação 2: Utils existe?
    if not Utils or not Utils.functions or not Utils.functions.getUserId then
        print("^1[FORTAL_BANK] getUserJointAccounts: Utils não está carregado!")
        return {}
    end
    
    -- 🔥 Verificação 3: user_id existe?
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        print("^1[FORTAL_BANK] getUserJointAccounts: user_id não encontrado para source:", source)
        return {}
    end
    
    print("^3[FORTAL_BANK] getUserJointAccounts chamado para user_id:", user_id)
    
    -- SEMPRE buscar do banco de dados para garantir dados atualizados
    local result = vRP.query("bank/getUserJointAccounts", { 
        user_id_pattern = "%" .. user_id .. "%" 
    })
    
    print("^3[FORTAL_BANK] getUserJointAccounts retornando:", json.encode(result))
    return result or {}
end

function src.createJointAccount(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    print("^3[FORTAL_BANK] createJointAccount chamado - user_id:", user_id)
    print("^3[FORTAL_BANK] Dados recebidos:", json.encode(data))
    
    if not user_id then
        return { success = false, message = "Usuário não encontrado" }
    end
    
    -- Validar dados
    if not data.account_name or not data.account_type then
        print("^1[FORTAL_BANK] Dados inválidos - account_name:", data.account_name, "account_type:", data.account_type)
        return { success = false, message = "Dados inválidos" }
    end
    
    -- Validar tipo de conta
    local validTypes = { "casal", "familia", "empresarial", "conjunto" }
    local isValidType = false
    print("^3[FORTAL_BANK] Validando tipo:", data.account_type)
    
    for _, type in ipairs(validTypes) do
        print("^3[FORTAL_BANK] Comparando com:", type)
        if data.account_type == type then
            isValidType = true
            print("^2[FORTAL_BANK] Tipo válido encontrado:", type)
            break
        end
    end
    
    if not isValidType then
        print("^1[FORTAL_BANK] Tipo inválido:", data.account_type)
        return { success = false, message = "Tipo de conta inválido: " .. tostring(data.account_type) }
    end
    
    -- Para casal e família, verificar se tem pelo menos 2 participantes
    if (data.account_type == "casal" or data.account_type == "familia") and 
       (not data.participants or #data.participants < 2) then
        return { success = false, message = "Casal e família precisam de pelo menos 2 participantes" }
    end
    
    -- Preparar lista de membros (JSON simples)
    local members = { user_id } -- Criador sempre incluído
    if data.participants then
        for _, participant_id in ipairs(data.participants) do
            table.insert(members, participant_id)
        end
    end
    
    local membersJson = json.encode(members)
    
    -- Criar conta
    local result = vRP.execute("bank/createJointAccount", {
        account_name = data.account_name,
        account_type = data.account_type,
        members = membersJson,
        created_by = user_id
    })
    
    if not result then
        return { success = false, message = "Erro ao criar conta" }
    end
    
    local accountId = result.insertId
    return { success = true, account_id = accountId }
end

function src.getJointAccountBalance(account_id)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id or not account_id then
        return 0
    end
    
    -- Verificar se o usuário tem acesso à conta
    local result = vRP.query("bank/checkUserInJointAccount", { 
        account_id = account_id,
        user_id_pattern = "%" .. user_id .. "%" 
    })
    
    if not result or #result == 0 then
        return 0 -- Usuário não tem acesso
    end
    
    local balanceResult = vRP.query("bank/getJointAccountBalance", { account_id = account_id })
    return balanceResult and #balanceResult > 0 and balanceResult[1].balance or 0
end

function src.updateJointAccountBalance(account_id, new_balance)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id or not account_id or not new_balance then
        return false
    end
    
    -- Verificar se o usuário tem acesso à conta
    local result = vRP.query("bank/checkUserInJointAccount", { 
        account_id = account_id,
        user_id_pattern = "%" .. user_id .. "%" 
    })
    
    if not result or #result == 0 then
        return false -- Usuário não tem acesso
    end
    
    local updateResult = vRP.execute("bank/updateJointAccountBalance", {
        account_id = account_id,
        balance = new_balance
    })
    
    return updateResult ~= nil
end

-- Função para transferir dinheiro para outro jogador
function src.transfer(amount, target_key, accountType, accountId)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    print("^3[FORTAL_BANK] transfer chamado:")
    print("^3[FORTAL_BANK] amount:", amount)
    print("^3[FORTAL_BANK] target_key:", target_key)
    print("^3[FORTAL_BANK] accountType:", accountType)
    print("^3[FORTAL_BANK] accountId:", accountId)

    if not user_id or not amount or not target_key then
        return { success = false, message = "Dados inválidos", type = "error" }
    end

    -- Validar se o valor é positivo
    if amount <= 0 then
        return { success = false, message = "Valor deve ser maior que zero", type = "error" }
    end

    -- Verificar se não está tentando transferir para si mesmo
    if tostring(target_key) == tostring(user_id) then
        return { success = false, message = "Você não pode transferir para si mesmo", type = "error" }
    end

    -- Buscar usuário de destino usando a chave de transferência
    local target_user_id = findUserByTransferKey(target_key)
    if not target_user_id then
        return { success = false, message = "Usuário de destino não encontrado", type = "error" }
    end

    -- Buscar nome do destinatário (não bloquear se identity não estiver carregada)
    local target_identity = vRP.getUserIdentity(target_user_id)
    if not target_identity then
        print("^3[FORTAL_BANK] Aviso: identity do destinatário não encontrada, prosseguindo mesmo assim")
    end

    local source_name = Utils.functions.getUserName(user_id)
    local target_name = Utils.functions.getUserName(target_user_id)

    -- Verificar saldo e processar transferência
    if accountType == "joint" and accountId then
        -- Transferência de conta conjunta
        print("^3[FORTAL_BANK] Transferência de conta conjunta ID:", accountId)
        
        local hasAccess = vRP.query("bank/checkUserInJointAccount", { 
            account_id = tonumber(accountId),
            user_id_pattern = "%" .. user_id .. "%" 
        })
        
        if not hasAccess or #hasAccess == 0 then
            print("^1[FORTAL_BANK] Usuário sem acesso à conta conjunta")
            return { success = false, message = "Você não tem acesso a esta conta", type = "error" }
        end
        
        local currentBalance = vRP.query("bank/getJointAccountBalance", { account_id = tonumber(accountId) })
        local balance = currentBalance and #currentBalance > 0 and currentBalance[1].balance or 0
        
        print("^3[FORTAL_BANK] Saldo atual da conta conjunta:", balance, "Valor solicitado:", amount)
        
        if balance < amount then
            print("^1[FORTAL_BANK] Saldo insuficiente na conta conjunta")
            return { success = false, message = "Saldo insuficiente na conta conjunta", type = "error" }
        end
        
        -- Debitar da conta conjunta
        local newBalance = balance - amount
        vRP.execute("bank/updateJointAccountBalance", {
            account_id = tonumber(accountId),
            balance = newBalance
        })
        
        -- Creditar na conta pessoal do destinatário
        vRP.addBank(target_user_id, amount)
        
        -- Registrar transação na conta conjunta (saída)
        registerTransaction(user_id, "Transferência para " .. target_name, amount, "Transferência", "joint", tonumber(accountId))
        
        -- Registrar transação na conta pessoal do destinatário (entrada)
        registerTransaction(target_user_id, "Transferência de " .. source_name, amount, "Transferência", "personal", nil)
        
        -- Salvar histórico de saldo
        saveBalanceHistory(user_id, newBalance, "joint", tonumber(accountId))
        saveBalanceHistory(target_user_id, vRP.getBank(target_user_id) or 0, "personal", nil)
        
        print("^2[FORTAL_BANK] Transferência de conta conjunta realizada:", amount, "para", target_name)
        
        -- Forçar refresh no remetente sem notificação visual
        if clientAPI.refreshAll then clientAPI.refreshAll(source) end
        
        -- Enviar notificação para o destinatário se estiver online
        local target_source = vRP.getUserSource(target_user_id)
        if target_source then
            if clientAPI.refreshAll then clientAPI.refreshAll(target_source) end
        end
        
        return {
            success = true,
            message = "Transferência de R$ " .. amount .. " realizada para " .. target_name,
            type = "success",
            newBalance = newBalance
        }
    else
        -- Transferência de conta pessoal
        print("^3[FORTAL_BANK] Transferência de conta pessoal")
        
        local bank = vRP.getBank(user_id) or 0
        print("^3[FORTAL_BANK] Saldo atual no banco:", bank, "Valor solicitado:", amount)
        
        if bank < amount then
            print("^1[FORTAL_BANK] Saldo insuficiente no banco")
            return { success = false, message = "Saldo insuficiente no banco", type = "error" }
        end

        -- Debitar da conta do remetente
        local newBalance = bank - amount
        vRP.execute("bank/SetBank", { user_id = user_id, bank = newBalance })
        
        -- Creditar na conta do destinatário
        vRP.addBank(target_user_id, amount)
        
        -- Registrar transação do remetente (saída)
        registerTransaction(user_id, "Transferência para " .. target_name, amount, "Transferência", "personal", nil)
        
        -- Registrar transação do destinatário (entrada)
        registerTransaction(target_user_id, "Transferência de " .. source_name, amount, "Transferência", "personal", nil)
        
        -- Salvar histórico de saldo
        saveBalanceHistory(user_id, newBalance, "personal", nil)
        saveBalanceHistory(target_user_id, vRP.getBank(target_user_id) or 0, "personal", nil)
        
        print("^2[FORTAL_BANK] Transferência realizada:", amount, "de", source_name, "para", target_name)

        -- Forçar refresh no remetente sem notificação visual
        if clientAPI.refreshAll then clientAPI.refreshAll(source) end
        
        -- Enviar notificação para o destinatário se estiver online
        local target_source = vRP.getUserSource(target_user_id)
        if target_source then
            if clientAPI.refreshAll then clientAPI.refreshAll(target_source) end
        end

        return {
            success = true,
            message = "Transferência de R$ " .. amount .. " realizada para " .. target_name,
            type = "success",
            newBalance = newBalance
        }
    end
end

function src.resetSecurityPin()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        return false
    end
    
    -- Resetar PIN para 0000
    local existing = vRP.query("bank/getAccountInfo", { user_id = user_id })
    
    if existing and #existing > 0 then
        -- Atualizar apenas o PIN
        vRP.execute("bank/updateAccountInfo", {
            user_id = user_id,
            profile_photo = existing[1].profile_photo,
            full_name = existing[1].full_name,
            nickname = existing[1].nickname,
            username = existing[1].username,
            gender = existing[1].gender,
            transfer_key_type = existing[1].transfer_key_type,
            security_pin = "0000"
        })
        return true
    else
        -- Se não existe registro, criar com PIN 0000
        local identity = vRP.getUserIdentity(user_id)
        local username = vRP.getPlayerName(source) or "Usuario" .. user_id
        
        vRP.execute("bank/insertAccountInfo", {
            user_id = user_id,
            profile_photo = nil,
            full_name = identity and identity.name or "Nome não definido",
            nickname = identity and identity.firstname or "Apelido não definido",
            username = username,
            gender = "masculino",
            transfer_key_type = "usuario",
            security_pin = "0000"
        })
        return true
    end
end

-- Função para obter a chave de transferência atual do usuário
function src.getTransferKey()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        return nil
    end
    
    local transferKey = getTransferKey(user_id)
    print("^3[FORTAL_BANK] getTransferKey - retornando chave:", transferKey, "para user_id:", user_id)
    return transferKey
end

function src.getUserData()
    local source = source
    print("^3[FORTAL_BANK] getUserData chamado para source:", source)
    
    local user_id = Utils.functions.getUserId(source)
    print("^3[FORTAL_BANK] user_id:", user_id)
    
    -- Criar conta bancária automaticamente se não existir
    if user_id then
        local accountInfo = src.getAccountInfo()
        print("^3[FORTAL_BANK] conta bancária criada/verificada:", json.encode(accountInfo))
    end
    
    local userName = Utils.functions.getUserName(user_id)
    print("^3[FORTAL_BANK] userName:", userName)
    
    -- SEMPRE buscar do banco de dados para garantir dados atualizados
    local userBank = vRP.getBank(user_id) or 0
    print("^3[FORTAL_BANK] userBank (FRESCO DO BD):", userBank)
    
    if user_id then
        local result = {
            id = user_id,
            name = userName,
            bank = userBank
        }
        print("^2[FORTAL_BANK] Retornando dados atualizados:", json.encode(result))
        return result
    end
    
    print("^1[FORTAL_BANK] user_id é nil, retornando nil")
    return nil
end

function src.deposit(amount, accountType, accountId)
    local source = source
    local user_id = Utils.functions.getUserId(source)

    print("^3[FORTAL_BANK] src.deposit chamado:")
    print("^3[FORTAL_BANK] amount:", amount)
    print("^3[FORTAL_BANK] accountType:", accountType)
    print("^3[FORTAL_BANK] accountId:", accountId)

    if not user_id then
        return { success = false, message = "Usuário não encontrado", type = "error" }
    end

    -- Verificar se tem dinheiro na mão usando o método correto do VRP
    local hasMoney = vRP.tryGetInventoryItem(user_id, "dollars", amount)
    print("^3[FORTAL_BANK] Verificação de dinheiro na mão:", hasMoney, "Valor solicitado:", amount)
    
    if not hasMoney then
        print("^1[FORTAL_BANK] Dinheiro insuficiente na mão")
        return { success = false, message = "Você não possui dinheiro suficiente na mão", type = "error" }
    end

    -- Verificar tipo de conta
    if accountType == "joint" and accountId then
        -- Depósito em conta conjunta
        print("^3[FORTAL_BANK] Depósito em conta conjunta ID:", accountId)
        
        local hasAccess = vRP.query("bank/checkUserInJointAccount", { 
            account_id = tonumber(accountId),
            user_id_pattern = "%" .. user_id .. "%" 
        })
        
        if not hasAccess or #hasAccess == 0 then
            print("^1[FORTAL_BANK] Usuário sem acesso à conta conjunta")
            return { success = false, message = "Você não tem acesso a esta conta", type = "error" }
        end
        
        local currentBalance = vRP.query("bank/getJointAccountBalance", { account_id = tonumber(accountId) })
        local balance = currentBalance and #currentBalance > 0 and currentBalance[1].balance or 0
        
        local newBalance = balance + amount
        vRP.execute("bank/updateJointAccountBalance", {
            account_id = tonumber(accountId),
            balance = newBalance
        })
        
        -- Registrar transação na conta conjunta
        registerTransaction(user_id, "Depósito", amount, "Depósito", "joint", tonumber(accountId))
        
        -- Salvar histórico de saldo da conta conjunta
        saveBalanceHistory(user_id, newBalance, "joint", tonumber(accountId))
        
        print("^2[FORTAL_BANK] Depósito em conta conjunta realizado:", amount, "Saldo atual:", newBalance)

        -- Atualizar UI silenciosamente (sem notificação)
        if clientAPI.refreshAll then clientAPI.refreshAll(source) end
        
        return {
            success = true,
            message = "Você depositou R$ " .. amount .. " na conta conjunta",
            type = "success",
            newBalance = newBalance
        }
    else
        -- Depósito em conta pessoal (lógica original)
        print("^3[FORTAL_BANK] Depósito em conta pessoal")
        
        -- Adicionar dinheiro no banco
        vRP.addBank(user_id, amount)

        -- Registrar transação
        registerTransaction(user_id, "Depósito em conta", amount, "Depósito", "personal", nil)

        -- Salvar histórico de saldo
        local newBalance = vRP.getBank(user_id) or 0
        saveBalanceHistory(user_id, newBalance, "personal", nil)

        print("^2[FORTAL_BANK] Depósito realizado:", amount, "para user_id:", user_id)

        -- Atualizar UI silenciosamente (sem notificação)
        if clientAPI.refreshAll then clientAPI.refreshAll(source) end

        return {
            success = true,
            message = "Você depositou R$ " .. amount,
            type = "success",
            newBalance = vRP.getBank(user_id) or 0
        }
    end
end

function src.withdraw(amount, accountType, accountId)
    local source = source
    local user_id = Utils.functions.getUserId(source)

    if not user_id then
        return { success = false, message = "Usuário não encontrado", type = "error" }
    end

    -- Verificar tipo de conta
    if accountType == "joint" and accountId then
        -- Saque de conta conjunta
        print("^3[FORTAL_BANK] Saque de conta conjunta ID:", accountId)
        
        local hasAccess = vRP.query("bank/checkUserInJointAccount", { 
            account_id = tonumber(accountId),
            user_id_pattern = "%" .. user_id .. "%" 
        })
        
        if not hasAccess or #hasAccess == 0 then
            print("^1[FORTAL_BANK] Usuário sem acesso à conta conjunta")
            return { success = false, message = "Você não tem acesso a esta conta", type = "error" }
        end
        
        local currentBalance = vRP.query("bank/getJointAccountBalance", { account_id = tonumber(accountId) })
        local balance = currentBalance and #currentBalance > 0 and currentBalance[1].balance or 0
        
        print("^3[FORTAL_BANK] Saldo atual da conta conjunta:", balance, "Valor solicitado:", amount)
        
        if balance < amount then
            print("^1[FORTAL_BANK] Saldo insuficiente na conta conjunta")
            return { success = false, message = "Saldo insuficiente na conta conjunta", type = "error" }
        end
        
        local newBalance = balance - amount
        vRP.execute("bank/updateJointAccountBalance", {
            account_id = tonumber(accountId),
            balance = newBalance
        })
        
        -- Gerar item "dollars" de acordo com o valor sacado
        vRP.giveInventoryItem(user_id, "dollars", amount, true)
        print("^3[FORTAL_BANK] Item 'dollars' gerado:", amount)
        
        -- Registrar transação na conta conjunta
        registerTransaction(user_id, "Saque", amount, "Saque", "joint", tonumber(accountId))
        
        -- Salvar histórico de saldo da conta conjunta
        saveBalanceHistory(user_id, newBalance, "joint", tonumber(accountId))
        
        print("^2[FORTAL_BANK] Saque de conta conjunta realizado:", amount, "Saldo atual:", newBalance)

        -- Enviar notificação para o client
        clientAPI.showNotification(source, "success", "Saque realizado com sucesso! R$ " .. amount)
        
        return {
            success = true,
            message = "Você sacou R$ " .. amount .. " da conta conjunta",
            type = "success",
            newBalance = newBalance
        }
    else
        -- Saque de conta pessoal (lógica original)
        print("^3[FORTAL_BANK] Saque de conta pessoal")
        
        -- Verificar saldo atual no banco
        local bank = vRP.getBank(user_id) or 0
        print("^3[FORTAL_BANK] Saldo atual no banco:", bank, "Valor solicitado:", amount)
        
        if bank < amount then
            print("^1[FORTAL_BANK] Saldo insuficiente no banco")
            return { success = false, message = "Saldo insuficiente no banco", type = "error" }
        end

        -- Calcular novo saldo: saldo - saque
        local newBalance = bank - amount
        print("^3[FORTAL_BANK] Novo saldo calculado:", newBalance)

        -- Atualizar saldo no banco usando consulta direta
        vRP.execute("bank/SetBank", { user_id = user_id, bank = newBalance })
        print("^3[FORTAL_BANK] Saldo atualizado no banco para:", newBalance)

        -- Gerar item "dollars" de acordo com o valor sacado
        vRP.giveInventoryItem(user_id, "dollars", amount, true)
        print("^3[FORTAL_BANK] Item 'dollars' gerado:", amount)

        -- Registrar transação
        registerTransaction(user_id, "Saque de conta", amount, "Saque", "personal", nil)

        -- Salvar histórico de saldo
        saveBalanceHistory(user_id, newBalance, "personal", nil)

        print("^2[FORTAL_BANK] Saque realizado:", amount, "para user_id:", user_id)

        -- Enviar notificação para o client
        clientAPI.showNotification(source, "success", "Saque realizado com sucesso! R$ " .. amount)

        return {
            success = true,
            message = "Você sacou R$ " .. amount,
            type = "success",
            newBalance = newBalance
        }
    end
end