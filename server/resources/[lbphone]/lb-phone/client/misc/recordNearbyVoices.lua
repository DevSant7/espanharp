local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1

L0_1 = RegisterNUICallback

L1_1 = "voice:getConfig"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = A1_2

  L3_2 = {}

  L4_2 = Config

  L4_2 = L4_2.Voice

  L4_2 = L4_2.RecordNearby

  L3_2.recordNearbyVoices = L4_2

  L4_2 = Config

  L4_2 = L4_2.RTCConfig

  L3_2.rtc = L4_2

  L2_2(L3_2)

end

L0_1(L1_1, L2_1)

L0_1 = Config

L0_1 = L0_1.Voice

L0_1 = L0_1.RecordNearby

if not L0_1 then

  return

end

L0_1 = {}

L1_1 = Interval

L2_1 = L1_1

L1_1 = L1_1.new

function L3_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L0_2 = GetEntityCoords

  L1_2 = PlayerPedId

  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()

  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)

  L1_2 = 1

  L2_2 = L0_1

  L2_2 = #L2_2

  L3_2 = 1

  for L4_2 = L1_2, L2_2, L3_2 do

    L5_2 = L0_1

    L5_2 = L5_2[L4_2]

    L6_2 = GetEntityCoords

    L7_2 = L5_2.ped

    L6_2 = L6_2(L7_2)

    L6_2 = L0_2 - L6_2

    L6_2 = #L6_2

    L7_2 = GetVoiceVolume

    L8_2 = L6_2

    L7_2 = L7_2(L8_2)

    L8_2 = L5_2.volume

    if L7_2 == L8_2 then

    else

      L5_2.volume = L7_2

      L8_2 = SendReactMessage

      L9_2 = "voice:setVolume"

      L10_2 = {}

      L11_2 = L5_2.channel

      L10_2.channel = L11_2

      L10_2.volume = L7_2

      L8_2(L9_2, L10_2)

    end

  end

end

L4_1 = 50

L5_1 = false

L1_1 = L1_1(L2_1, L3_1, L4_1, L5_1)

L2_1 = Interval

L3_1 = L2_1

L2_1 = L2_1.new

function L4_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2

  L0_2 = {}

  L1_2 = GetNearbyPlayers

  L1_2 = L1_2()

  L2_2 = GetEntityCoords

  L3_2 = PlayerPedId

  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L3_2()

  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)

  L3_2 = 1

  L4_2 = #L1_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = L1_2[L6_2]

    L8_2 = Player

    L9_2 = L7_2.source

    L8_2 = L8_2(L9_2)

    L8_2 = L8_2.state

    L9_2 = L8_2 or L9_2

    if L8_2 then

      L9_2 = L8_2.listeningPeerId

    end

    if not L9_2 then

    else

      L9_2 = GetEntityCoords

      L10_2 = L7_2.ped

      L9_2 = L9_2(L10_2)

      L9_2 = L2_2 - L9_2

      L9_2 = #L9_2

      if L9_2 > 25.0 then

      else

        L10_2 = #L0_2

        L10_2 = L10_2 + 1

        L11_2 = {}

        L12_2 = L7_2.source

        L11_2.source = L12_2

        L12_2 = L7_2.ped

        L11_2.ped = L12_2

        L12_2 = L8_2.listeningPeerId

        L11_2.channel = L12_2

        L0_2[L10_2] = L11_2

        L10_2 = 1

        L11_2 = L0_1

        L11_2 = #L11_2

        L12_2 = 1

        for L13_2 = L10_2, L11_2, L12_2 do

          L14_2 = L0_1

          L14_2 = L14_2[L13_2]

          L15_2 = L14_2.source

          L16_2 = L7_2.source

          if L15_2 == L16_2 then

            L15_2 = #L0_2

            L15_2 = L0_2[L15_2]

            L16_2 = L14_2.volume

            L15_2.volume = L16_2

            goto lbl_79

          end

        end

        L10_2 = #L0_2

        L10_2 = L0_2[L10_2]

        L11_2 = GetVoiceVolume

        L12_2 = L9_2

        L11_2 = L11_2(L12_2)

        L10_2.volume = L11_2

        L10_2 = SendReactMessage

        L11_2 = "voice:joinChannel"

        L12_2 = {}

        L13_2 = L8_2.listeningPeerId

        L12_2.channel = L13_2

        L13_2 = GetVoiceVolume

        L14_2 = L9_2

        L13_2 = L13_2(L14_2)

        L12_2.volume = L13_2

        L10_2(L11_2, L12_2)

      end

    end

    ::lbl_79::

  end

  L0_1 = L0_2

  L3_2 = L1_1

  L4_2 = L3_2

  L3_2 = L3_2.toggle

  L5_2 = L0_1

  L5_2 = #L5_2

  L5_2 = L5_2 > 0

  L3_2(L4_2, L5_2)

end

L5_1 = 1000

L2_1(L3_1, L4_1, L5_1)

L2_1 = RegisterNetEvent

L3_1 = "phone:startedListening"

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L2_2 = GetPlayerFromServerId

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  if L2_2 then

    L3_2 = PlayerId

    L3_2 = L3_2()

    if L2_2 ~= L3_2 and -1 ~= L2_2 then

      goto lbl_13

    end

  end

  do return end

  ::lbl_13::

  L3_2 = PlayerPedId

  L3_2 = L3_2()

  L4_2 = GetPlayerPed

  L5_2 = L2_2

  L4_2 = L4_2(L5_2)

  L5_2 = GetEntityCoords

  L6_2 = L3_2

  L5_2 = L5_2(L6_2)

  L6_2 = GetEntityCoords

  L7_2 = L4_2

  L6_2 = L6_2(L7_2)

  L5_2 = L5_2 - L6_2

  L5_2 = #L5_2

  L6_2 = DoesEntityExist

  L7_2 = L4_2

  L6_2 = L6_2(L7_2)

  if not L6_2 or L4_2 == L3_2 or L5_2 > 25.0 then

    return

  end

  L6_2 = 1

  L7_2 = L0_1

  L7_2 = #L7_2

  L8_2 = 1

  for L9_2 = L6_2, L7_2, L8_2 do

    L10_2 = L0_1

    L10_2 = L10_2[L9_2]

    L11_2 = L10_2.source

    if L11_2 == A0_2 then

      return

    end

  end

  L6_2 = L0_1

  L6_2 = #L6_2

  L7_2 = L6_2 + 1

  L6_2 = L0_1

  L8_2 = {}

  L8_2.source = A0_2

  L8_2.ped = L4_2

  L8_2.channel = A1_2

  L9_2 = GetVoiceVolume

  L10_2 = L5_2

  L9_2 = L9_2(L10_2)

  L8_2.volume = L9_2

  L6_2[L7_2] = L8_2

  L6_2 = SendReactMessage

  L7_2 = "voice:joinChannel"

  L8_2 = {}

  L8_2.channel = A1_2

  L9_2 = GetVoiceVolume

  L10_2 = L5_2

  L9_2 = L9_2(L10_2)

  L8_2.volume = L9_2

  L6_2(L7_2, L8_2)

end

L2_1(L3_1, L4_1)

L2_1 = RegisterNetEvent

L3_1 = "phone:stoppedListening"

function L4_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "voice:leaveChannel"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L2_1(L3_1, L4_1)

L2_1 = RegisterNUICallback

L3_1 = "setListeningPeerId"

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = TriggerServerEvent

  L3_2 = "phone:setListeningPeerId"

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L2_1(L3_1, L4_1)
