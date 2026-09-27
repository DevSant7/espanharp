local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1

L0_1 = false

L1_1 = PlayerPedId

L1_1 = L1_1()

L2_1 = vector3

L3_1 = 0

L4_1 = 0

L5_1 = 0

L2_1 = L2_1(L3_1, L4_1, L5_1)

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  if not A0_2 then

    L2_2 = false

    return L2_2

  end

  if A1_2 then

    L2_2 = vector2

    L3_2 = A1_2[2]

    L4_2 = A1_2[1]

    L2_2 = L2_2(L3_2, L4_2)

    if L2_2 then

      goto lbl_17

    end

  end

  L2_2 = GetEntityCoords

  L3_2 = PlayerPedId

  L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2()

  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)

  ::lbl_17::

  L3_2 = AwaitCallback

  L4_2 = "maps:addLocation"

  L5_2 = A0_2

  L6_2 = L2_2.x

  L7_2 = L2_2.y

  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)

  if not L3_2 then

    L4_2 = false

    return L4_2

  end

  L4_2 = {}

  L4_2.id = L3_2

  L4_2.name = A0_2

  L5_2 = {}

  L6_2 = L2_2.y

  L7_2 = L2_2.x

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L4_2.position = L5_2

  L5_2 = SavedLocations

  L6_2 = SavedLocations

  L6_2 = #L6_2

  L6_2 = L6_2 + 1

  L5_2[L6_2] = L4_2

  return L4_2

end

function L4_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2

  L0_2 = PlayerPedId

  L0_2 = L0_2()

  L1_1 = L0_2

  L0_2 = GetEntityCoords

  L1_2 = L1_1

  L0_2 = L0_2(L1_2)

  L2_1 = L0_2

  L0_2 = SendReactMessage

  L1_2 = "maps:updateCoords"

  L2_2 = {}

  L3_2 = math

  L3_2 = L3_2.floor

  L4_2 = L2_1.x

  L4_2 = L4_2 + 0.5

  L3_2 = L3_2(L4_2)

  L2_2.x = L3_2

  L3_2 = math

  L3_2 = L3_2.floor

  L4_2 = L2_1.y

  L4_2 = L4_2 + 0.5

  L3_2 = L3_2(L4_2)

  L2_2.y = L3_2

  L0_2(L1_2, L2_2)

  while true do

    L0_2 = L0_1

    if not L0_2 then

      break

    end

    L0_2 = GetEntityCoords

    L1_2 = L1_1

    L0_2 = L0_2(L1_2)

    L1_2 = phoneOpen

    if L1_2 then

      L1_2 = L2_1

      L1_2 = L1_2 - L0_2

      L1_2 = #L1_2

      if L1_2 > 1.0 then

        L2_1 = L0_2

        L1_2 = SendReactMessage

        L2_2 = "maps:updateCoords"

        L3_2 = {}

        L4_2 = math

        L4_2 = L4_2.floor

        L5_2 = L0_2.x

        L5_2 = L5_2 + 0.5

        L4_2 = L4_2(L5_2)

        L3_2.x = L4_2

        L4_2 = math

        L4_2 = L4_2.floor

        L5_2 = L0_2.y

        L5_2 = L5_2 + 0.5

        L4_2 = L4_2(L5_2)

        L3_2.y = L4_2

        L1_2(L2_2, L3_2)

      end

    end

    L1_2 = Wait

    L2_2 = 250

    L1_2(L2_2)

  end

end

L5_1 = RegisterNUICallback

L6_1 = "Maps"

function L7_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Maps:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "getCurrentLocation" == L2_2 then

    L3_2 = GetEntityCoords

    L4_2 = PlayerPedId

    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L4_2()

    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)

    L4_2 = A1_2

    L5_2 = {}

    L6_2 = L3_2.x

    L5_2.x = L6_2

    L6_2 = L3_2.y

    L5_2.y = L6_2

    L4_2(L5_2)

  elseif "toggleUpdateCoords" == L2_2 then

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

    L3_2 = L0_1

    L4_2 = A0_2.toggle

    if L3_2 == L4_2 then

      return

    end

    L3_2 = A0_2.toggle

    L3_2 = true == L3_2

    L0_1 = L3_2

    L3_2 = L4_1

    L3_2()

  elseif "setWaypoint" == L2_2 then

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

    L3_2 = A0_2.data

    L4_2 = tonumber

    L5_2 = L3_2.x

    L4_2 = L4_2(L5_2)

    L5_2 = tonumber

    L6_2 = L3_2.y

    L5_2 = L5_2(L6_2)

    if not L4_2 or not L5_2 then

      return

    end

    L6_2 = SetNewWaypoint

    L7_2 = L4_2 / 1

    L8_2 = L5_2 / 1

    L6_2(L7_2, L8_2)

  elseif "getLocations" == L2_2 then

    L3_2 = A1_2

    L4_2 = SavedLocations

    L3_2(L4_2)

  elseif "addLocation" == L2_2 then

    L3_2 = A1_2

    L4_2 = L3_1

    L5_2 = A0_2.name

    L6_2 = A0_2.location

    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L4_2(L5_2, L6_2)

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)

  elseif "renameLocation" == L2_2 then

    L3_2 = A0_2.name

    L4_2 = L3_2 or L4_2

    if L3_2 then

      L4_2 = AwaitCallback

      L5_2 = "maps:renameLocation"

      L6_2 = A0_2.id

      L7_2 = L3_2

      L4_2 = L4_2(L5_2, L6_2, L7_2)

    end

    if not L4_2 then

      L5_2 = A1_2

      L6_2 = false

      return L5_2(L6_2)

    end

    L5_2 = 1

    L6_2 = SavedLocations

    L6_2 = #L6_2

    L7_2 = 1

    for L8_2 = L5_2, L6_2, L7_2 do

      L9_2 = SavedLocations

      L9_2 = L9_2[L8_2]

      L9_2 = L9_2.id

      L10_2 = A0_2.id

      if L9_2 == L10_2 then

        L9_2 = SavedLocations

        L9_2 = L9_2[L8_2]

        L9_2.name = L3_2

        break

      end

    end

    L5_2 = A1_2

    L6_2 = true

    L5_2(L6_2)

  elseif "removeLocation" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "maps:removeLocation"

    L5_2 = A0_2.id

    L3_2 = L3_2(L4_2, L5_2)

    if not L3_2 then

      L4_2 = A1_2

      L5_2 = false

      return L4_2(L5_2)

    end

    L4_2 = 1

    L5_2 = SavedLocations

    L5_2 = #L5_2

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = SavedLocations

      L8_2 = L8_2[L7_2]

      L8_2 = L8_2.id

      L9_2 = A0_2.id

      if L8_2 == L9_2 then

        L8_2 = table

        L8_2 = L8_2.remove

        L9_2 = SavedLocations

        L10_2 = L7_2

        L8_2(L9_2, L10_2)

        break

      end

    end

    L4_2 = A1_2

    L5_2 = true

    L4_2(L5_2)

  end

end

L5_1(L6_1, L7_1)