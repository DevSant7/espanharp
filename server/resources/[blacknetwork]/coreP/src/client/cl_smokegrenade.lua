
RegisterNetEvent("smoke:Init", function(coords)
    local particleDict = "core"
    local particleName = "exp_grd_grenade_smoke"

    RequestNamedPtfxAsset(particleDict)
    while not HasNamedPtfxAssetLoaded(particleDict) do Wait(0) end

    UseParticleFxAssetNextCall(particleDict)
        
    local particleId = StartParticleFxLoopedAtCoord(
        particleName,
        coords.x, coords.y, coords.z + 0.2,
        0.0, 0.0, 0.0,
        1.0,
        false, false, false, false
    )

    Wait(1000)

    CreateThread(function()
        while true do
            RemoveParticleFxInRange(coords.x, coords.y, coords.z, 0.1)
            Wait(5)
        end
    end)

    Wait(22000)
    StopParticleFxLooped(particleId)
end)