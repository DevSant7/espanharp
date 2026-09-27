local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1

L0_1 = Config

L0_1 = L0_1.Sound

L0_1 = L0_1.Sync

if not L0_1 then

  return

end

L0_1 = {}

L0_1.cameraShutter = true

L0_1.notification = true

L0_1.ringtone = true

L0_1.alarm = true

L1_1 = {}

L1_1.vibrate_ringtone_ = true

L1_1.alarm_other_ = true

L1_1["camera-shutter_other_"] = true

L2_1 = pairs

L3_1 = Config

L3_1 = L3_1.Sound

L3_1 = L3_1.Ringtones

L2_1, L3_1, L4_1, L5_1 = L2_1(L3_1)

for L6_1, L7_1 in L2_1, L3_1, L4_1, L5_1 do

  L8_1 = L7_1.name

  L9_1 = "_"

  L10_1 = L7_1.soundSet

  L11_1 = "_"

  L12_1 = L7_1.audioBank

  if not L12_1 then

    L12_1 = ""

  end

  L8_1 = L8_1 .. L9_1 .. L10_1 .. L11_1 .. L12_1

  L1_1[L8_1] = true

end

L2_1 = pairs

L3_1 = Config

L3_1 = L3_1.Sound

L3_1 = L3_1.Notifications

L2_1, L3_1, L4_1, L5_1 = L2_1(L3_1)

for L6_1, L7_1 in L2_1, L3_1, L4_1, L5_1 do

  L8_1 = L7_1.name

  L9_1 = "_"

  L10_1 = L7_1.soundSet

  L11_1 = "_"

  L12_1 = L7_1.audioBank

  if not L12_1 then

    L12_1 = ""

  end

  L8_1 = L8_1 .. L9_1 .. L10_1 .. L11_1 .. L12_1

  L1_1[L8_1] = true

end

L2_1 = RegisterNetEvent

L3_1 = "phone:sound:playSound"

function L4_1(A0_2, A1_2, A2_2, A3_2, A4_2)

  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2

  L5_2 = source

  L6_2 = GetEquippedPhoneNumber

  L7_2 = L5_2

  L6_2 = L6_2(L7_2)

  if not L6_2 then

    return

  end

  L7_2 = L0_1

  L7_2 = L7_2[A1_2]

  if not L7_2 then

    L7_2 = infoprint

    L8_2 = "warning"

    L9_2 = DebugPlayerName

    L10_2 = L5_2

    L9_2 = L9_2(L10_2)

    L10_2 = " tried to play an invalid sound type: "

    L11_2 = tostring

    L12_2 = A1_2

    L11_2 = L11_2(L12_2)

    L9_2 = L9_2 .. L10_2 .. L11_2

    L7_2(L8_2, L9_2)

    return

  end

  L7_2 = A2_2

  L8_2 = "_"

  L9_2 = A3_2 or L9_2

  if not A3_2 then

    L9_2 = ""

  end

  L10_2 = "_"

  L11_2 = A4_2 or L11_2

  if not A4_2 then

    L11_2 = ""

  end

  L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2

  L8_2 = L1_1

  L8_2 = L8_2[L7_2]

  if not L8_2 then

    L8_2 = infoprint

    L9_2 = "warning"

    L10_2 = DebugPlayerName

    L11_2 = L5_2

    L10_2 = L10_2(L11_2)

    L11_2 = " tried to play an invalid sound: "

    L12_2 = L7_2

    L10_2 = L10_2 .. L11_2 .. L12_2

    L8_2(L9_2, L10_2)

    return

  end

  L8_2 = GetSettings

  L9_2 = L6_2

  L8_2 = L8_2(L9_2)

  L9_2 = L8_2 or L9_2

  if L8_2 then

    L9_2 = L8_2.sound

    if L9_2 then

      L9_2 = L9_2.volume

    end

  end

  if not L9_2 then

    L9_2 = 1.0

  end

  if "ringtone" == A1_2 or "alarm" == A1_2 then

    L10_2 = Player

    L11_2 = L5_2

    L10_2 = L10_2(L11_2)

    L10_2 = L10_2.state

    L11_2 = {}

    L12_2 = A1_2

    L13_2 = L9_2

    L14_2 = A2_2

    L15_2 = A3_2

    L16_2 = A4_2

    L11_2[1] = L12_2

    L11_2[2] = L13_2

    L11_2[3] = L14_2

    L11_2[4] = L15_2

    L11_2[5] = L16_2

    L10_2.lbPhoneAudio = L11_2

    return

  end

  if not A0_2 then

    return

  end

  L10_2 = GetEntityCoords

  L11_2 = GetPlayerPed

  L12_2 = L5_2

  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L11_2(L12_2)

  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)

  L11_2 = 1

  L12_2 = #A0_2

  L13_2 = 1

  for L14_2 = L11_2, L12_2, L13_2 do

    L15_2 = A0_2[L14_2]

    L16_2 = Config

    L16_2 = L16_2.Sound

    L16_2 = L16_2.DistanceCheck

    if true == L16_2 and L10_2 then

      L16_2 = GetEntityCoords

      L17_2 = GetPlayerPed

      L18_2 = L15_2

      L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L17_2(L18_2)

      L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)

      L17_2 = L10_2 - L16_2

      L17_2 = #L17_2

      if L17_2 > 100.0 then

        L17_2 = debugprint

        L18_2 = "Skipping sound for source:"

        L19_2 = L15_2

        L20_2 = "due to distance check."

        L17_2(L18_2, L19_2, L20_2)

    end

    else

      L16_2 = TriggerClientEvent

      L17_2 = "phone:sound:playSound"

      L18_2 = A0_2[L14_2]

      L19_2 = L5_2

      L20_2 = A1_2

      L21_2 = L9_2

      L22_2 = A2_2

      L23_2 = A3_2

      L24_2 = A4_2

      L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)

    end

  end

end

L2_1(L3_1, L4_1)

L2_1 = RegisterNetEvent

L3_1 = "phone:sound:stopSound"

function L4_1()

  local L0_2, L1_2, L2_2, L3_2

  L0_2 = source

  L1_2 = Player

  L2_2 = L0_2

  L1_2 = L1_2(L2_2)

  L1_2 = L1_2.state

  L1_2.lbPhoneAudio = nil

  L1_2 = TriggerClientEvent

  L2_2 = "phone:sound:stopSound"

  L3_2 = L0_2

  L1_2(L2_2, L3_2)

end

L2_1(L3_1, L4_1)
