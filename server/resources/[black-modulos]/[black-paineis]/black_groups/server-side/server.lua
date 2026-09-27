Utils.functions.prepare("black/getOrgData", "SELECT * FROM `bsgroupmanager-orgs` WHERE orgName = @orgName")
Utils.functions.prepare("black/getOrgMembers", "SELECT * FROM `bsgroupmanager-members` WHERE orgName = @orgName")
Utils.functions.prepare("black/getOrgMember",
    "SELECT * FROM `bsgroupmanager-members` WHERE `user_id` = @user_id")
Utils.functions.prepare("black/verifyMemberHasOrg",
    "SELECT * FROM `bsgroupmanager-members` WHERE `user_id` = @user_id")
Utils.functions.prepare("black/updateMemberGroup",
    "UPDATE `bsgroupmanager-members` SET `group` = @group WHERE orgName = @orgName AND `user_id` = @user_id")
Utils.functions.prepare("black/updateMemberImage",
    "UPDATE `bsgroupmanager-members` SET image = @image WHERE orgName = @orgName AND `user_id` = @user_id")
Utils.functions.prepare("black/updateMemberLogin",
    "UPDATE `bsgroupmanager-members` SET lastLogin = @lastLogin WHERE orgName = @orgName AND `user_id` = @user_id")
Utils.functions.prepare("black/getChestLogs", "SELECT * FROM `bsgroupmanager-logs` WHERE orgName = @orgName")
Utils.functions.prepare("black/getOrgAnnounces", "SELECT * FROM `bsgroupmanager-announces` WHERE orgName = @orgName")
Utils.functions.prepare("black/insertAnnounce",
    "INSERT IGNORE INTO `bsgroupmanager-announces` (orgName,user_id,title,description) VALUES (@orgName,@user_id,@title,@description)")
Utils.functions.prepare("black/setAnnounce",
    "UPDATE `bsgroupmanager-announces` SET user_id = @user_id,title = @title,description = @description WHERE orgName = @orgName")
Utils.functions.prepare("black/insertMember",
    "INSERT IGNORE INTO `bsgroupmanager-members` (user_id,name,`group`,orgName,image,lastLogin) VALUES (@user_id,@name,@group,@orgName,@image,@lastLogin)")
Utils.functions.prepare("black/removeMember",
    "DELETE FROM `bsgroupmanager-members` WHERE orgName = @orgName AND user_id = @user_id")
Utils.functions.prepare("black/deleteOrg",
    "DELETE FROM `bsgroupmanager-orgs` WHERE orgName = @orgName")
Utils.functions.prepare("black/deleteUserLogs",
    "DELETE FROM `bsgroupmanager-logs` WHERE orgName = @orgName AND user_id = @user_id")
Utils.functions.prepare("black/getOrgLogs",
    "SELECT * FROM `bsgroupmanager-logs` WHERE orgName = @orgName AND `type` = @type")
Utils.functions.prepare("black/depositMoney",
    "UPDATE `bsgroupmanager-orgs` SET bank = bank + @value WHERE orgName = @orgName")
Utils.functions.prepare("black/withdrawMoney",
    "UPDATE `bsgroupmanager-orgs` SET bank = bank - @value WHERE orgName = @orgName")
Utils.functions.prepare("black/getUserLogs",
    "SELECT * FROM `bsgroupmanager-logs` WHERE orgName = @orgName AND user_id = @user_id")
Utils.functions.prepare("black/createOrg",
    "INSERT IGNORE INTO `bsgroupmanager-orgs` (orgName,bank,founder) VALUES (@orgName,@bank,@founder)")
Utils.functions.prepare("black/insertLog",
    "INSERT IGNORE INTO `bsgroupmanager-logs` (orgName,type,user_id,name,action,item,value,date) VALUES (@orgName,@type,@user_id,@name,@action,@item,@value,@date)")
Utils.functions.prepare("black/getFarms", "SELECT * FROM `bsgroupmanager-farms` WHERE orgName = @orgName")
Utils.functions.prepare("black/getUsersFinishedTask",
    "SELECT users_finished FROM `bsgroupmanager-farms` WHERE orgName = @orgName AND taskId = @taskId")
Utils.functions.prepare("black/saveFarm",
    "INSERT IGNORE INTO `bsgroupmanager-farms` (orgName,taskId,title,item,amount,gift,date,users_finished) VALUES (@orgName,@taskId,@title,@item,@amount,@gift,@date,@users_finished)")
Utils.functions.prepare("black/setTaskFinished",
    "UPDATE `bsgroupmanager-farms` SET users_finished = @users_finished WHERE orgName = @orgName AND taskId = @taskId")
Utils.functions.prepare("black/insertNewBlacklistMember",
    "INSERT IGNORE INTO `bsgroupmanager-blacklist` (user_id,removed_in) VALUES (@user_id,@removed_in)")
Utils.functions.prepare("black/getBlacklistedMember",
    "SELECT * FROM `bsgroupmanager-blacklist` WHERE user_id = @user_id")
Utils.functions.prepare("black/deleteMemberFromBlacklist",
    "DELETE FROM `bsgroupmanager-blacklist` WHERE user_id = @user_id")
Utils.functions.prepare("black/insertNewChest",
    "INSERT IGNORE INTO `chests` (name, weight, perm) VALUES (@name, @weight, @perm)")
