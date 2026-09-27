local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1

L0_1 = Config

L0_1 = L0_1.Voice

L0_1 = L0_1.HearNearby

if not L0_1 then

  return

end

L0_1 = {}

function L1_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = L0_1

  L1_2 = L1_2[A0_2]

  if not L1_2 then

    return

  end

  L1_2 = L0_1

  L1_2[A0_2] = true

  L1_2 = debugprint

  L2_2 = "entered live"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = TriggerServerEvent

  L2_2 = "phone:instagram:enteredLiveProximity"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = L0_1

  L1_2 = L1_2[A0_2]

  if not L1_2 then

    return

  end

  L1_2 = L0_1

  L1_2[A0_2] = nil

  L1_2 = debugprint

  L2_2 = "left live 1"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = TriggerServerEvent

  L2_2 = "phone:instagram:leftLiveProximity"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:endLive"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  if not A1_2 then

    L2_2 = L0_1

    L2_2[A0_2] = nil

    L2_2 = debugprint

    L3_2 = "left live 2"

    L4_2 = A0_2

    return L2_2(L3_2, L4_2)

  end

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  if L2_2 then

    L2_2 = L0_1

    L2_2[A0_2] = nil

    L2_2 = TriggerServerEvent

    L3_2 = "phone:instagram:leftLiveProximity"

    L4_2 = A1_2

    L5_2 = true

    L2_2(L3_2, L4_2, L5_2)

  end

end

L3_1(L4_1, L5_1)

L3_1 = {}

function L4_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2

  if not A0_2 then

    return

  end

  L1_2 = table

  L1_2 = L1_2.contains

  L2_2 = L3_1

  L3_2 = A0_2

  L1_2, L2_2 = L1_2(L2_2, L3_2)

  if not L1_2 then

    return

  end

  L3_2 = debugprint

  L4_2 = "left proximity of"

  L5_2 = A0_2

  L3_2(L4_2, L5_2)

  L3_2 = TriggerServerEvent

  L4_2 = "phone:phone:leftCallProximity"

  L5_2 = A0_2

  L3_2(L4_2, L5_2)

  L3_2 = Config

  L3_2 = L3_2.Voice

  L3_2 = L3_2.SpatialAudio

  if L3_2 then

    L3_2 = ResetSpatialAudioSubmixForSource

    L4_2 = A0_2

    L3_2(L4_2)

  end

  L3_2 = table

  L3_2 = L3_2.remove

  L4_2 = L3_1

  L5_2 = L2_2

  L3_2(L4_2, L5_2)

  L3_2 = true

  return L3_2

end

function L5_1(A0_2)

  local L1_2, L2_2, L3_2

  if A0_2 then

    L1_2 = table

    L1_2 = L1_2.contains

    L2_2 = L3_1

    L3_2 = A0_2

    L1_2 = L1_2(L2_2, L3_2)

    if not L1_2 then

      goto lbl_11

    end

  end

  do return end

  ::lbl_11::

  L1_2 = debugprint

  L2_2 = "entered proximity of"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = TriggerServerEvent

  L2_2 = "phone:phone:enteredCallProximity"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = Config

  L1_2 = L1_2.Voice

  L1_2 = L1_2.SpatialAudio

  if L1_2 then

    L1_2 = SetSpatialAudioSubmixForSource

    L2_2 = A0_2

    L1_2(L2_2)

  end

  L1_2 = L3_1

  L1_2 = #L1_2

  L2_2 = L1_2 + 1

  L1_2 = L3_1

  L1_2[L2_2] = A0_2

  L1_2 = true

  return L1_2

end

L6_1 = Interval

L7_1 = L6_1

L6_1 = L6_1.new

function L8_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2

  L1_2 = GetNearbyPlayers

  L1_2 = L1_2()

  L2_2 = GetEntityCoords

  L3_2 = PlayerPedId

  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L3_2()

  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)

  L3_2 = 1

  L4_2 = #L1_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = L1_2[L6_2]

    L8_2 = Player

    L9_2 = L7_2.source

    L8_2 = L8_2(L9_2)

    L8_2 = L8_2.state

    L9_2 = L8_2.onCallWith

    if L9_2 then

      L9_2 = L8_2.speakerphone

      if L9_2 then

        L9_2 = L8_2.callAnswered

      end

    end

    L10_2 = L8_2.instapicIsLive

    L11_2 = GetEntityCoords

    L12_2 = L7_2.ped

    L11_2 = L11_2(L12_2)

    L12_2 = L2_2 - L11_2

    L12_2 = #L12_2

    if L12_2 <= 10 then

      if L10_2 then

        L13_2 = L1_1

        L14_2 = L10_2

        L13_2(L14_2)

      elseif L9_2 then

        L13_2 = L5_1

        L14_2 = L7_2.source

        L13_2(L14_2)

      else

        L13_2 = L8_2.onCallWith

        if L13_2 then

          L13_2 = L4_1

          L14_2 = L7_2.source

          L13_2(L14_2)

        end

      end

    elseif L10_2 then

      L13_2 = L2_1

      L14_2 = L10_2

      L13_2(L14_2)

    else

      L13_2 = L8_2.onCallWith

      if L13_2 then

        L13_2 = L4_1

        L14_2 = L7_2.source

        L13_2(L14_2)

      end

    end

  end

  L3_2 = 1

  L4_2 = L3_1

  L4_2 = #L4_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = L3_1

    L7_2 = L7_2[L6_2]

    L8_2 = Player

    L9_2 = L7_2

    L8_2 = L8_2(L9_2)

    L8_2 = L8_2.state

    L8_2 = L8_2.onCallWith

    if not L8_2 then

      L8_2 = L4_1

      L9_2 = L7_2

      L8_2(L9_2)

    end

  end

