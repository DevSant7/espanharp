local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1

flashlightEnabled = false

L0_1 = DrawFlashlight

function L1_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = flashlightEnabled

  L2_2 = true == A0_2

  flashlightEnabled = L2_2

  L2_2 = flashlightEnabled

  if L2_2 == L1_2 then

    return

  end

  L2_2 = TriggerServerEvent

  L3_2 = "phone:toggleFlashlight"

  L4_2 = flashlightEnabled

  L2_2(L3_2, L4_2)

  L2_2 = flashlightEnabled

  if not L2_2 then

    return

  end

  L2_2 = Citizen

  L2_2 = L2_2.CreateThreadNow

  function L3_2()

    local L0_3, L1_3, L2_3

    L0_3 = PlayerPedId

    L0_3 = L0_3()

    while true do

      L1_3 = flashlightEnabled

      if not L1_3 then

        break

      end

      L1_3 = phoneOpen

      if L1_3 then

        L1_3 = L0_1

        L2_3 = L0_3

        L1_3(L2_3)

      else

        L1_3 = Wait

        L2_3 = 500

        L1_3(L2_3)

      end

      L1_3 = Wait

      L2_3 = 0

      L1_3(L2_3)

    end

  end

  L2_2(L3_2)

end

L2_1 = RegisterNUICallback

L3_1 = "toggleFlashlight"

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = L1_1

  L3_2 = A0_2.toggled

  L2_2(L3_2)

  L2_2 = SetTimeout

  L3_2 = 100

  function L4_2()

    local L0_3, L1_3

    L0_3 = A1_2

    L1_3 = flashlightEnabled

    L0_3(L1_3)

  end

  L2_2(L3_2, L4_2)

end

L2_1(L3_1, L4_1)

L2_1 = exports

L3_1 = "ToggleFlashlight"

function L4_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = phoneOpen

  if not L1_2 then

    return

  end

  L1_2 = L1_1

  L2_2 = A0_2

  L1_2(L2_2)

  L1_2 = SendReactMessage

  L2_2 = "toggleFlashlight"

  L3_2 = flashlightEnabled

  L1_2(L2_2, L3_2)

end

L2_1(L3_1, L4_1)

L2_1 = exports

L3_1 = "GetFlashlight"

function L4_1()

  local L0_2, L1_2

  L0_2 = flashlightEnabled

  L0_2 = true == L0_2

  return L0_2

end

L2_1(L3_1, L4_1)

L2_1 = Config

L2_1 = L2_1.SyncFlash

if not L2_1 then

  return

end

L2_1 = {}

L3_1 = Interval

L4_1 = L3_1

L3_1 = L3_1.new

function L5_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L0_2 = pairs

  L1_2 = L2_1

  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)

  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do

    L6_2 = L0_1

    L7_2 = L5_2

    L6_2(L7_2)

  end

end

L6_1 = 0

L7_1 = false

L3_1 = L3_1(L4_1, L5_1, L6_1, L7_1)

function L4_1()

  local L0_2, L1_2

  L0_2 = debugprint

  L1_2 = "Started drawing flashlights"

  L0_2(L1_2)

end

L3_1.onStart = L4_1

function L4_1()

  local L0_2, L1_2

  L0_2 = debugprint

  L1_2 = "Stopped drawing flashlights"

  L0_2(L1_2)

end

L3_1.onStop = L4_1

L4_1 = AddStateBagChangeHandler

L5_1 = "flashlight"

L6_1 = nil

function L7_1(A0_2, A1_2, A2_2, A3_2, A4_2)

  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L5_2 = GetPlayerDataFromStateBag

  L6_2 = A0_2

  L5_2, L6_2 = L5_2(L6_2)

  if L5_2 then

    L7_2 = GetPlayerServerId

    L8_2 = PlayerId

    L8_2, L9_2, L10_2 = L8_2()

    L7_2 = L7_2(L8_2, L9_2, L10_2)

    if L5_2 ~= L7_2 then

      goto lbl_13

    end

  end

  do return end

  ::lbl_13::

  if A2_2 then

    L7_2 = L2_1

    L7_2[L5_2] = L6_2

  else

    L7_2 = L2_1

    L7_2[L5_2] = nil

  end

  L7_2 = L3_1

  L8_2 = L7_2

  L7_2 = L7_2.toggle

  L9_2 = next

  L10_2 = L2_1

  L9_2 = L9_2(L10_2)

  L9_2 = nil ~= L9_2

  L7_2(L8_2, L9_2)

end

L4_1(L5_1, L6_1, L7_1)

L4_1 = RegisterNetEvent

L5_1 = "onPlayerDropped"

function L6_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = L2_1

  L1_2[A0_2] = nil

  L1_2 = L3_1

  L2_2 = L1_2

  L1_2 = L1_2.toggle

  L3_2 = next

  L4_2 = L2_1

  L3_2 = L3_2(L4_2)

  L3_2 = nil ~= L3_2

  L1_2(L2_2, L3_2)

end

L4_1(L5_1, L6_1)