Utils.functions.prepare("black/insertNewCustomChest",
    "INSERT IGNORE INTO `chests` (name, weight, perm, coords) VALUES (@name, @weight, @perm, @coords)")
Utils.functions.prepare("black/getChests","SELECT * from `chests`")
Utils.functions.prepare("black/insertNewFounderChest",
    "INSERT IGNORE INTO `founders_chests` (founder_id, name, weight, perm) VALUES (@founder_id, @name, @weight, @perm)")
Utils.functions.prepare("black/deleteChest",
    "DELETE FROM `chests` WHERE perm = @perm")
Utils.functions.prepare("black/deleteFounderChest",
    "DELETE FROM `founders_chests` WHERE perm = @perm")
Utils.functions.prepare("black/getPlayerDatatable",
    "SELECT dvalue FROM `playerdata` WHERE user_id = @user_id AND dkey = 'Datatable'")
Utils.functions.prepare("black/updatePlayerDatatable",
    "UPDATE playerdata SET dvalue = @data WHERE user_id = @user_id AND dkey = 'Datatable'")
Utils.functions.prepare("black/getOrgChests","SELECT * FROM `chests`")

local activated = {}

local adminAccess = {}

function hasPermission(user_id)
    local r = async()
    for k, v in pairs(Config.orgs) do
        if v.permission ~= nil then
            if Utils.functions.hasPermission(user_id, v.permission) then
                r(true, k)
                return r:wait()
            end
        end
    end
    r(nil)
    return r:wait()
end

function hasManagementPermission(orgName, user_id)
    local r = async()
    local query = Utils.functions.query("black/getOrgMember", { orgName = orgName, user_id = user_id })
    if #query > 0 then
        for k, v in pairs(Config.orgs[orgName].managementPerms) do
            if Config.orgs[orgName].groups[tonumber(query[1].group)] == v then
                r(true)
                return r:wait()
            end
        end
    end
    r(nil)
    return r:wait()
end

function src.hasManagerPermission()
    local source = source 
    local user_id = Utils.functions.getUserId(source) 
    if user_id then 
        local query = Utils.functions.query("black/getOrgMember", {
            user_id = user_id,
        })

        if #query > 0 then
            local orgName = query[1].orgName 
            for k, v in pairs(Config.orgs[orgName].managementPerms) do
                if Config.orgs[orgName].groups[tonumber(query[1].group)] == v then
                    return true 
                end
            end
        elseif adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then 
            return true 
        end
    end
    return false 
end 

function src.removeAdminAccessRegister()
    local source = source
    local user_id = Utils.functions.getUserId(source)

    if adminAccess[tostring(user_id)] and adminAccess[tostring(user_id)].user_id == user_id then
        adminAccess[tostring(user_id)] = nil
    end
end

function getUserRoleNumber(orgName, user_id)
    local r = async()
    local query = Utils.functions.query("black/getOrgMember", { orgName = orgName, user_id = user_id })
    if #query > 0 then
        r(tonumber(query[1].group))
        return r:wait()
    end
    r(nil)
    return r:wait()
end

function hasMaxPermission(orgName, user_id)
    local r = async()
    local query = Utils.functions.query("black/getOrgMember", { orgName = orgName, user_id = user_id })
    if #query > 0 then
        if tonumber(query[1].group) == 1 or tonumber(query[1].group) == 2 then
            r(true)
            return r:wait()
        end
    end
    r(nil)
    return r:wait()
end

function getOrgFounder(orgName)
    local r = async()
    local query = Utils.functions.query("black/getOrgData", { orgName = orgName })
    if #query > 0 then
        r(query[1].founder)
    else
        r(nil)
    end
    return r:wait()
end

