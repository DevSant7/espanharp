Config = {}

Config.coupon = {
    show = true,
    percent = 50,
    name = "CARIOCA50"
}
exports('license', function () 
	return "eeab8f98-ed55-453b-80b5-e6bd9aa31f50" 
end)


Config.weaponsCode = {
	[GetHashKey("WEAPON_PISTOL_MK2")] = "pistola",
    [GetHashKey("WEAPON_PISTOL50")] = "pistola",
    [GetHashKey("WEAPON_REVOLVER_MK2")] = "pistola",
    [GetHashKey("WEAPON_APPISTOL")] = "pistola",
    [GetHashKey("WEAPON_MACHINEPISTOL")] = "pistola",
    [GetHashKey("WEAPON_MINISMG")] = "smg",
    [GetHashKey("WEAPON_ASSAULTSMG")] = "smg",
	[GetHashKey("WEAPON_SMG_MK2")] = "smg",
	[GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = "m4",
    [GetHashKey("WEAPON_BULLPUPRIFLE_MK2")] = "m4",
    [GetHashKey("WEAPON_SPECIALCARBINE")] = "m4",
	[GetHashKey("WEAPON_SPECIALCARBINE_MK2")] = "m4",
    [GetHashKey("WEAPON_MUSKET")] = "musket",
	[GetHashKey("WEAPON_COMBATPISTOL")] = "pistol",
	[GetHashKey("WEAPON_SMG")] = "smg",
	[GetHashKey("WEAPON_COMBATPDW")] = "smg",
	[GetHashKey("WEAPON_CARBINERIFLE")] = "m4",
	[GetHashKey("WEAPON_CARBINERIFLE_MK2")] = "m4",
	[GetHashKey("WEAPON_PARAFAL")] = "m4",
	[GetHashKey("WEAPON_FNFAL")] = "m4",
	[GetHashKey("WEAPON_FNSCAR")] = "m4",
}