end

L9_1 = 250

L10_1 = false

L6_1 = L6_1(L7_1, L8_1, L9_1, L10_1)

function L7_1()

  local L0_2, L1_2

  L0_2 = debugprint

  L1_2 = "Hear nearby interval started"

  L0_2(L1_2)

end

L6_1.onStart = L7_1

function L7_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L0_2 = debugprint

  L1_2 = "Hear nearby interval stopped"

  L0_2(L1_2)

  L0_2 = 1

  L1_2 = L3_1

  L1_2 = #L1_2

  L2_2 = 1

  for L3_2 = L0_2, L1_2, L2_2 do

    L4_2 = L3_1

    L4_2 = L4_2[L3_2]

    L5_2 = debugprint

    L6_2 = "left proximity of"

    L7_2 = L4_2

    L5_2(L6_2, L7_2)

    L5_2 = TriggerServerEvent

    L6_2 = "phone:phone:leftCallProximity"

    L7_2 = L4_2

    L5_2(L6_2, L7_2)

    L5_2 = Config

    L5_2 = L5_2.Voice

    L5_2 = L5_2.SpatialAudio

    if L5_2 then

      L5_2 = ResetSpatialAudioSubmixForSource

      L6_2 = L4_2

      L5_2(L6_2)

    end

  end

  L0_2 = table

  L0_2 = L0_2.wipe

  L1_2 = L3_1

  L0_2(L1_2)

  L0_2 = pairs

  L1_2 = L0_1

  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)

  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do

    L6_2 = L2_1

    L7_2 = L4_2

    L6_2(L7_2)

  end

end

L6_1.onStop = L7_1

L7_1 = {}

L8_1 = "onCallWith"

L9_1 = "speakerphone"

L10_1 = "callAnswered"

L11_1 = "instapicIsLive"

L7_1[1] = L8_1

L7_1[2] = L9_1

L7_1[3] = L10_1

L7_1[4] = L11_1

L8_1 = {}

L9_1 = 1

L10_1 = #L7_1

L11_1 = 1

for L12_1 = L9_1, L10_1, L11_1 do

  L13_1 = AddStateBagChangeHandler

  L14_1 = L7_1[L12_1]

  L15_1 = nil

  function L16_1(A0_2, A1_2, A2_2, A3_2, A4_2)

    local L5_2, L6_2, L7_2, L8_2, L9_2

    L5_2 = GetPlayerDataFromStateBag

    L6_2 = A0_2

    L5_2, L6_2 = L5_2(L6_2)

    if L5_2 then

      L7_2 = GetPlayerServerId

      L8_2 = PlayerId

      L8_2, L9_2 = L8_2()

      L7_2 = L7_2(L8_2, L9_2)

      if L5_2 ~= L7_2 then

        goto lbl_13

      end

    end

    do return end

    ::lbl_13::

    L7_2 = Wait

    L8_2 = 0

    L7_2(L8_2)

    if A2_2 then

      L7_2 = L8_1

      L8_2 = L8_1

      L8_2 = L8_2[L5_2]

      if not L8_2 then

        L8_2 = {}

      end

      L7_2[L5_2] = L8_2

      L7_2 = L8_1

      L7_2 = L7_2[L5_2]

      L8_2 = not A2_2

      L8_2 = not L8_2

      L7_2[A1_2] = L8_2

      L7_2 = L6_1

      L8_2 = L7_2

      L7_2 = L7_2.toggle

      L9_2 = true

      L7_2(L8_2, L9_2)

    else

      L7_2 = L8_1

      L7_2 = L7_2[L5_2]

      if L7_2 then

        L7_2 = L8_1

        L7_2 = L7_2[L5_2]

        L7_2[A1_2] = nil

        L7_2 = next

        L8_2 = L8_1

        L8_2 = L8_2[L5_2]

        L7_2 = L7_2(L8_2)

        if nil == L7_2 then

          L7_2 = L8_1

          L7_2[L5_2] = nil

        end

      end

    end

    L7_2 = next

    L8_2 = L8_1

    L7_2 = L7_2(L8_2)

    if not L7_2 then

      L7_2 = L6_1

      L8_2 = L7_2

      L7_2 = L7_2.toggle

      L9_2 = false

      L7_2(L8_2, L9_2)

    end

  end

  L13_1(L14_1, L15_1, L16_1)

end

L9_1 = RegisterNetEvent

L10_1 = "onPlayerDropped"

function L11_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = L8_1

  L1_2[A0_2] = nil

  L1_2 = next

  L2_2 = L8_1

  L1_2 = L1_2(L2_2)

  if not L1_2 then

    L1_2 = L6_1

    L2_2 = L1_2

    L1_2 = L1_2.toggle

    L3_2 = false

    L1_2(L2_2, L3_2)

  end

end

L9_1(L10_1, L11_1)
