local Tunnel = module("vrp","lib/Tunnel")
vSERVER = Tunnel.getInterface("races")

local Races = {}
local Selected = 1
local raceTyres = {}
local savePoints = 0
local racePoints = 0
local Checkpoints = 1
local CheckBlip = nil
local NextCheckBlip = nil
local Progress = false
local ExplodeTimers = 0
local ExplodeRace = false
local inativeRaces = false
local displayRanking = false
local timeInRace = 0
local flare = nil
local waitingForRace = false
local waitCountdownTimer = 0
local waitRaceId = nil
local startRaceCountdown = false
local countdownTimer = 0
local teleportingToStart = false
local currentRunners = 0
local maxRunners = 0
local isPlayerLockedInVehicle = false
local raceParticipantsSources = {}

local myCurrentPos = 1
local myMaxPos = 1
local currentRanking = {}
local myProfileData = nil

local bikesModel = {
  [1131912276] = true,
  [448402357] = true,
  [-836512833] = true,
  [-186537451] = true,
  [1127861609] = true,
  [-1233807380] = true,
  [-400295096] = true
}

local function getVehicleInfo()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsUsing(ped)
        local vehicleHash = GetEntityModel(vehicle)
        
        if Config.VehicleMapping[vehicleHash] then
            return Config.VehicleMapping[vehicleHash][1], Config.VehicleMapping[vehicleHash][2]
        else
            return "Desconhecido", "comum"
        end
    else
        return "Desconhecido", "comum"
    end
end

function toggleFreezeVehicle(freeze)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local veh = GetVehiclePedIsUsing(ped)
        FreezeEntityPosition(veh, freeze)
        SetVehicleHandbrake(veh, freeze)
        if freeze then
            SetEntityVelocity(veh, 0.0, 0.0, 0.0)
        end
    end
end

