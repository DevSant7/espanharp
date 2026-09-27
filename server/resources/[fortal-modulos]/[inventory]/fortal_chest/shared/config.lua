Config = {}

Config.imagesProvider = "https://cdn.blacknetwork.com.br/black_inventory/"

Config.vipGroups = {
	"Rm",
	"Bronze",
	"Prata",
	"Ouro",
	"Diamante"
}

Config.chestSlots = {
	["Police"] = 120,   
	["Dip"] = 120,            
	["Admin"] = 200,         
	["Bennys"] = 60,         
	["Bennys2"] = 60,          
	["Cassino"] = 150,         
	["Cassino2"] = 150,       
	["Jamaica"] = 100,        
	["TheLost"] = 80,          
	["TheLost2"] = 80,         
	["Malibu"] = 90,           
	["Malibu2"] = 90,         
}

Config.defaultChestSlots = 60

Config.chestCoords = {
	---- Legal
	{ "Police",446.85,-997.01,30.68,"1"},
	{ "Paramedic",306.41,-601.7,43.29,"1"},
	{ "Dip",381.17,-1609.13,30.19,"1"},
	---- Ilegal
	{ "Bahamas",-1376.16,-633.53,30.31,"1"},
	{ "Bahamas2",-1371.98,-629.38,30.31,"1"},

	{ "Praia",-1986.4,-498.1,20.73,"1"},
	{ "Roxos", 96.08,-1984.39,20.44,"1"},


	{ "Burguer",-1200.26,-894.63,13.88,"1"},
	

	

--[[ 	{ "Ballas1",1162.25,-135.77,62.39,"1"},
	{ "Ballas2",1161.62,-132.72,65.71,"1"}, ]]


	{ "Ballas5",1797.66,431.03,125.68,"1"}, -- Vinhedo
	{ "Ballas6",-1792.41,422.97,125.68,"1"}, -- Vinhedo


	{ "Vinhedo3",-1870.37,2059.34,135.44,"1"}, -- Vinhedo
	{ "Vinhedo4",-1881.69,2064.28,135.91,"1"}, -- Vinhedo
	
	

	{ "Bennys4",-195.07,-1314.54,31.29,"1"},
	{ "Bennys5",-192.39,-1318.25,31.29,"1"},



--[[ 	{ "Livic",1534.79,-810.25,108.01,"1" },
	{ "Livic2",-1818.29,-47.97,95.89,"1" }, ]]

	{ "Cassino",1002.85,56.5,75.05,"1"},
	{ "Cassino2",998.88,61.35,75.05,"1"},
	
	{ "Mafia",-571.66,289.02,79.18,"1"},

--[[ 	{ "Duto",724.65,395.49,142.65,"1"}, -- GOD
	{ "Duto2",712.8,380.37,142.65,"1"}, -- GOD ]]

	{ "TheLost",267.2,6617.64,33.19,"1"},
	{ "TheLost2",288.81,6661.57,29.96,"1"},

	{"Tuners3",-804.8,177.41,72.82,"1"},
	{"Tuners4",-803.55,185.65,72.61,"1"},

	{ "Vanilla",-562.33,188.38,72.99,"1"},
	{ "Vanilla2",-564.25,199.94,72.88,"1"},
	
	{ "Families3",-163.85,-1619.05,33.65,"1"}, 

	{ "Families4",950.44,-966.93,39.75,"1"}, 
	{ "Families5",738.8,651.64,106.32,"1"}, 

	{ "Livic3",-1770.63,-117.07,95.4,"1" },
	{ "Livic4",-1818.29,-47.97,95.89,"1" }, 

	{ "Lago",-96.14,817.32,235.73,"1"}, 
	{ "Lago2",-60.1,834.16,231.33,"1"}, 

	{ "Malibu",-3229.52,809.24,8.93,"1"}, 
	{ "Malibu2",-3233.9,815.07,14.07,"1"}, 

	{ "Raijin",883.11,-2100.54,30.46,"1"},
	{ "Raijin2",886.2,-2097.46,34.88,"1"},

	{ "TDP",-1485.42,2351.69,31.05,"1"},
	{ "TDP2",-1468.85,2325.14,30.72	,"1"},
	
	{ "TheLost2",988.91,-137.76,74.05,"1"},
	{ "TheLost",977.16,-104.21,74.85,"1"},

	{ "Mafia",1403.17,1152.52,114.33,"1"},
	{ "Mafia2",1391.56,1158.81,114.33,"1"},

	{ "Ballas7",-1795.59,422.75,125.68,"1"},
	{ "Ballas8",-1797.33,430.65,125.68,"1"},

    { "Playboy",-1532.96,151.39,56.11,"1"},

	{"Vagos",329.78,-1998.05,24.2,"1"},

	
} 

Config.blockedItens = {
	["cheese"] = true,
	["foodburger"] = false,
	["foodjuice"] = true,
	["foodbox"] = false,
	["octopus"] = true,
	["shrimp"] = true,
	["carp"] = true,
	["codfish"] = true,
	["catfish"] = true,
	["goldenfish"] = true,
	["horsefish"] = true,
	["tilapia"] = true,
	["pacu"] = true,
	["pirarucu"] = true,
	["tambaqui"] = true,
	["energetic"] = true,
	["milkbottle"] = true,
	["water"] = true,
	["coffee"] = true,
	["cola"] = true,
	["tacos"] = true,
	["fries"] = true,
	["soda"] = true,
	["orange"] = false,
	["apple"] = false,
	["strawberry"] = false,
	["coffee2"] = true,
	["grape"] = false,
	["tange"] = false,
	["banana"] = false,
	["passion"] = false,
	["tomato"] = false,
	["mushroom"] = true,
	["orangejuice"] = true,
	["tangejuice"] = true,
	["grapejuice"] = true,
	["strawberryjuice"] = true,
	["bananajuice"] = true,
	["passionjuice"] = true,
	["bread"] = false,
	["ketchup"] = false,
	["cannedsoup"] = true,
	["canofbeans"] = true,
	["meat"] = true,
	["fishfillet"] = true,
	["marshmallow"] = true,
	["cookedfishfillet"] = true,
	["cookedmeat"] = true,
	["hamburger"] = true,
	["hamburger2"] = false,
	["pizza"] = true,
	["pizza2"] = true,
	["hotdog"] = true,
	["donut"] = true,
	["chocolate"] = true,
	["sandwich"] = true,
	["absolut"] = true,
	["chandon"] = true,
	["dewars"] = true,
	["hennessy"] = true,
	["nigirizushi"] = true,
	["sushi"] = true,
	["cupcake"] = false,
	["milkshake"] = false,
	["cappuccino"] = false
}
