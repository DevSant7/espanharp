

fx_version 'bodacious'
game 'gta5'
author 'GABZ'
description 'MRPD'
version '1.0.0'
this_is_a_map 'yes'
data_file "DLC_ITYP_REQUEST" "stream/creativeInteriores/v_int_16.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/creativeInteriores/v_int_49.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/creativeInteriores/creative_hotel.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/creativeInteriores/creative_middle.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/mah_lanca.ytyp"
data_file 'TIMECYCLEMOD_FILE' 'gabz_mrpd_timecycle.xml'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies2.meta'
data_file "INTERIOR_PROXY_ORDER_FILE" "interiorproxies3.meta"
data_file "DLC_ITYP_REQUEST" "stream/creativeBadges/v_badges.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/creativeInteriores/creative_props.ytyp"
files {
	"stream/*",
	"stream/*/**",
	"stream/*/*/**",
	"stream/*/*/*/**",
	"interiorproxies.meta",
	"interiorproxies2.meta",
	"interiorproxies3.meta"
}
client_script {
    "gabz_mrpd_entitysets.lua"
}