function getOrgMembersActive(orgName)
    local r = async()
    local query = Utils.functions.query("black/getOrgMembers", { orgName = orgName })
    local arr = {}
    if #query > 0 then
        for k, v in pairs(query) do
            if Utils.functions.getUserSource(v.user_id) then
                arr[#arr + 1] = v.user_id
            end
        end
    end
    r(#arr)
    return r:wait()
end

function getOrgBankLogs(orgName)
    local r = async()
    local query = Utils.functions.query("black/getOrgLogs", { orgName = orgName, type = "bank" })
    local arr = {}
    if #query > 0 then
        for k, v in pairs(query) do
            arr[#arr + 1] = {
                name = Utils.functions.getUserName(v.user_id),
                type = v.action,
                id = v.user_id,
                value = v.value,
                data = v.date
            }
        end
    end
    r(arr)
    return r:wait()
end

function getOrgChestLogs(orgName)
    local r = async()
    local query = Utils.functions.query("black/getOrgLogs", { orgName = orgName, type = "chest" })
    local arr = {}
    if #query > 0 then
        for k, v in pairs(query) do
            arr[#arr + 1] = {
                type = v.action,
                item = v.item,
                qtd = v.value,
                id = v.user_id,
                data = v.date
            }
        end
    end
    r(arr)
    return r:wait()
end

function getOrgBankValue(orgName)
    local r = async()
    local query = Utils.functions.query("black/getOrgData", { orgName = orgName })
    if #query > 0 then
        r(query[1].bank)
    else
        r(0)
    end
    return r:wait()
end

function getUserLogs(user_id, orgName)
    local r = async()
    local query = Utils.functions.query("black/getUserLogs", { orgName = orgName, user_id = user_id })
    local arr = {}
    if #query > 0 then
        for k, v in pairs(query) do
            arr[#arr + 1] = {
                type = v.type,
                action = v.action,
                user_id = v.user_id,
                item = v.item ~= "" and Utils.functions.getItemName(v.item) or nil,
                value = v.item ~= "" and tostring(v.value) or v.value,
                data = v.date
            }
        end
    end
    r(arr)
    return r:wait()
end

function saveBankLogs(user_id, orgName, action, value)
    Utils.functions.execute("black/insertLog", {
        orgName = orgName,
        type = "bank",
        user_id = user_id,
        name = Utils.functions.getUserName(user_id),
        action = action,
        value = value,
        date = getFormatedDate()
    })
end

function saveChestLogs(user_id, orgName, action, item, value)
    Utils.functions.execute("black/insertLog", {
        orgName = orgName,
        type = "chest",
        user_id = user_id,
        name = Utils.functions.getUserName(user_id),
        action = action,
        item = item,
        value = value,
        date = getFormatedDate()
    })
end

function getFormatedDate()
    return os.date("%d/%m/%Y", os.time())
end

function getLastLogin()
    return os.date("%d/%m/%Y ás %H:%M", os.time())
end

function generateTaskId()
    local letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local code = ""

    math.randomseed(os.time())

    for i = 1, 8 do
        local index = math.random(1, #letters)
        code = code .. letters:sub(index, index)
    end

    return code
end

function parseJsonString(str)
    local tbl = {}
    for k, v in string.gmatch(str, '"(%d+)":(%w+)') do
        tbl[k] = (v == "true")
    end
    return tbl
end

function verifyTask(user_id, orgName, taskId)
    local r = async()
    local query = Utils.functions.query("black/getUsersFinishedTask", { orgName = orgName, taskId = taskId })
    if #query > 0 then
        for k, v in pairs(parseJsonString(query[1].users_finished)) do
            if tonumber(k) == user_id then
                r(true)
                return r:wait()
            end
        end
    end
    r(false)
    return r:wait()
end

function setUserFinishedTask(user_id, orgName, taskId)
    if not user_id then return end
    local query = Utils.functions.query("black/getUsersFinishedTask", { orgName = orgName, taskId = taskId })
    if #query > 0 then
        local data = parseJsonString(query[1].users_finished)
        data[tostring(user_id)] = true
        Utils.functions.execute("black/setTaskFinished",
            { orgName = orgName, taskId = taskId, users_finished = tostring(json.encode(data)) })
    end
end

function formatCurrency(n)
    local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
    return left .. (num:reverse():gsub('(%d%d%d)', '%1.'):reverse()) .. right
end

function getRoleByName(orgName, role)
    for k, v in pairs(Config.orgs[orgName].groups) do
        if v == role then
            return k
        end
    end
end

function convertDateToTimestamp(dateString)
    local day, month, year = dateString:match("(%d%d)/(%d%d)/(%d%d%d%d)")
    return os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = 0,
        min = 0,
        sec = 0
    })
end

function verifyDateLimit(currentDate, targetDate)
    if currentDate.year < targetDate.year then
        return true
    elseif currentDate.year == targetDate.year then
        if currentDate.month < targetDate.month then
            return true
        elseif currentDate.month == targetDate.month then
            return currentDate.day <= targetDate.day
        end
    end
    return false
end

function convertDateToComponents(dateStr)
    local day, month, year = dateStr:match("^(%d%d)/(%d%d)/(%d%d%d%d)$")
    if not day or not month or not year then
        return nil
    end

    return {
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day)
    }
end

function isValidDateFormat(date)
    date = date:match("^%s*(.-)%s*$")
    local day, month, year = date:match("^(%d%d)/(%d%d)/(%d%d%d%d)$")
    if not day or not month or not year then
        return false
    end
    return true, tonumber(day), tonumber(month), tonumber(year)
end

function src.checkOrgExists(orgName)
    local query = Utils.functions.query("black/getOrgData", { orgName = orgName })
    return #query > 0
end

function src.getCurrentOrg()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local query = Utils.functions.query("black/getOrgMember", {
        user_id = user_id,
    })

    if adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
        return adminAccess[tostring(user_id)].orgName
    end
    
    local query = Utils.functions.query("black/getOrgMember", {
        user_id = user_id,
    })
    
    if user_id and query and #query > 0 then
        return query[1].orgName
    end
    
end

function src.getOrgMembers(orgName)
    local r = async()
    local query = Utils.functions.query("black/getOrgMembers", { orgName = orgName })
    local arr = {}
    if #query > 0 then
        for k, v in pairs(query) do
            arr[#arr + 1] = {
                name = Utils.functions.getUserName(v.user_id),
                patent = Config.orgs[orgName].groups[tonumber(v.group)],
                id = v.user_id,
                stats = Utils.functions.getUserSource(v.user_id) and true or false,
                login = v.lastLogin,
                groupOrder = tonumber(v.group)
            }
        end

        table.sort(arr, function(a, b)
            return a.groupOrder < b.groupOrder
        end)
    end

    r(arr)
    return r:wait()
