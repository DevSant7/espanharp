



fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/build/index.html"

client_scripts {
	"config/*.lua",
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"config/*.lua",
	"@vrp/lib/Utils.lua",
	"@vrp/modules/bk.lua",
	"server-side/*"
}

files {
	"data/*",
	"web-side/build/*",
	"web-side/build/**/*"
}

data_file "DLC_ITYP_REQUEST" "stream/Utils/Box/mt_boxpreta.ytyp"

data_file "PED_PERSONALITY_FILE" "data/pedpersonality.meta"
data_file "WEAPON_ANIMATIONS_FILE" "data/weaponanimations.meta"
data_file "WEAPON_METADATA_FILE" "data/weaponarchetypes.meta"
data_file "WEAPONCOMPONENTSINFO_FILE" "data/weaponcomponents.meta"
data_file "WEAPONINFO_FILE" "data/weapons_brick.meta"
data_file "WEAPONINFO_FILE" "data/weapons_coltxm177.meta"
data_file "WEAPONINFO_FILE" "data/weapons_karambit.meta"
data_file "WEAPONINFO_FILE" "data/weapons_katana.meta"
data_file "WEAPONINFO_FILE" "data/weapons_nailgun.meta"
data_file "WEAPONINFO_FILE" "data/weapons_shoes.meta"

-- Vanilla
data_file "WEAPONINFO_FILE_PATCH" "data/weapon_militaryrifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponcombatpdw.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponheavyshotgun.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_combatmg_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_doubleaction.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_heavyrifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_heavysniper_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_marksmanrifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_revolver_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponsnowball.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_assaultrifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponcompactrifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapongusenberg.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponheavypistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponmachinepistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponminismg.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_pistol_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponrevolver.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponsnspistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_snspistol_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponvintagepistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponbattleaxe.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponbottle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponflashlight.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponhatchet.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponknuckle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponmachete.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponpoolcue.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponstonehatchet.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponwrench.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponmusket.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponbullpuprifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_bullpuprifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_carbinerifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_pumpshotgun_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapon_combatshotgun.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_smg_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_specialcarbine_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weaponspecialcarbine.meta"
data_file "WEAPONINFO_FILE_PATCH" "data/weapons_spacerangers.meta"