-- =====================================================
-- HUD SERVER — Profile
-- =====================================================
-- client-side/profile.lua chama vSERVER.GetProfileData / UpdateProfileData / RelatePlayer.
-- Não existe uma tabela SQL dedicada a perfil nesta base — em vez de criar uma, reaproveita
-- o mesmo armazém genérico que battlepass.lua já usa (`playerdata`, via vRP.SimpleData /
-- "playerdata/SetData"), só que com a chave "Profile".
-- =====================================================

local ProfileFieldLimits = {
	avatar = 512,
	banner = 512,
	discord = 64,
	instagram = 64,
	description = 500
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEPROFILE
-----------------------------------------------------------------------------------------------------------------------------------------
local function SaveProfile(Passport,Profile)
	vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Profile", Information = json.encode(Profile) })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPROFILEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
-- `Entity` chega como `false` (perfil do próprio jogador) ou como o passaporte do alvo —
-- quem abre "o perfil de outro jogador" (evento "hud:set:profile.visible", disparado por
-- outro resource que não faz parte deste workspace) precisa mandar o passaporte, não o
-- source nem um ped/network id: é essa a identidade usada em todo o resto da base
-- (ex.: `author.id` nos alertas policiais).
function HUD.GetProfileData(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return false
	end

	local TargetPassport = Passport
	if Entity then
		local Parsed = parseInt(Entity)
		if Parsed > 0 then
			TargetPassport = Parsed
		end
	end

	local Identity = vRP.Identity(TargetPassport)
	if not Identity then
		return false
	end

	local TargetProfile = vRP.SimpleData(TargetPassport,"Profile") or {}
	local ViewerProfile = TargetPassport == Passport and TargetProfile or (vRP.SimpleData(Passport,"Profile") or {})

	return {
		id = TargetPassport,
		name = vRP.FullName(TargetPassport),
		avatar = TargetProfile.avatar or "",
		banner = TargetProfile.banner or "",
		discord = TargetProfile.discord or "",
		instagram = TargetProfile.instagram or "",
		description = TargetProfile.description or "",
		self = TargetPassport == Passport,
		related = (ViewerProfile.Related and ViewerProfile.Related[tostring(TargetPassport)]) == true
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPROFILEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function HUD.UpdateProfileData(Field,Value)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return false
	end

	local Limit = ProfileFieldLimits[Field]
	if not Limit or type(Value) ~= "string" then
		return false
	end

	Value = Value:sub(1,Limit)

	local Profile = vRP.SimpleData(Passport,"Profile") or {}
	Profile[Field] = Value
	SaveProfile(Passport,Profile)

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELATEPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function HUD.RelatePlayer(TargetPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return false
	end

	TargetPassport = parseInt(TargetPassport)
	if TargetPassport <= 0 or TargetPassport == Passport or not vRP.Identity(TargetPassport) then
		return false
	end

	local Profile = vRP.SimpleData(Passport,"Profile") or {}
	Profile.Related = Profile.Related or {}

	local Key = tostring(TargetPassport)
	if Profile.Related[Key] then
		Profile.Related[Key] = nil
	else
		Profile.Related[Key] = true
	end

	SaveProfile(Passport,Profile)

	return true
end
