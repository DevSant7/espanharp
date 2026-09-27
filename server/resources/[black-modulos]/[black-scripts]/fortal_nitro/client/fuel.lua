local vehicles = {}
local lastNitro = 0
local nitroCooldown = 2500 -- TODO: per-vehicle cooldown?

local nitroFuelSize = 2000
local nitroFuelDrainRate = 10
local nitroPurgeFuelDrainRate = nitroFuelDrainRate * 2
local nitroRechargeRate = nitroFuelDrainRate / 2

function InitNitroFuel(vehicle)
  if not vehicles[vehicle] then
    vehicles[vehicle] = nitroFuelSize
  end
end

function DrainNitroFuel(vehicle, purge)
  local plate = GetVehicleNumberPlateText(vehicle)
  local fuel = GlobalState["Nitro"][plate] or 0

  local drainAmount = purge and 2 or 1

  if fuel > 0 then
    fuel = fuel - drainAmount
    if fuel < 0 then fuel = 0 end

    GlobalState["Nitro"][plate] = fuel
    TriggerServerEvent("updateNitro", plate, fuel) -- chama seu serverAPI
  end
end



function GetNitroFuelLevel(vehicle)
  local plate = GetVehicleNumberPlateText(vehicle)
  local fuel = GlobalState["Nitro"][plate] or 0
  return math.max(0, fuel)
end


function SetNitroFuelLevel(vehicle, level)
  vehicles[vehicle] = level
end

Citizen.CreateThread(function ()
  local function FuelLoop()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    local isRunning = GetIsVehicleEngineRunning(vehicle)
    local isBoosting = IsVehicleNitroBoostEnabled(vehicle)
    local isPurging = IsVehicleNitroPurgeEnabled(vehicle)

    if vehicle == 0 or driver ~= player or not isRunning then
      return
    end

    -- if isRunning then
    --   if isBoosting == false and isPurging == false and GetGameTimer() > lastNitro + nitroCooldown then
    --     RechargeNitroFuel(vehicle)
    --   end
    -- end
  end

  while true do
    Citizen.Wait(0)
    FuelLoop()
  end
end)