CreateThread(function()
  while true do
      local timeDistance = 999
      if not inativeRaces then
          if waitingForRace or startRaceCountdown or teleportingToStart then
              Wait(100)
              goto continueLoop
          end
          local ped = PlayerPedId()
          if IsPedInAnyVehicle(ped) then
              if Progress then
                  timeDistance = 1 -- Reduzido de 5 para 1 para verificação mais frequente
                  racePoints = (GetGameTimer() - savePoints)
                  local vehicle = GetVehiclePedIsUsing(ped)
                  if GetPedInVehicleSeat(vehicle,-1) ~= ped then
                      leaveRace()
                  end

                  if GetGameTimer() % 500 < 50 then
                      local coords = GetEntityCoords(ped)
                      vSERVER.updatePlayerRaceProgress(Selected, Checkpoints, coords.x, coords.y, coords.z, math.floor(racePoints/1000))
                  end

                  if not displayRanking then
                      SendNUIMessage({
                          action="inRace",
                          values={
                              checkpoint= Checkpoints,
                              maxCheckpoint= #Races[Selected]["coords"],
                              timeInRace= ExplodeRace and math.floor((ExplodeTimers - GetGameTimer())/1000) or math.floor(racePoints/1000),
                              timeToExplode = ExplodeRace and math.floor((ExplodeTimers - GetGameTimer())/1000) or nil,
                              myPos = myCurrentPos,
                              maxPos = myMaxPos,
                              ranking = currentRanking,
                              myProfile = myProfileData
                          }
                      })
                        
                        isPlayerLockedInVehicle = false
                        local ped = PlayerPedId()
                        if IsPedInAnyVehicle(ped) then
                            local veh = GetVehiclePedIsUsing(ped)
                            toggleFreezeVehicle(false)
                            SetVehicleEngineOn(veh, true, true, false)
                            
                            SetPlayerControl(PlayerId(), true, 0)
                            Citizen.CreateThread(function()
                                Wait(100)
                                isPlayerLockedInVehicle = false
                            end)
                        end
                  end

                  if ExplodeRace and GetGameTimer() >= ExplodeTimers then
                      leaveRace()
                  end

                  -- Verificação mais precisa dos checkpoints
                  local coords = GetEntityCoords(ped)
                  local currentCheckpoint = Races[Selected]["coords"][Checkpoints]
                  if currentCheckpoint then
                      local checkpointCoords = currentCheckpoint[1]
                      local distance = #(coords - vec3(checkpointCoords[1], checkpointCoords[2], checkpointCoords[3]))
                      
                      if distance <= 12.0 then -- Reduzido de 15.0 para 12.0 para detecção mais precisa
                          if Checkpoints >= #Races[Selected]["coords"] then
                              -- Final da corrida
                              vSERVER.finishRace(Selected, math.floor(racePoints/1000))
                              Progress = false
                              
                              SetLocalPlayerAsGhost(false)
                              ResetGhostedEntityAlpha()
                              
                              cleanObjects()
                              cleanBlips()
                              raceTyres = {}
                              savePoints = 0
                              racePoints = 0
                              Checkpoints = 1
                              CheckBlip = nil
                              NextCheckBlip = nil
                              ExplodeTimers = 0
                              ExplodeRace = false
                              displayRanking = false
                              local records,yourRecord = vSERVER.requestRanking(Selected)
                              Selected = 1
                              SendNUIMessage({action = "FinishRace",values={records=records,yourRecord=yourRecord}})
                              Wait(5000)
                              SendNUIMessage({})
                          else
                              -- Próximo checkpoint
                              
                              -- Limpa objetos e blips do checkpoint anterior
                              cleanObjects()
                              cleanBlips()
                              
                              -- Pequeno delay para garantir que a limpeza foi processada
                              Wait(100)
                              
                              -- Avança para o próximo checkpoint
                              Checkpoints = Checkpoints + 1
                              
                              -- Cria novos objetos e blips para o próximo checkpoint
                              makeObjects()
                              makeBlips()
                          end
                      end
                  end
              else
                  local coords = GetEntityCoords(ped)
                  if Races then
                      for k,v in pairs(Races) do
                          local distance = #(coords - vec3(v["init"][1],v["init"][2],v["init"][3]))
                          if distance <= 25.0 then
                              local vehicle = GetVehiclePedIsUsing(ped)
                              if GetPedInVehicleSeat(vehicle,-1) == ped and not IsPedOnAnyBike(ped) then
                                  DrawMarker(4, v["init"][1], v["init"][2], v["init"][3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
                                           1.5, 1.5, 1.5, 
                                           136, 36, 249, 100, 
                                           0, 0, 0, 1)
                                  timeDistance = 1
                                  if distance <= 5.0 then
                                      if IsControlJustPressed(1, 38) then
                                          SendNUIMessage({})
                                          local raceStatus,raceExplosive = vSERVER.checkPermissionAndItem(k)
                                          if raceStatus then
                                              if displayRanking then
                                                  displayRanking = false
                                              end
                                              Selected = k
                                              waitingForRace = true
                                              waitCountdownTimer = GetGameTimer() + (Config.General.WaitTime * 1000)
                                                                                                           
                                              currentRunners = 1
                                              maxRunners = #Races[Selected]["cars"]
                                              SendNUIMessage({
                                                  action = "HoverWait",
                                                  values = {
                                                      time = Config.General.WaitTime,
                                                      runners = currentRunners,
                                                      maxRunners = maxRunners
                                                  }
                                              })
                                          end
                                      end
                                  else
                                      if displayRanking then
                                          SendNUIMessage({})
                                          displayRanking = false
                                      end
                                  end
                              end
                          end
                      end
                  end
              end
          else
              if Progress then
                  leaveRace()
              end
              if displayRanking then
                  SendNUIMessage({})
                  displayRanking = false
              end
          end
      end
      ::continueLoop::
      Wait(timeDistance)
  end
end)

local function setBlipNumber(blip, num)
  ShowNumberOnBlip(blip, num)
end

function makeBlips()
  -- Limpa blips existentes
  if DoesBlipExist(CheckBlip) then
      RemoveBlip(CheckBlip)
      CheckBlip = nil
  end
  if DoesBlipExist(NextCheckBlip) then
      RemoveBlip(NextCheckBlip)
      NextCheckBlip = nil
  end

  -- Verifica se o checkpoint atual existe
  if not Races[Selected] or not Races[Selected]["coords"] or not Races[Selected]["coords"][Checkpoints] then
      return
  end

  local thisCoord = Races[Selected]["coords"][Checkpoints][1]
  
  -- Cria o blip do checkpoint atual
  CheckBlip = AddBlipForCoord(thisCoord[1], thisCoord[2], thisCoord[3])
  if DoesBlipExist(CheckBlip) then
      SetBlipSprite(CheckBlip, 1)
      SetBlipColour(CheckBlip, 67)
      SetBlipScale(CheckBlip, 0.9)
      SetBlipAsShortRange(CheckBlip, true)
      SetBlipRoute(CheckBlip, true)
      SetBlipDisplay(CheckBlip, 2)
      setBlipNumber(CheckBlip, Checkpoints)
  end

  -- Cria o blip do próximo checkpoint se existir
  if Checkpoints + 1 <= #Races[Selected]["coords"] then
      local nextCoord = Races[Selected]["coords"][Checkpoints + 1][1]
      NextCheckBlip = AddBlipForCoord(nextCoord[1], nextCoord[2], nextCoord[3])
      if DoesBlipExist(NextCheckBlip) then
          SetBlipSprite(NextCheckBlip, 1)
          SetBlipColour(NextCheckBlip, 83)
          SetBlipScale(NextCheckBlip, 0.9)
          SetBlipAsShortRange(NextCheckBlip, true)
          SetBlipDisplay(NextCheckBlip, 2)
          setBlipNumber(NextCheckBlip, Checkpoints + 1)
      end
  end
end

function makeObjects()
    -- Destrói DUI anterior se existir
    if exports['race-dui'] then
        exports['race-dui']:destroyDUI()
    end
    
    -- Verifica se o checkpoint atual existe
    if not Races[Selected] or not Races[Selected]["coords"] or not Races[Selected]["coords"][Checkpoints] then
        return
    end
    
    local coords = {
        Races[Selected]["coords"][Checkpoints][1][1],
        Races[Selected]["coords"][Checkpoints][1][2],
        Races[Selected]["coords"][Checkpoints][1][3] - 2.0
    }
    
    -- Cria o DUI do checkpoint
    if exports['race-dui'] then
        exports['race-dui']:createDUI("CHECKPOINT", coords)
        
        local duiData = {
            show = true,
            laps = Checkpoints,
            MaxLaps = #Races[Selected]["coords"]
        }
        
        exports['race-dui']:updateDUIMessage(duiData)
    end
end

function cleanBlips()
    if DoesBlipExist(CheckBlip) then
        RemoveBlip(CheckBlip)
        CheckBlip = nil
    end
    
    if DoesBlipExist(NextCheckBlip) then
        RemoveBlip(NextCheckBlip)
        NextCheckBlip = nil
    end
end

function cleanObjects()
    -- Destrói o DUI atual
    if exports['race-dui'] then
        exports['race-dui']:destroyDUI()
    end
    
    -- Força a limpeza de partículas e efeitos visuais
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsUsing(ped)
        if DoesEntityExist(vehicle) then
            -- Remove efeitos visuais do veículo
            SetVehicleEngineOn(vehicle, true, true, false)
        end
    end
end

function leaveRace()

    SetLocalPlayerAsGhost(false)
    ResetGhostedEntityAlpha()
    
    raceParticipantsSources = {}

    -- Restante do código para resetar estados
    Progress = false
    waitingForRace = false
    startRaceCountdown = false
    teleportingToStart = false
    isPlayerLockedInVehicle = false
    waitCountdownTimer = 0
    countdownTimer = 0
    waitRaceId = nil
    SendNUIMessage({ show = false })
    cleanObjects()
    cleanBlips()

    Selected = 1
    raceTyres = {}
    savePoints = 0
    racePoints = 0
    Checkpoints = 1
    CheckBlip = nil
    NextCheckBlip = nil
    ExplodeTimers = 0
    vSERVER.exitRace()
    displayRanking = false

    myCurrentPos = 1
    myMaxPos = 1
    currentRanking = {}
    myProfileData = nil

    if ExplodeRace then
        Wait(3000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsUsing(ped)
            NetworkExplodeVehicle(vehicle,true,true,false)
        end
    end

    StopParticleFxLooped(flare, true)
    ExplodeRace = false
end


RegisterNetEvent("races:insertList")
AddEventHandler("races:insertList",function(status)
  inativeRaces = status
end)

RegisterNetEvent("races:Table")
AddEventHandler("races:Table",function(table)
  Races = table
  if Races then
      for _,v in pairs(Races) do
          local blip = AddBlipForRadius(v["init"][1], v["init"][2], v["init"][3], 10.0)
          SetBlipAlpha(blip, 200)
          SetBlipColour(blip, 59)
      end
  end
end)

local oldSpeed = 0

CreateThread(function()
  while true do
      local timeDistance = 999
      if not Progress then
          local Ped = PlayerPedId()
          if IsPedInAnyVehicle(Ped) then
              timeDistance = 1
              local Vehicle = GetVehiclePedIsUsing(Ped)
              if GetPedInVehicleSeat(Vehicle,-1) == Ped then
                  if GetVehicleDirtLevel(Vehicle) ~= 0.0 then
                      SetVehicleDirtLevel(Vehicle,0.0)
                  end
                  local Speed = GetEntitySpeed(Vehicle) * 3.6
                  if Speed ~= oldSpeed then
                      if (oldSpeed - Speed) >= 125 then
                          vehicleTyreBurst(Vehicle)
                      end
                      oldSpeed = Speed
                  end
              end
          else
              if oldSpeed ~= 0 then
                  oldSpeed = 0
              end
          end
      end
      Wait(timeDistance)
  end
end)

function vehicleTyreBurst(Vehicle)
  local vehModel = GetEntityModel(Vehicle)
  if bikesModel[vehModel] == nil and GetVehicleClass(Vehicle) ~= 8 then
      local Tyre = math.random(4)
      if Tyre == 1 then
          if GetTyreHealth(Vehicle,0) == 1000.0 then
              SetVehicleTyreBurst(Vehicle,0,true,1000.0)
          end
      elseif Tyre == 2 then
          if GetTyreHealth(Vehicle,1) == 1000.0 then
              SetVehicleTyreBurst(Vehicle,1,true,1000.0)
          end
      elseif Tyre == 3 then
          if GetTyreHealth(Vehicle,4) == 1000.0 then
              SetVehicleTyreBurst(Vehicle,4,true,1000.0)
          end
      elseif Tyre == 4 then
          if GetTyreHealth(Vehicle,5) == 1000.0 then
              SetVehicleTyreBurst(Vehicle,5,true,1000.0)
          end
      end
      if math.random(100) < 25 then
          Wait(500)
          vehicleTyreBurst(Vehicle)
      end
  end
end

CreateThread(function()
  vSERVER.connect()
end)

RegisterNetEvent("races:teleportToStart")
AddEventHandler("races:teleportToStart", function(coords, heading)
    teleportingToStart = true
    local ped = PlayerPedId()
    local vehicle = IsPedInAnyVehicle(ped) and GetVehiclePedIsUsing(ped) or nil
    if vehicle then
        toggleFreezeVehicle(true)
    end
    DoScreenFadeOut(Config.General.TeleportFadeTime)
    Wait(Config.General.TeleportFadeTime)
    if vehicle then
        SetEntityCoordsNoOffset(vehicle, coords[1], coords[2], coords[3], false, false, false)
        SetEntityHeading(vehicle, heading)
        Wait(100)
        SetVehicleOnGroundProperly(vehicle)
        SetPedIntoVehicle(ped, vehicle, -1)
    else
        SetEntityCoordsNoOffset(ped, coords[1], coords[2], coords[3], false, false, false)
        SetEntityHeading(ped, heading)
    end
    Wait(500)
    DoScreenFadeIn(Config.General.TeleportFadeTime)
    Wait(Config.General.TeleportFadeTime)
    teleportingToStart = false
end)

RegisterNetEvent("races:startRace")
AddEventHandler("races:startRace",function(countdown, allParticipantSources)
  startRaceCountdown = true
  countdownTimer = GetGameTimer() + (countdown * 1000)
  raceParticipantsSources = {}
  local localSource = GetPlayerServerId(PlayerId())
  for _, pSource in ipairs(allParticipantSources) do
      if pSource ~= localSource then
          table.insert(raceParticipantsSources, pSource)
      end
  end
  SendNUIMessage({
      action = "StartRace",
      values = {
          time = countdown * 1000
      }
  })
end)

RegisterNetEvent("races:updateHoverWaitPlayers")
AddEventHandler("races:updateHoverWaitPlayers", function(runners, maxPlayers)
  currentRunners = runners
  maxRunners = maxPlayers
end)

RegisterNetEvent("races:updateInRaceRanking")
AddEventHandler("races:updateInRaceRanking", function(rankingData, myPos, maxPos, myProfile)
  currentRanking = rankingData
  myCurrentPos = myPos
  myMaxPos = maxPos
  myProfileData = myProfile
end)

RegisterNetEvent("races:syncHoverWaitTime")
AddEventHandler("races:syncHoverWaitTime", function(timeRemaining)
    if waitingForRace then
        waitCountdownTimer = GetGameTimer() + (timeRemaining * 1000)
    end
end)

CreateThread(function()
    while true do
        local timeDistance = 100
        
        if waitingForRace then
            local remainingTime = math.floor((waitCountdownTimer - GetGameTimer()) / 1000)
            if remainingTime <= 0 then
                waitingForRace = false
                vSERVER.requestTeleportToStart(Selected)
            else
                SendNUIMessage({
                    action = "HoverWait",
                    values = {
                        time = remainingTime,
                        runners = currentRunners,
                        maxRunners = maxRunners
                    }
                })
            end
        elseif startRaceCountdown then
            local remainingTime = countdownTimer - GetGameTimer()
            if remainingTime <= 0 then
                startRaceCountdown = false
                savePoints = GetGameTimer()
                Checkpoints = 1
                racePoints = 0
                makeObjects()
                makeBlips()
                if Races[Selected] and Races[Selected]["explode"] and Races[Selected]["explode"] > 0 then
                    ExplodeTimers = GetGameTimer() + (Races[Selected]["explode"] * 1000)
                    ExplodeRace = true
                end
                
                Progress = true
                
                SetLocalPlayerAsGhost(true)
                ResetGhostedEntityAlpha()

                local ped = PlayerPedId()
                if IsPedInAnyVehicle(ped) then
                    local veh = GetVehiclePedIsUsing(ped)
                    toggleFreezeVehicle(false)
                    SetVehicleEngineOn(veh, true, true, false)
                end
                
                SendNUIMessage({ show = false })
                waitRaceId = nil
            else
                SendNUIMessage({
                    action = "StartRace",
                    values = {
                        time = remainingTime
                    }
                })
            end
        end
        
        Wait(timeDistance)
    end
end)

local lastHoverState = false
CreateThread(function()
  while true do
      local timeDistance = 100
      local ped = PlayerPedId()
      local showHover = false
      if not Progress and not waitingForRace and not startRaceCountdown and not teleportingToStart then
          if IsPedInAnyVehicle(ped) then
              local coords = GetEntityCoords(ped)
              if Races then
                  for k,v in pairs(Races) do
                      local distance = #(coords - vec3(v["init"][1],v["init"][2],v["init"][3]))
                      if distance <= 5.0 then 
                          showHover = true
                          break
                      end
                  end
              end
          end
      end
      if showHover ~= lastHoverState then
          lastHoverState = showHover
          SendNUIMessage({
              action = "HoverEnter",
              display = showHover
          })
      end
      Wait(timeDistance)
  end
end)
