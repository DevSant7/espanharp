local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1

L0_1 = 100

L1_1 = false

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = Config

  L1_2 = L1_2.Battery

  L1_2 = L1_2.Enabled

  if not L1_2 then

    return

  end

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  L2_2 = "number" == L2_2

  L3_2 = "setBattery: battery must be a number"

  L1_2(L2_2, L3_2)

  L1_2 = assert

  L2_2 = A0_2 >= 0 and A0_2 <= 100

  L3_2 = "setBattery: battery must be between 0 and 100"

  L1_2(L2_2, L3_2)

  L0_1 = A0_2

  if 0 == A0_2 then

    L1_2 = OnDeath

    L1_2()

    L1_2 = TriggerEvent

    L2_2 = "lb-phone:phoneDied"

    L1_2(L2_2)

  end

  L1_2 = TriggerServerEvent

  L2_2 = "phone:battery:setBattery"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1 = RegisterNUICallback

L4_1 = "setBattery"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = L2_1

  L3_2 = A0_2

  L2_2(L3_2)

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L3_1(L4_1, L5_1)

L3_1 = exports

L4_1 = "SetBattery"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = L2_1

  L2_2 = A0_2

  L1_2(L2_2)

  L1_2 = SendReactMessage

  L2_2 = "battery:setBattery"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1(L4_1, L5_1)

L3_1 = exports

L4_1 = "GetBattery"

function L5_1()

  local L0_2, L1_2

  L0_2 = L0_1

  return L0_2

end

L3_1(L4_1, L5_1)

function L3_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  L2_2 = "boolean" == L2_2

  L3_2 = "ToggleCharging: toggle must be a boolean"

  L1_2(L2_2, L3_2)

  L1_2 = L1_1

  if L1_2 == A0_2 then

    L1_2 = debugprint

    L2_2 = "ToggleCharging: charging is already set to"

    L3_2 = A0_2

    L1_2(L2_2, L3_2)

    return

  end

  L1_1 = A0_2

  L1_2 = SendReactMessage

  L2_2 = "battery:toggleCharging"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

ToggleCharging = L3_1

L3_1 = exports

L4_1 = "ToggleCharging"

L5_1 = ToggleCharging

L3_1(L4_1, L5_1)

L3_1 = exports

L4_1 = "IsCharging"

function L5_1()

  local L0_2, L1_2

  L0_2 = L1_1

  return L0_2

end

L3_1(L4_1, L5_1)

function L3_1()

  local L0_2, L1_2

  L0_2 = Config

  L0_2 = L0_2.Battery

  L0_2 = L0_2.Enabled

  if not L0_2 then

    L0_2 = false

    return L0_2

  end

  L0_2 = L0_1

  L0_2 = 0 == L0_2

  return L0_2

end

IsPhoneDead = L3_1

L3_1 = exports

L4_1 = "IsPhoneDead"

L5_1 = IsPhoneDead

L3_1(L4_1, L5_1)