end

function src.getInfosFromUser(user_id)
    local r = async()
    local inOrg, orgName = hasPermission(user_id)
    local arr = {}
    if inOrg and orgName ~= "" then
        local query = Utils.functions.query("black/getOrgMember", { orgName = orgName, user_id = user_id })
        if #query > 0 then
            for _, v in pairs(query) do
                arr = {
                    image = v.image,
                    id = v.user_id,
                    name = Utils.functions.getUserName(v.user_id),
                    gender = Utils.functions.getUserIdentity(v.user_id).sex == "M" and "Masculino" or "Feminino",
                    number = Utils.functions.getUserIdentity(v.user_id).number,
                    patent = Config.orgs[orgName].groups[tonumber(v.group)],
                    nationality = Utils.functions.getUserIdentity(v.user_id).nationality,
                    bank = Utils.functions.getUserIdentity(v.user_id).bank,
                    logs = getUserLogs(v.user_id, orgName)
                }
            end
        end
    elseif adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
        local query = Utils.functions.query("black/getOrgMember", { orgName = adminAccess[tostring(user_id)].orgName, user_id = user_id })
        if #query > 0 then
            for _, v in pairs(query) do
                arr = {
                    image = v.image,
                    id = v.user_id,
                    name = Utils.functions.getUserName(v.user_id),
                    gender = Utils.functions.getUserIdentity(v.user_id).sex == "M" and "Masculino" or "Feminino",
                    number = Utils.functions.getUserIdentity(v.user_id).number,
                    patent = "Admin",
                    nationality = Utils.functions.getUserIdentity(v.user_id).nationality,
                    bank = Utils.functions.getUserIdentity(v.user_id).bank,
                    logs = {}
                }
            end
        end
    end
    r(arr)
    return r:wait()
end

function src.promoteMember(orgName, nuser_id)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local user_identity = Utils.functions.getUserIdentity(user_id)
    local nuser_identity = Utils.functions.getUserIdentity(nuser_id)
    if user_id then
        if nuser_id ~= user_id then
            if hasManagementPermission(orgName, user_id) or adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
                if os.time() >= parseInt(activated[user_id]) then
                    activated[user_id] = os.time() + 5
                    if not hasManagementPermission(orgName, nuser_id) or hasMaxPermission(orgName, user_id) or adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
                        local query = Utils.functions.query("black/getOrgMember",{ orgName = orgName, user_id = nuser_id })
                        if #query > 0 then
                            query[1].group = query[1].group - 1
                            if query[1].group < 0 then
                                query[1].group = 1
                            end

                            Utils.functions.addGroup(nuser_id,Config.orgs[orgName].permission,tonumber(query[1].group))
                            Utils.functions.execute("black/updateMemberGroup",{ orgName = orgName, user_id = nuser_id, group = query[1].group })

                            exports["config"]:SendLog("AddGroup", { id = user_id, name = user_identity.name, surname = user_identity.name2 }, { id = user_id, name = nuser_identity.name, surname = nuser_identity.name2 }, { [1] = orgName .. Config.orgs[orgName].groups[tonumber(query[1].group)] })

                            collectgarbage("collect")
                            return true
                        end
                    end
                else
                    Utils.functions.notify(source, Config.messages["wait_seconds"])
                end
            else
                Utils.functions.notify(source, Config.messages["not_has_permission_in_org"])
            end
        end
    end
end

function src.lowerMember(orgName, nuser_id)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local user_identity = Utils.functions.getUserIdentity(user_id)
    local nuser_identity = Utils.functions.getUserIdentity(nuser_id)
    if user_id then
        if nuser_id ~= user_id then
            if hasManagementPermission(orgName, user_id) or adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
                if os.time() >= parseInt(activated[user_id]) then
                    activated[user_id] = os.time() + 5
                    if not hasManagementPermission(orgName, nuser_id) then
                        local query = Utils.functions.query("black/getOrgMember",{ orgName = orgName, user_id = nuser_id })
                        if #query > 0 then
                            query[1].group = query[1].group + 1
                            if query[1].group > #Config.orgs[orgName].groups then
                                query[1].group = #Config.orgs[orgName].groups
                            end
                            Utils.functions.addGroup(nuser_id, Config.orgs[orgName].permission, tonumber(query[1].group))
                            Utils.functions.execute("black/updateMemberGroup",
                                { orgName = orgName, user_id = nuser_id, group = query[1].group })

                            exports["config"]:SendLog("RemGroup", { id = user_id, name = user_identity.name, surname = user_identity.name2 }, { id = user_id, name = nuser_identity.name, surname = nuser_identity.name2 }, { [1] = orgName .. Config.orgs[orgName].groups[tonumber(query[1].group)] })

                            collectgarbage("collect")
                            return true
                        end
                    elseif hasMaxPermission(orgName, user_id) then
                        local query = Utils.functions.query("black/getOrgMember",
                            { orgName = orgName, user_id = nuser_id })
                        if #query > 0 then
                            query[1].group = query[1].group + 1
                            if query[1].group > #Config.orgs[orgName].groups then
                                query[1].group = #Config.orgs[orgName].groups
                            end
                            Utils.functions.addGroup(nuser_id, Config.orgs[orgName].permission, tonumber(query[1].group))
                            Utils.functions.execute("black/updateMemberGroup",
                                { orgName = orgName, user_id = nuser_id, group = query[1].group })

                            exports["config"]:SendLog("RemGroup", { id = user_id, name = user_identity.name, surname = user_identity.name2 }, { id = user_id, name = nuser_identity.name, surname = nuser_identity.name2 }, { [1] = orgName .. Config.orgs[orgName].groups[tonumber(query[1].group)] })

                            collectgarbage("collect")
                            return true
                        end
                    elseif adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
                        local query = Utils.functions.query("black/getOrgMember",
                            { orgName = orgName, user_id = nuser_id })
                        if #query > 0 then
                            query[1].group = query[1].group + 1
                            if query[1].group > #Config.orgs[orgName].groups then
                                query[1].group = #Config.orgs[orgName].groups
                            end
                            Utils.functions.addGroup(nuser_id, Config.orgs[orgName].permission, tonumber(query[1].group))
                            Utils.functions.execute("black/updateMemberGroup",{ orgName = orgName, user_id = nuser_id, group = query[1].group })

                            exports["config"]:SendLog("RemGroup", { id = user_id, name = user_identity.name, surname = user_identity.name2 }, { id = user_id, name = nuser_identity.name, surname = nuser_identity.name2 }, { [1] = orgName .. Config.orgs[orgName].groups[tonumber(query[1].group)] })

                            collectgarbage("collect")
                            return true
                        end
                    end
                else
                    Utils.functions.notify(source, Config.messages["wait_seconds"])
                end
            else
                Utils.functions.notify(source, Config.messages["not_has_permission_in_org"])
            end
        end
    end
