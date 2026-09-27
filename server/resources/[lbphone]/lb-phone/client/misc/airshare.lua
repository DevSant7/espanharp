local L0_1, L1_1, L2_1, L3_1

function L0_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2

  L0_2 = {}

  L1_2 = GetNearbyPlayers

  L1_2 = L1_2()

  L2_2 = GetEntityCoords

  L3_2 = PlayerPedId

  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2()

  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

  L3_2 = debugprint

  L4_2 = "Nearby players:"

  L5_2 = L1_2

  L3_2(L4_2, L5_2)

  L3_2 = 1

  L4_2 = #L1_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = L1_2[L6_2]

    L8_2 = Player

    L9_2 = L7_2.source

    L8_2 = L8_2(L9_2)

    L8_2 = L8_2.state

    L9_2 = GetEntityCoords

    L10_2 = L7_2.ped

    L9_2 = L9_2(L10_2)

    L9_2 = L2_2 - L9_2

    L9_2 = #L9_2

    L10_2 = 7.5

    if L9_2 > L10_2 then

      L9_2 = debugprint

      L10_2 = "Player is too far away"

      L11_2 = L7_2.source

      L9_2(L10_2, L11_2)

    else

      L9_2 = debugprint

      L10_2 = "Player data"

      L11_2 = L7_2.source

      L12_2 = L7_2

      L9_2(L10_2, L11_2, L12_2)

      L9_2 = L8_2.lbTabletOpen

      if L9_2 then

        L9_2 = debugprint

        L10_2 = "Player has tablet open"

        L11_2 = L7_2.source

        L9_2(L10_2, L11_2)

        L9_2 = #L0_2

        L9_2 = L9_2 + 1

        L10_2 = {}

        L11_2 = L8_2.lbTabletName

        if not L11_2 then

          L11_2 = "??"

        end

        L10_2.name = L11_2

        L11_2 = L7_2.source

        L10_2.source = L11_2

        L10_2.device = "tablet"

        L0_2[L9_2] = L10_2

      else

        L9_2 = L8_2.phoneOpen

        if L9_2 then

          L9_2 = debugprint

          L10_2 = "Player has phone open"

          L11_2 = L7_2.source

          L9_2(L10_2, L11_2)

          L9_2 = #L0_2

          L9_2 = L9_2 + 1

          L10_2 = {}

          L11_2 = L8_2.phoneName

          if not L11_2 then

            L11_2 = "??"

          end

          L10_2.name = L11_2

          L11_2 = L7_2.source

          L10_2.source = L11_2

          L10_2.device = "phone"

          L0_2[L9_2] = L10_2

        else

          L9_2 = debugprint

          L10_2 = "Player has no device open"

          L11_2 = L7_2.source

          L9_2(L10_2, L11_2)

        end

      end

    end

  end

  L3_2 = debugprint

  L4_2 = "Nearby devices:"

  L5_2 = L0_2

  L3_2(L4_2, L5_2)

  return L0_2

end

L1_1 = RegisterNUICallback

L2_1 = "AirShare"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "AirShare:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "getNearby" == L2_2 then

    L3_2 = A1_2

    L4_2 = L0_1

    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2()

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "share" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "airShare:share"

    L5_2 = A1_2

    L6_2 = A0_2.source

    L7_2 = A0_2.device

    L8_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "accept" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:airShare:interacted"

    L5_2 = A0_2.source

    L6_2 = A0_2.device

    L7_2 = true

    L3_2(L4_2, L5_2, L6_2, L7_2)

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

  elseif "deny" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:airShare:interacted"

    L5_2 = A0_2.source

    L6_2 = A0_2.device

    L7_2 = false

    L3_2(L4_2, L5_2, L6_2, L7_2)

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

  end

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:airShare:received"

function L3_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = debugprint

  L2_2 = "phone:airShare:received"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "airShare:received"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:airShare:interacted"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "airShare:interacted"

  L4_2 = {}

  L4_2.source = A0_2

  L4_2.accepted = A1_2

  L2_2(L3_2, L4_2)

end

L1_1(L2_1, L3_1)
