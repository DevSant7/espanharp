-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
command = "skins" -- comando para abrir o sistema de skins pelo server
showfirst = { -- primeira skin que irá aparecer ao abrir o skinweapon
	skin = "COMPONENT_FIVESEVEN_AI", -- nome do componente da skin
	weapon = "WEAPON_PISTOL_MK2" -- nome da arma
}

createAuto = true
prints = true

coords = {
	open = vec3(9.78,-1106.7,29.79),
	cam = vec3(9.38,-1106.47,30.29),
	point = vec3(8.67,-1106.38,30.29)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
-- "<b>Lendária</b>" "<b1>Épica</b1>" "<b2>Rara</b2>" "Normal"

imagesProvider = "https://cdn.blacknetwork.com.br/black_skins/"

skinglobal = {
	["COMPONENT_FIVESEVEN_AA"] = { "Five Seven Korea",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_FIVESEVEN_AI"] = { "Five Seven Hello Kitty",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_FIVESEVEN_AJ"] = { "Five Seven Alien",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_FIVESEVEN_AM"] = { "Five Seven Mexico",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_FIVESEVEN_AO"] = { "Five Seven Nike X",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_FIVESEVEN_AP"] = { "Five Seven My X",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_FIVESEVEN_AR"] = { "Five Seven Vulcão",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_FIVESEVEN_AT"] = { "Five Seven Nike Smile",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_FIVESEVEN_NV"] = { "Five Seven Nike V.",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_FIVESEVEN_BARBIE"] = { "Five Seven Barbie",50,"WEAPON_PISTOL_MK2","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_GLOCK_SNACKCLUB"] = { "Glock Snack Club",50,"WEAPON_COMBATPISTOL","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_GLOCK_SEATERROR"] = { "Glock Sea Terror",50,"WEAPON_COMBATPISTOL","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_GLOCK_REDSAMURAI"] = { "Glock Red Samurai",50,"WEAPON_COMBATPISTOL","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_GLOCK_BT"] = { "Glock Gaiden",50,"WEAPON_COMBATPISTOL","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_GLOCK_BW"] = { "Glock Royal Salute",50,"WEAPON_COMBATPISTOL","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_GLOCK_CH"] = { "Glock Nike France",50,"WEAPON_COMBATPISTOL","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_GLOCK_CI"] = { "Glock Cyclone",50,"WEAPON_COMBATPISTOL","Pistol","<b1>Épica</b1>", 20 },
	--["COMPONENT_DESERT_OMATSURI"] = { "Desert Omatsuri",50,"WEAPON_PISTOL50","Pistol","<b1>Épica</b1>", 20 },
	["COMPONENT_AK47_SKIN"] = { "AK-47 Dragon",100,"WEAPON_ASSAULTRIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_MARK_SKIN"] = { "AK-47 Mark",100,"WEAPON_ASSAULTRIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_TOE_SKIN"] = { "AK-47 Skeleton Red",100,"WEAPON_ASSAULTRIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_WH_SKIN"] = { "AK-47 Rosa",100,"WEAPON_ASSAULTRIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_WHITE_SKIN"] = { "AK-47 My X",100,"WEAPON_ASSAULTRIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_WHITEB_SKIN"] = { "AK-47 My X 2",100,"WEAPON_ASSAULTRIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_PARTEN_SKIN"] = { "AK-47 Cromada",100,"WEAPON_ASSAULTRIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_YE_SKIN"] = { "AK-47 Banana Joy",100,"WEAPON_ASSAULTRIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AH_SKIN"] = { "AK-47 Monster",100,"WEAPON_ASSAULTRIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AA_SKIN"] = { "AK-47 MK2 Pink",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AB_SKIN"] = { "AK-47 MK2 Noturna Blue",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AC_SKIN"] = { "AK-47 MK2 Gelo",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AE_SKIN"] = { "AK-47 MK2 Roxo",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AG_SKIN"] = { "AK-47 MK2 Noturna Green",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AI_SKIN"] = { "AK-47 MK2 Hulk",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AK_SKIN"] = { "AK-47 MK2 Have",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AL_SKIN"] = { "AK-47 MK2 Water",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AM_SKIN"] = { "AK-47 MK2 Cinza",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AN_SKIN"] = { "AK-47 MK2 Bolt Black",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_AK47_AQ_SKIN"] = { "AK-47 MK2 Minerva Purple",100,"WEAPON_ASSAULTRIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,-0.1,0.0) },
	["COMPONENT_M4_AD_SKIN"] = { "M4 Neon",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_AL_SKIN"] = { "M4 Dragon Red",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_AM_SKIN"] = { "M4 AM",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_AR_SKIN"] = { "M4 Dragon Purple",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_AS_SKIN"] = { "M4 Dragon Blue",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_COLT_SKIN"] = { "M4 Colt",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_DK_SKIN"] = { "M4 DK",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_DRAGON_SKIN"] = { "M4 Dragon",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_GR_SKIN"] = { "M4 Griffin",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_HUNTER_SKIN"] = { "M4 Hunter",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_W_SKIN"] = { "M4 W",100,"WEAPON_CARBINERIFLE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_MK2_AJ_SKIN"] = { "M4 MK2 Mark",100,"WEAPON_CARBINERIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_M4_MK2_BL_SKIN"] = { "M4 MK2 BL",100,"WEAPON_CARBINERIFLE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_BB"] = { "G3 Branco Brasil",100,"WEAPON_SPECIALCARBINE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_CA"] = { "G3 Camaleao",100,"WEAPON_SPECIALCARBINE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_PB"] = { "G3 Preto Brasil",100,"WEAPON_SPECIALCARBINE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_RAE"] = { "G3 Rosa Espelhado",100,"WEAPON_SPECIALCARBINE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_SUB"] = { "G3 Sublime",100,"WEAPON_SPECIALCARBINE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_BRIN"] = { "G3 Brinquedo",100,"WEAPON_SPECIALCARBINE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_ANCI"] = { "G3 Ancifogo",100,"WEAPON_SPECIALCARBINE","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_MK2_GP"] = { "G3 MK2 Glitchpop",100,"WEAPON_SPECIALCARBINE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_MK2_ONI"] = { "G3 MK2 Oni",100,"WEAPON_SPECIALCARBINE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_MK2_RGX"] = { "G3 MK2 Rgx",100,"WEAPON_SPECIALCARBINE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_MK2_SAQ"] = { "G3 MK2 Saqueadora",100,"WEAPON_SPECIALCARBINE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
	["COMPONENT_G3_MK2_SING"] = { "G3 MK2 Singularidade",100,"WEAPON_SPECIALCARBINE_MK2","Rifle","<b>Lendária</b>", 20, vec3(-0.1,0.0,0.0) },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEV
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ function tvRP.giveWeapons(weapons,clear_before)
	local player = PlayerPedId()
	if clear_before then
		RemoveAllPedWeapons(player,true)
		weapon_list = {}		  
	end

	for k,weapon in pairs(weapons) do
		local hash = GetHashKey(k)
		local ammo = weapon.ammo or 0
		GiveWeaponToPed(player,hash,ammo,false)
		weapon_list[string.upper(k)] = weapon							   
	end
	TriggerServerEvent("skinweapon:check") ---- adicionar esse evento pra checar se tem skin equipada na arma recebida/possuida e equipar posteriormente
end ]]