end

function src.dismissPlayer(orgName, nuser_id)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local user_identity = Utils.functions.getUserIdentity(user_id)
    local nuser_identity = Utils.functions.getUserIdentity(nuser_id)
    if user_id then
        if nuser_id ~= user_id then
            local query = Utils.functions.query("black/getOrgMember", { orgName = orgName, user_id = nuser_id })
            if #query > 0 then
                if hasManagementPermission(orgName, user_id) or adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
                    local userRole = getUserRoleNumber(orgName, user_id)
                    local nuserRole = getUserRoleNumber(orgName, nuser_id)

                    if adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id or nuserRole > userRole then
                        if (not hasManagementPermission(orgName, nuser_id)) or hasMaxPermission(orgName, user_id) or adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
                            Utils.functions.execute("black/removeMember", { orgName = orgName, user_id = nuser_id })
                            Utils.functions.execute("black/deleteUserLogs", { orgName = orgName, user_id = nuser_id })
                            Utils.functions.execute("black/insertNewBlacklistMember", { user_id = nuser_id,removed_in = os.time() })
                            Utils.functions.remGroup(nuser_id, Config.orgs[orgName].permission)

                            exports["config"]:SendLog("RemGroup", { id = user_id, name = user_identity.name, surname = user_identity.name2 }, { id = user_id, name = nuser_identity.name, surname = nuser_identity.name2 }, { [1] = orgName })

                            local nsrc = Utils.functions.getUserSource(nuser_id)
                            if nsrc then 
                                Utils.functions.notify(nsrc,string.format(Config.messages["kicked_from_org"],orgName))
                            end

                            return true
                        end
                    end
                else
                    Utils.functions.notify(source, Config.messages["not_has_permission_in_org"])
                end
            end
        end
    end
    return false
end

function src.getOrgAnnounces(orgName)
    local r = async()
    local query = Utils.functions.query("black/getOrgAnnounces", { orgName = orgName })
    local arr = {}
    if #query > 0 then
        for _, v in pairs(query) do
            arr = {
                user_name = Utils.functions.getUserName(v.user_id),
                title = v.title,
                description = v.description
            }
        end
    end
    r(arr)
    return r:wait()
end

function src.saveAnnounce(orgName, title, description)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        local query = Utils.functions.query("black/getOrgAnnounces", { orgName = orgName })
        if hasManagementPermission(orgName, user_id) or adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
            if #query > 0 then
                Utils.functions.execute("black/setAnnounce",
                    { user_id = user_id, orgName = orgName, title = title, description = description })
                return true
            else
                Utils.functions.execute("black/insertAnnounce",
                    { user_id = user_id, orgName = orgName, title = title, description = description })
                return true
            end
        end
    end
end

function src.inviteUser(orgName, nuser_id, role)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local user_identity = Utils.functions.getUserIdentity(user_id)
    local nuser_identity = Utils.functions.getUserIdentity(nuser_id)
    if user_id and nuser_id ~= user_id then
        local userRole = getUserRoleNumber(orgName, user_id)
        local nuserRole = getRoleByName(orgName, role)

        local inOrg = Utils.functions.execute("black/verifyMemberHasOrg", {
            user_id = nuser_id,
        })

        local blacklisted = Utils.functions.execute("black/getBlacklistedMember", {
            user_id = nuser_id,
        })

        local now = os.time()

        local blacklistTime = Config.blacklistTime * 24 * 60 * 60

        if next(inOrg) == nil and next(blacklisted) == nil or now - blacklisted[1].removed_in > blacklistTime and next(inOrg) == nil  then
            if hasManagementPermission(orgName, user_id) and (nuserRole ~= 1 and nuserRole > userRole) then
                local nuser_src = Utils.functions.getUserSource(nuser_id)
                if nuser_src then
                    if Utils.functions.request(nuser_src, string.format(Config.messages["invite_request"], orgName)) then
                        Utils.functions.addGroup(nuser_id, Config.orgs[orgName].permission)
                        Utils.functions.execute("black/insertMember", {
                            user_id = nuser_id,
                            name = Utils.functions.getUserName(nuser_id),
                            group = getRoleByName(orgName, role),
                            image = "",
                            orgName = orgName,
                            lastLogin = getLastLogin()
                        })
                        Utils.functions.notify(nuser_src, string.format(Config.messages["accept_request"], orgName))
                        Utils.functions.execute("black/addInvites",{ orgName = orgName })

                        exports["config"]:SendLog("AddGroup", { id = user_id, name = user_identity.name, surname = user_identity.name2 }, { id = user_id, name = nuser_identity.name, surname = nuser_identity.name2 }, { [1] = orgName })

                        return true
                    else
                        Utils.functions.notify(source, Config.messages["invite_denied"])
                    end
                end
            elseif adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
                local nuser_src = Utils.functions.getUserSource(nuser_id)
                if nuser_src then
                    if Utils.functions.request(nuser_src, string.format(Config.messages["invite_request"], orgName)) then
                        Utils.functions.addGroup(nuser_id, Config.orgs[orgName].permission)
                        Utils.functions.execute("black/insertMember", {
                            user_id = nuser_id,
                            name = Utils.functions.getUserName(nuser_id),
                            group = getRoleByName(orgName, role),
                            image = "",
                            orgName = orgName,
                            lastLogin = getLastLogin()
                        })
                        Utils.functions.notify(nuser_src, string.format(Config.messages["accept_request"], orgName))
                        Utils.functions.execute("black/addInvites",{ orgName = orgName })

                        exports["config"]:SendLog("AddGroup", { id = user_id, name = user_identity.name, surname = user_identity.name2 }, { id = user_id, name = nuser_identity.name, surname = nuser_identity.name2 }, { [1] = orgName })

                        return true
                    else
                        Utils.functions.notify(source, Config.messages["invite_denied"])
                    end
                end
            else
                Utils.functions.notify(source, Config.messages["not_has_permission_in_org"])
            end
        else
            local timePassed = now - blacklisted[1].removed_in
            local timeRemaining = blacklistTime - timePassed
            local daysRemaining = math.ceil(timeRemaining / (24 * 60 * 60))

            Utils.functions.notify(source, string.format(Config.messages["has_org_or_blacklisted"], daysRemaining))
        end
    end
end

function src.getBankData(orgName)
    local source = source
    local r = async()
    local user_id = Utils.functions.getUserId(source)
    local query = Utils.functions.execute("black/getOrgData", { orgName = orgName })
    local arr = {}
    if user_id then
        if #query > 0 then
            local orgFounder = getOrgFounder(orgName)
            local orgMembersActive = getOrgMembersActive(orgName)
            local orgBankLogs = getOrgBankLogs(orgName)
            arr = {
                name = Utils.functions.getUserName(user_id),
                founder = Utils.functions.getUserName(orgFounder),
                membersOn = orgMembersActive,
                maxMembers = Config.orgs[orgName].maxMembers,
                logs = orgBankLogs,
                balance = query[1].bank
            }
        end
    end
    r(arr)
    return r:wait()
end

function src.getOrgChestLogs(orgName)
    return getOrgChestLogs(orgName)
end

function src.depositMoney(orgName, value)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    value = parseInt(value)
    if user_id and os.time() >= parseInt(activated[user_id]) then
        activated[user_id] = os.time() + 5
        if Utils.functions.depositMethod(user_id, value) or adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
            Utils.functions.execute("black/depositMoney", { orgName = orgName, value = value })
            saveBankLogs(user_id, orgName, "deposit", value)
            return true
        else
            Utils.functions.notify(source, Config.messages["insuficient_money"])
        end
    end
end

function src.withdrawMoney(orgName, value)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local bankValue = getOrgBankValue(orgName)
    value = parseInt(value)
    if hasManagementPermission(orgName, user_id) then
        if user_id and os.time() >= parseInt(activated[user_id]) then
            activated[user_id] = os.time() + 5
            if bankValue >= value then
                Utils.functions.withdrawMethod(user_id, value)
                Utils.functions.execute("black/withdrawMoney", { orgName = orgName, value = value })
                saveBankLogs(user_id, orgName, "withdraw", value)
                return true
            else
                Utils.functions.notify(source, Config.messages["insuficient_balance"])
            end
        end
    else
        Utils.functions.notify(source, Config.messages["not_has_permission_in_org"])
    end
end

function src.transferMoney(orgName, nuser_id, value)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local bankValue = getOrgBankValue(orgName)
    value = parseInt(value)
    if user_id and os.time() >= parseInt(activated[user_id]) then
        activated[user_id] = os.time() + 5
        if bankValue >= value then
            Utils.functions.withdrawMethod(nuser_id, value)
            Utils.functions.execute("black/withdrawMoney", { orgName = orgName, value = value })
            saveBankLogs(user_id, orgName, "transfer", value)
            return true
        else
            Utils.functions.notify(source, Config.messages["insuficient_balance"])
        end
    end
end

function src.getOrgChestInfos(orgName)
    if orgName ~= nil then
        local currentWeight, maxWeight = Utils.functions.getOrgChestData(Config.orgs[orgName].chestName)
        if currentWeight and maxWeight then
            return { minAmount = math.floor(currentWeight), maxAmount = maxWeight }
        end
    end
end

function src.openChest(orgName)
    local source = source
    Utils.functions.openChest(source, Config.orgs[orgName].chestName)
    clientAPI.sendNuiMessage(source, { action = "setVisible", data = false }, false)
    Player(source).state:set("openedPanel", false, true)
end

function src.saveUserPhoto(orgName, nuser_id, urlImage)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if hasManagementPermission(orgName, user_id) or adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
            local query = Utils.functions.query("black/getOrgMember", { orgName = orgName, user_id = nuser_id })
            if #query > 0 then
                Utils.functions.execute("black/updateMemberImage", {
                    orgName = orgName,
                    user_id = nuser_id,
                    image = urlImage
                })
            end
        end
    end
end

function src.createOrg(orgName, founderId, initialBank, founderChest)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if Utils.functions.hasPermission(user_id, Config.adminPermission) then
            if Config.orgs[orgName] then
                
                if not src.checkOrgExists(orgName) then
                    Utils.functions.execute("black/createOrg", {
                        orgName = orgName,
                        bank = initialBank,
                        founder = founderId
                    })

                    Utils.functions.execute("black/insertMember", {
                        user_id = founderId,
                        name = Utils.functions.getUserName(founderId),
                        group = 1,
                        image = "",
                        orgName = orgName,
                        lastLogin = getLastLogin()
                    })

                    Utils.functions.addGroup(founderId, Config.orgs[orgName].permission,1)
                    Utils.functions.notify(source, string.format(Config.messages["new_org"], orgName))
                else
                    Utils.functions.notify(source, Config.messages["has_org"])
                end
            else
                Utils.functions.notify(source, Config.messages["unknown_org"])
            end
        else
            Utils.functions.notify(source, Config.messages["not_admin_permission"])
        end 
    end
end

function src.createChestOrg(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if Utils.functions.hasPermission(user_id, Config.adminPermission) then
            Utils.functions.execute("black/insertNewCustomChest", {
                name = data.name,
                weight = Config.defaultChestWeight,
                perm = data.permission,
                coords = json.encode(data.coords)
            })

            TriggerEvent("chest:trySyncChests")

            Utils.functions.notify(source, string.format(Config.messages["create_chest"], data.name))
        else
            Utils.functions.notify(source, Config.messages["not_admin_permission"])
        end
    end
end

function src.getOrgFarms(orgName)
    local r = async()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local query = Utils.functions.query("black/getFarms", { orgName = orgName })
    local arr = {}
    if #query > 0 then
        for _, v in pairs(query) do
            arr[#arr + 1] = {
                item = Utils.functions.getItemName(v.item),
                qtd = v.amount,
                taskId = v.taskId,
                completed = verifyTask(user_id, orgName, v.taskId),
                data = v.date,
                value = parseInt(v.gift)
            }
        end
    end
    r(arr)
    return r:wait()
end

function src.saveFarm(title, gift, item, amount, dateLimit, orgName)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if hasManagementPermission(orgName, user_id) or adminAccess[tostring(user_id)] and user_id == adminAccess[tostring(user_id)].user_id then
            local isValid, day, month, year = isValidDateFormat(dateLimit)

            if not isValid then
                Utils.functions.notify(source, Config.messages["unknown_date_format"])
                return false
            end

            local targetDate = {
                year = year,
                month = month,
                day = day
            }
            local currentDate = os.date("*t", os.time())

            if not verifyDateLimit(currentDate, targetDate) then
                Utils.functions.notify(source, Config.messages["exceeded_date"])
                return false
            end

            Utils.functions.execute("black/saveFarm", {
                orgName = orgName,
                taskId = generateTaskId(),
                title = title,
                item = item,
                amount = amount,
                gift = gift,
                date = date,
                users_finished = "{}"
            })
            return true
        end
    end
end

function src.rewardTaskGift(orgName, taskId)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local query = Utils.functions.query("black/getFarms", { orgName = orgName })
    local balance = Utils.functions.query("black/getOrgData", { orgName = orgName })[1].bank
    if #query > 0 then
        for _, v in pairs(query) do
            if v.taskId == taskId then
                if not verifyTask(user_id, orgName, taskId) then
                    local currentDate = os.date("*t", os.time())
                    local targetDateComponents = convertDateToComponents(v.date)
                    if verifyDateLimit(currentDate, targetDateComponents) then
                        if balance >= parseInt(v.gift) then
                            if Config.orgs[orgName].chestName ~= "" and Config.orgs[orgName].chestName ~= nil then
                                if Utils.functions.checkItem(user_id, v.item, v.amount) then
                                    Utils.functions.execute("black/withdrawMoney",
                                        { orgName = orgName, value = v.gift })
                                    Utils.functions.setTaskItemsOnChest(user_id, Config.orgs[orgName].chestName,
                                        v.item,
                                        v.amount)
                                    Utils.functions.withdrawMethod(user_id, parseInt(v.gift))
                                    setUserFinishedTask(user_id, orgName, taskId)
                                    saveChestLogs(user_id, orgName, "enter", v.item, v.amount)
                                    saveBankLogs(user_id, orgName, "withdraw", parseInt(v.gift))
                                    Utils.functions.notify(source,
                                        string.format(Config.messages["finished_task"], formatCurrency(v.gift)))
                                    return true
                                else
                                    Utils.functions.notify(source, Config.messages["insuficient_item"])
                                end
                            end
                        else
                            Utils.functions.notify(source, Config.messages["finish_task_denied"])
                        end
                    else
                        Utils.functions.notify(source, Config.messages["task_limit"])
                        setUserFinishedTask(user_id, orgName, taskId)
                        return true
                    end
                else
                    Utils.functions.notify(source, Config.messages["have_collected"])
                end
            end
        end
    end
    return false
end

RegisterNetEvent("black-groupmanager:updateLastLogin")
AddEventHandler("black-groupmanager:updateLastLogin", function(user_id)
    local inOrg, orgName = hasPermission(user_id)
    if inOrg and orgName ~= "" then
        Utils.functions.execute("black/updateMemberLogin", {
            user_id = user_id,
            orgName = orgName,
            lastLogin = getLastLogin()
        })
        return true
    end
end)

RegisterCommand(Config.panelCommand, function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)

    local org = Utils.functions.query("black/getOrgMember", {
        user_id = user_id,
    })

    if next(org) ~= nil then
        clientAPI.sendNuiMessage(source, { action = "show:create", data = false }, true)
        clientAPI.sendNuiMessage(source, { action = "setVisible", data = true }, true)
        clientAPI.tabletAnim(source)
        Player(source).state:set("openedPanel", true, true)
    else
        Utils.functions.notify(source, Config.messages["not_has_org"])
    end
end)

RegisterCommand(Config.createOrgCommand, function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if Utils.functions.hasPermission(user_id, Config.adminPermission) then
            clientAPI.sendNuiMessage(source, { action = "setVisible", data = true }, true)
            clientAPI.sendNuiMessage(source, { action = "show:create", data = true }, true)
        else
            Utils.functions.notify(source, Config.messages["not_admin_permission"])
        end 
    end
end)

RegisterCommand(Config.deleteOrgCommand, function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if args[1] then
            if Utils.functions.hasPermission(user_id, Config.adminPermission) then
                if Config.orgs[args[1]] then
                    if Utils.functions.request(source, string.format(Config.messages["request_delorg"], args[1])) then 
                        local members = Utils.functions.query("black/getOrgMembers", {
                            orgName = args[1]
                        })

                        for _, value in pairs(members) do
                            if value["orgName"] == args[1] then
                                Utils.functions.remGroup(value["user_id"], args[1])
                                Utils.functions.remGroup(value["user_id"], "wait" .. args[1])

                                Utils.functions.execute("black/removeMember", {
                                    orgName = args[1],
                                    user_id = value["user_id"]
                                })

                                local nsrc = Utils.functions.getUserSource(value["user_id"])
                                if nsrc then 
                                    Utils.functions.notify(nsrc,string.format(Config.messages["kicked_from_org"],args[1]))
                                end
                            end
                        end

                        Utils.functions.execute("black/deleteOrg", {
                            orgName = args[1]
                        })

                        Utils.functions.notify(source,string.format(Config.messages["del_org"], args[1]))
                    end
                else
                    Utils.functions.notify(source, Config.messages["unknown_org"])
                end
            else
                Utils.functions.notify(source, Config.messages["not_admin_permission"])
            end
        else
            Utils.functions.notify(source, Config.messages["missing_args"])
        end
    end
end)

RegisterCommand(Config.adminOrgPanelCommand, function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    
    if args[1] then
        if Utils.functions.hasPermission(user_id, Config.adminPermission) then
            adminAccess[tostring(user_id)] = { user_id = user_id, orgName = args[1] }
    
            clientAPI.sendNuiMessage(source, { action = "setVisible", data = true }, true)

            clientAPI.tabletAnim(source)

            Player(source).state:set("openedPanel", true, true)
        else
            Utils.functions.notify(source, Config.messages["not_permission"])
        end
    else
        Utils.functions.notify(source, Config.messages["missing_args"])
    end
end)

RegisterCommand(Config.panelCreateChestCommand, function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)

    if Utils.functions.hasPermission(user_id, Config.adminPermission) then
        clientAPI.sendNuiMessage(source, { action = "show:chestCreate", data = true }, true)
        clientAPI.tabletAnim(source)
        Player(source).state:set("openedPanel", true, true)
    else
        Utils.functions.notify(source, Config.messages["not_permission"])
    end 
end)

RegisterCommand(Config.removeBlacklistCommand, function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)

    if args[1] then
        if Utils.functions.hasPermission(user_id, Config.adminPermission) then
            Utils.functions.execute("black/deleteMemberFromBlacklist", {
                user_id = args[1]
            })
        else
            Utils.functions.notify(source, Config.messages["not_permission"])
        end
    else
        Utils.functions.notify(source, Config.messages["missing_args"])
    end
end)
