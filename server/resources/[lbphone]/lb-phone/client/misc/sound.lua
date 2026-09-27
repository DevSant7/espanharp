local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1

L0_1 = {}

L1_1 = nil

function L2_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = "1"

  L2_2 = "ringtone"

  L3_2 = nil

  if "vibrate" == A0_2 then

    L4_2 = "vibrate"

    L5_2 = "ringtone"

    return L4_2, L5_2

  end

  if A0_2 then

    L4_2 = Config

    L4_2 = L4_2.Sound

    L4_2 = L4_2.Ringtones

    L4_2 = L4_2[A0_2]

    if L4_2 then

      goto lbl_23

    end

  end

  L4_2 = next

  L5_2 = Config

  L5_2 = L5_2.Sound

  L5_2 = L5_2.Ringtones

  L4_2 = L4_2(L5_2)

  A0_2 = L4_2

  ::lbl_23::

  if A0_2 then

    L4_2 = Config

    L4_2 = L4_2.Sound

    L4_2 = L4_2.Ringtones

    L4_2 = L4_2[A0_2]

    L1_2 = L4_2.name

    L2_2 = L4_2.soundSet

    L3_2 = L4_2.audioBank

  end

  L4_2 = L1_2

  L5_2 = L2_2

  L6_2 = L3_2

  return L4_2, L5_2, L6_2

end

function L3_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = "1"

  L2_2 = "notification"

  L3_2 = nil

  if "vibrate" == A0_2 then

    L4_2 = "vibrate"

    L5_2 = "notification"

    return L4_2, L5_2

  end

  if A0_2 then

    L4_2 = Config

    L4_2 = L4_2.Sound

    L4_2 = L4_2.Notifications

    L4_2 = L4_2[A0_2]

    if L4_2 then

      goto lbl_23

    end

  end

  L4_2 = next

  L5_2 = Config

  L5_2 = L5_2.Sound

  L5_2 = L5_2.Notifications

  L4_2 = L4_2(L5_2)

  A0_2 = L4_2

  ::lbl_23::

  if A0_2 then

    L4_2 = Config

    L4_2 = L4_2.Sound

    L4_2 = L4_2.Notifications

    L4_2 = L4_2[A0_2]

    L1_2 = L4_2.name

    L2_2 = L4_2.soundSet

    L3_2 = L4_2.audioBank

  end

  L4_2 = L1_2

  L5_2 = L2_2

  L6_2 = L3_2

  return L4_2, L5_2, L6_2

end

function L4_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = GetGameTimer

  L1_2 = L1_2()

  L1_2 = L1_2 + 1000

  L2_2 = debugprint

  L3_2 = "Waiting for audio bank to load"

  L2_2(L3_2)

  while true do

    L2_2 = RequestScriptAudioBank

    L3_2 = A0_2 or L3_2

    if not A0_2 then

      L3_2 = "dlc_lbscripts/sounds"

    end

    L4_2 = false

    L2_2 = L2_2(L3_2, L4_2)

    if L2_2 then

      break

    end

    L2_2 = Wait

    L3_2 = 0

    L2_2(L3_2)

    L2_2 = GetGameTimer

    L2_2 = L2_2()

    if L1_2 < L2_2 then

      L2_2 = infoprint

      L3_2 = "warning"

      L4_2 = "Failed to load audio bank, setting Config.Sound.System to 'nui'. This usually happens when you have too many sounds on your server."

      L2_2(L3_2, L4_2)

      L2_2 = Config

      L2_2 = L2_2.Sound

      L2_2.System = "nui"

      L2_2 = SendReactMessage

      L3_2 = "updateConfigValue"

      L4_2 = {}

      L5_2 = {}

      L6_2 = {}

      L6_2.system = "nui"

      L5_2.sound = L6_2

      L4_2.config = L5_2

      L2_2(L3_2, L4_2)

      L2_2 = false

      return L2_2

    end

  end

  L2_2 = debugprint

  L3_2 = "Audio bank loaded"

  L2_2(L3_2)

  L2_2 = true

  return L2_2

end

function L5_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)

  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2

  L6_2 = Config

  L6_2 = L6_2.Sound

  L6_2 = L6_2.System

  if "nui" == L6_2 then

    return

  end

  L6_2 = type

  L7_2 = Config

  L7_2 = L7_2.Sound

  L7_2 = L7_2.Volume

  L7_2 = L7_2.Static

  L6_2 = L6_2(L7_2)

  if "number" == L6_2 then

    L6_2 = Config

    L6_2 = L6_2.Sound

    L6_2 = L6_2.Volume

    A2_2 = L6_2.Static

  end

  L6_2 = Config

  L6_2 = L6_2.Sound

  L6_2 = L6_2.Volume

  L6_2 = L6_2.Multiplier

  if L6_2 then

    L6_2 = Config

    L6_2 = L6_2.Sound

    L6_2 = L6_2.Volume

    L6_2 = L6_2.Multiplier

    A2_2 = A2_2 * L6_2

  end

  L6_2 = math

  L6_2 = L6_2.clamp

  L7_2 = A2_2

  L8_2 = Config

  L8_2 = L8_2.Sound

  L8_2 = L8_2.Volume

  L8_2 = L8_2.Min

  if not L8_2 then

    L8_2 = 0.0

  end

  L9_2 = Config

  L9_2 = L9_2.Sound

  L9_2 = L9_2.Volume

  L9_2 = L9_2.Max

  if not L9_2 then

    L9_2 = 1.0

  end

  L6_2 = L6_2(L7_2, L8_2, L9_2)

  A2_2 = L6_2

  L6_2 = math

  L6_2 = L6_2.clamp

  L7_2 = A2_2

  L8_2 = 0.0

  L9_2 = 1.0

  L6_2 = L6_2(L7_2, L8_2, L9_2)

  A2_2 = L6_2

  L6_2 = A2_2 or L6_2

  if not A2_2 then

    L6_2 = 1

  end

  A2_2 = L6_2 / 1

  if 0 == A2_2 then

    return

  end

  L6_2 = L4_1

  L7_2 = A5_2

  L6_2 = L6_2(L7_2)

  if not L6_2 then

    return

  end

  L6_2 = GetSoundId

  L6_2 = L6_2()

  L7_2 = debugprint

  L8_2 = "Playing sound:"

  L9_2 = A3_2

  L10_2 = A4_2

  L11_2 = "with volume:"

  L12_2 = A2_2

  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)

  L7_2 = PlaySoundFromEntity

  L8_2 = L6_2

  L9_2 = A3_2

  L10_2 = A0_2

  L11_2 = A4_2

  L12_2 = false

  L13_2 = 0

  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)

  L7_2 = SetVariableOnSound

  L8_2 = L6_2

  L9_2 = "Volume"

  L10_2 = A2_2

  L7_2(L8_2, L9_2, L10_2)

  L7_2 = ReleaseScriptAudioBank

  L7_2()

  if "ringtone" ~= A1_2 and "alarm" ~= A1_2 then

    L7_2 = ReleaseSoundId

    L8_2 = L6_2

    L7_2(L8_2)

  end

  L7_2 = PlayerPedId

  L7_2 = L7_2()

  if A0_2 ~= L7_2 then

    L8_2 = Config

    L8_2 = L8_2.Sound

    L8_2 = L8_2.MaxDistance

    if L8_2 then

      L8_2 = Citizen

      L8_2 = L8_2.CreateThreadNow

      function L9_2()

        local L0_3, L1_3, L2_3, L3_3, L4_3

        L0_3 = false

        while true do

          L1_3 = HasSoundFinished

          L2_3 = L6_2

          L1_3 = L1_3(L2_3)

          if L1_3 then

            break

          end

          L1_3 = GetEntityCoords

          L2_3 = L7_2

          L1_3 = L1_3(L2_3)

          L2_3 = GetEntityCoords

          L3_3 = A0_2

          L2_3 = L2_3(L3_3)

          L1_3 = L1_3 - L2_3

          L1_3 = #L1_3

          L2_3 = Config

          L2_3 = L2_3.Sound

          L2_3 = L2_3.MaxDistance

          if L1_3 > L2_3 then

            if not L0_3 then

              L1_3 = SetVariableOnSound

              L2_3 = L6_2

              L3_3 = "Volume"

              L4_3 = 0.0

              L1_3(L2_3, L3_3, L4_3)

              L1_3 = debugprint

              L2_3 = "Sound volume set to 0 due to being too far away"

              L1_3(L2_3)

              L0_3 = true

            end

          elseif L0_3 then

            L1_3 = SetVariableOnSound

            L2_3 = L6_2

            L3_3 = "Volume"

            L4_3 = A2_2

            L1_3(L2_3, L3_3, L4_3)

            L1_3 = debugprint

            L2_3 = "Sound volume restored"

            L1_3(L2_3)

            L0_3 = false

          end

          L1_3 = Wait

          L2_3 = 100

          L1_3(L2_3)

        end

      end

      L8_2(L9_2)

    end

  end

  return L6_2

end

function L6_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2

  L2_2 = settings

  if L2_2 then

    L2_2 = L2_2.sound

    if L2_2 then

      L2_2 = L2_2.volume

    end

  end

  if not L2_2 then

    L2_2 = 0.5

  end

  L2_2 = L2_2 / 1

  L3_2 = nil

  L4_2 = nil

  L5_2 = nil

  L6_2 = debugprint

  L7_2 = "PlayPhoneSound"

  L8_2 = A0_2

  L6_2(L7_2, L8_2)

  L6_2 = ValidateChecks

  L7_2 = "playNativePhoneSound"

  L8_2 = A0_2

  L9_2 = A1_2

  L6_2 = L6_2(L7_2, L8_2, L9_2)

  if not L6_2 then

    L6_2 = debugprint

    L7_2 = "PlayPhoneSound: playNativePhoneSound check cancelled the sound"

    L6_2(L7_2)

    return

  end

  if "ringtone" == A0_2 or "alarm" == A0_2 then

    L6_2 = L1_1

    if L6_2 then

      L6_2 = StopSound

      L7_2 = L1_1

      L6_2(L7_2)

      L6_2 = ReleaseSoundId

      L7_2 = L1_1

      L6_2(L7_2)

      L6_2 = nil

      L1_1 = L6_2

    end

  end

  if "cameraShutter" == A0_2 then

    L3_2 = "camera-shutter"

    L4_2 = "other"

  elseif "ringtone" == A0_2 then

    L6_2 = A1_2 or L6_2

    if not A1_2 then

      L6_2 = settings

      if L6_2 then

        L6_2 = L6_2.sound

        if L6_2 then

          L6_2 = L6_2.ringtone

        end

      end

    end

    L7_2 = settings

    if L7_2 then

      L7_2 = L7_2.sound

      if L7_2 then

        L7_2 = L7_2.silent

      end

    end

    if L7_2 then

      L6_2 = "vibrate"

      L2_2 = 1.0

    end

    L7_2 = L2_1

    L8_2 = L6_2

    L7_2, L8_2, L9_2 = L7_2(L8_2)

    L5_2 = L9_2

    L4_2 = L8_2

    L3_2 = L7_2

  elseif "alarm" == A0_2 then

    L3_2 = "alarm"

    L4_2 = "other"

    L6_2 = settings

    if L6_2 then

      L6_2 = L6_2.sound

      if L6_2 then

        L6_2 = L6_2.silent

      end

    end

    if L6_2 then

      L6_2 = L2_1

      L7_2 = "vibrate"

      L6_2, L7_2, L8_2 = L6_2(L7_2)

      L5_2 = L8_2

      L4_2 = L7_2

      L3_2 = L6_2

      L2_2 = 1.0

    end

  elseif "notification" == A0_2 then

    L6_2 = L3_1

    L7_2 = A1_2 or L7_2

    if not A1_2 then

      L7_2 = settings

      if L7_2 then

        L7_2 = L7_2.sound

        if L7_2 then

          L7_2 = L7_2.notification

        end

      end

    end

    L6_2, L7_2, L8_2 = L6_2(L7_2)

    L5_2 = L8_2

    L4_2 = L7_2

    L3_2 = L6_2

  else

    L6_2 = debugprint

    L7_2 = "PlayPhoneSound: invalid sound type"

    L8_2 = A0_2

    L6_2(L7_2, L8_2)

    return

  end

  L6_2 = L5_1

  L7_2 = PlayerPedId

  L7_2 = L7_2()

  L8_2 = A0_2

  L9_2 = L2_2

  L10_2 = L3_2

  L11_2 = L4_2

  L12_2 = L5_2

  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

  if not L6_2 then

    return

  end

  if "ringtone" == A0_2 or "alarm" == A0_2 then

    L1_1 = L6_2

    L7_2 = phoneOpen

    if not L7_2 then

      L7_2 = SetVariableOnSound

      L8_2 = L6_2

      L9_2 = "Muffle"

      L10_2 = 0.05

      L7_2(L8_2, L9_2, L10_2)

    end

  end

  L7_2 = Config

  L7_2 = L7_2.Sound

  L7_2 = L7_2.Sync

  if not L7_2 then

    return

  end

  L7_2 = GetNearbyPlayers

  L7_2 = L7_2()

  L8_2 = {}

  L9_2 = 1

  L10_2 = #L7_2

  L11_2 = 1

  for L12_2 = L9_2, L10_2, L11_2 do

    L13_2 = L7_2[L12_2]

    L13_2 = L13_2.source

    L8_2[L12_2] = L13_2

  end

  L9_2 = TriggerServerEvent

  L10_2 = "phone:sound:playSound"

  L11_2 = L8_2

  L12_2 = A0_2

  L13_2 = L3_2

  L14_2 = L4_2

  L15_2 = L5_2

  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)

end

PlayPhoneSound = L6_1

function L6_1()

  local L0_2, L1_2

  L0_2 = L1_1

  if not L0_2 then

    return

  end

  L0_2 = StopSound

  L1_2 = L1_1

  L0_2(L1_2)

  L0_2 = ReleaseSoundId

  L1_2 = L1_1

  L0_2(L1_2)

  L0_2 = nil

  L1_1 = L0_2

end

StopPhoneSound = L6_1

L6_1 = RegisterNetEvent

L7_1 = "phone:sound:playSound"

function L8_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)

  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2

  L6_2 = GetPlayerFromServerId

  L7_2 = A0_2

  L6_2 = L6_2(L7_2)

  L7_2 = GetPlayerPed

  L8_2 = L6_2

  L7_2 = L7_2(L8_2)

  L8_2 = PlayerPedId

  L8_2 = L8_2()

  if L7_2 == L8_2 then

    return

  end

  L8_2 = L5_1

  L9_2 = L7_2

  L10_2 = A1_2

  L11_2 = A2_2

  L12_2 = A3_2

  L13_2 = A4_2

  L14_2 = A5_2

  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)

end

L6_1(L7_1, L8_1)

function L6_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = L0_1

  L1_2 = L1_2[A0_2]

  if L1_2 then

    L2_2 = StopSound

    L3_2 = L1_2

    L2_2(L3_2)

    L2_2 = ReleaseSoundId

    L3_2 = L1_2

    L2_2(L3_2)

    L2_2 = L0_1

    L2_2[A0_2] = nil

  end

end

L7_1 = RegisterNetEvent

L8_1 = "onPlayerDropped"

function L9_1(A0_2)

  local L1_2, L2_2

  L1_2 = L6_1

  L2_2 = A0_2

  L1_2(L2_2)

end

L7_1(L8_1, L9_1)

L7_1 = AddStateBagChangeHandler

L8_1 = "lbPhoneAudio"

L9_1 = nil

function L10_1(A0_2, A1_2, A2_2, A3_2, A4_2)

  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L5_2 = GetPlayerDataFromStateBag

  L6_2 = A0_2

  L5_2, L6_2 = L5_2(L6_2)

  if L5_2 then

    L7_2 = GetPlayerServerId

    L8_2 = PlayerId

    L8_2, L9_2, L10_2, L11_2 = L8_2()

    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)

    if L5_2 ~= L7_2 then

      goto lbl_13

    end

  end

  do return end

  ::lbl_13::

  L7_2 = L6_1

  L8_2 = L5_2

  L7_2(L8_2)

  if not A2_2 or not L6_2 then

    return

  end

  L7_2 = L5_1

  L8_2 = L6_2

  L9_2 = table

  L9_2 = L9_2.unpack

  L10_2 = A2_2

  L9_2, L10_2, L11_2 = L9_2(L10_2)

  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)

  if not L7_2 then

    return

  end

  L8_2 = Player

  L9_2 = L5_2

  L8_2 = L8_2(L9_2)

  L8_2 = L8_2.state

  L8_2 = L8_2.phoneOpen

  if not L8_2 then

    L8_2 = SetVariableOnSound

    L9_2 = L7_2

    L10_2 = "Muffle"

    L11_2 = 0.05

    L8_2(L9_2, L10_2, L11_2)

  end

  L8_2 = L0_1

  L8_2[L5_2] = L7_2

end

L7_1(L8_1, L9_1, L10_1)

L7_1 = AddStateBagChangeHandler

L8_1 = "phoneOpen"

L9_1 = nil

function L10_1(A0_2, A1_2, A2_2, A3_2, A4_2)

  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L5_2 = tonumber

  L7_2 = A0_2

  L6_2 = A0_2.match

  L8_2 = "player:(%d+)"

  L6_2, L7_2, L8_2, L9_2, L10_2 = L6_2(L7_2, L8_2)

  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)

  if not L5_2 then

    return

  end

  L6_2 = GetPlayerServerId

  L7_2 = PlayerId

  L7_2, L8_2, L9_2, L10_2 = L7_2()

  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)

  if L5_2 == L6_2 then

    L6_2 = L1_1

    if L6_2 then

      goto lbl_20

    end

  end

  L6_2 = L0_1

  L6_2 = L6_2[L5_2]

  ::lbl_20::

  if not L6_2 then

    return

  end

  L7_2 = SetVariableOnSound

  L8_2 = L6_2

  L9_2 = "Muffle"

  if A2_2 then

    L10_2 = 1.0

    if L10_2 then

      goto lbl_32

    end

  end

  L10_2 = 0.05

  ::lbl_32::

  L7_2(L8_2, L9_2, L10_2)

end

L7_1(L8_1, L9_1, L10_1)

L7_1 = RegisterNetEvent

L8_1 = "phone:sound:stopSound"

function L9_1()

  local L0_2, L1_2

  L0_2 = StopPhoneSound

  L0_2()

end

L7_1(L8_1, L9_1)

L7_1 = RegisterNUICallback

L8_1 = "playSound"

function L9_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

  L2_2 = PlayPhoneSound

  L3_2 = A0_2.soundType

  L4_2 = A0_2.soundName

  L2_2(L3_2, L4_2)

end

L7_1(L8_1, L9_1)

L7_1 = RegisterNUICallback

L8_1 = "stopSound"

function L9_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

  L2_2 = TriggerServerEvent

  L3_2 = "phone:sound:stopSound"

  L2_2(L3_2)

end

L7_1(L8_1, L9_1)

L7_1 = nil

L8_1 = nil

L9_1 = RegisterNUICallback

L10_1 = "previewSound"

function L11_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

  L2_2 = L4_1

  L2_2 = L2_2()

  if not L2_2 then

    return

  end

  L2_2 = nil

  L3_2 = nil

  L4_2 = nil

  L5_2 = A0_2.soundType

  if "ringtone" == L5_2 then

    L5_2 = L2_1

    L6_2 = A0_2.sound

    L5_2, L6_2, L7_2 = L5_2(L6_2)

    L4_2 = L7_2

    L3_2 = L6_2

    L2_2 = L5_2

  else

    L5_2 = A0_2.soundType

    if "texttone" == L5_2 then

      L5_2 = L3_1

      L6_2 = A0_2.sound

      L5_2, L6_2, L7_2 = L5_2(L6_2)

      L4_2 = L7_2

      L3_2 = L6_2

      L2_2 = L5_2

    else

      return

    end

  end

  L5_2 = L7_1

  if L5_2 then

    L5_2 = StopSound

    L6_2 = L7_1

    L5_2(L6_2)

  else

    L5_2 = GetSoundId

    L5_2 = L5_2()

    L7_1 = L5_2

  end

  L5_2 = L2_2

  L6_2 = L3_2

  L5_2 = L5_2 .. L6_2

  L8_1 = L5_2

  L6_2 = PlaySoundFrontend

  L7_2 = L7_1

  L8_2 = L2_2

  L9_2 = L3_2

  L10_2 = false

  L6_2(L7_2, L8_2, L9_2, L10_2)

  L6_2 = settings

  if L6_2 then

    L6_2 = L6_2.sound

    if L6_2 then

      L6_2 = L6_2.volume

    end

  end

  if not L6_2 then

    L6_2 = 1

  end

  L7_2 = type

  L8_2 = Config

  L8_2 = L8_2.Sound

  L8_2 = L8_2.Volume

  L8_2 = L8_2.Static

  L7_2 = L7_2(L8_2)

  if "number" == L7_2 then

    L7_2 = Config

    L7_2 = L7_2.Sound

    L7_2 = L7_2.Volume

    L6_2 = L7_2.Static

  end

  L7_2 = Config

  L7_2 = L7_2.Sound

  L7_2 = L7_2.Volume

  L7_2 = L7_2.Multiplier

  if L7_2 then

    L7_2 = Config

    L7_2 = L7_2.Sound

    L7_2 = L7_2.Volume

    L7_2 = L7_2.Multiplier

    L6_2 = L6_2 * L7_2

  end

  L7_2 = math

  L7_2 = L7_2.clamp

  L8_2 = L6_2

  L9_2 = Config

  L9_2 = L9_2.Sound

  L9_2 = L9_2.Volume

  L9_2 = L9_2.Min

  if not L9_2 then

    L9_2 = 0.0

  end

  L10_2 = Config

  L10_2 = L10_2.Sound

  L10_2 = L10_2.Volume

  L10_2 = L10_2.Max

  if not L10_2 then

    L10_2 = 1.0

  end

  L7_2 = L7_2(L8_2, L9_2, L10_2)

  L6_2 = L7_2

  L7_2 = math

  L7_2 = L7_2.clamp

  L8_2 = L6_2

  L9_2 = 0.0

  L10_2 = 1.0

  L7_2 = L7_2(L8_2, L9_2, L10_2)

  L6_2 = L7_2

  L7_2 = L6_2 or L7_2

  if not L6_2 then

    L7_2 = 1

  end

  L6_2 = L7_2 / 1

  L7_2 = SetVariableOnSound

  L8_2 = L7_1

  L9_2 = "Volume"

  L10_2 = L6_2

  L7_2(L8_2, L9_2, L10_2)

  L7_2 = Wait

  L8_2 = 5000

  L7_2(L8_2)

  L7_2 = L8_1

  if L7_2 ~= L5_2 then

    return

  end

  L7_2 = L7_1

  if not L7_2 then

    return

  end

  L7_2 = StopSound

  L8_2 = L7_1

  L7_2(L8_2)

  L7_2 = ReleaseSoundId

  L8_2 = L7_1

  L7_2(L8_2)

  L7_2 = ReleaseScriptAudioBank

  L7_2()

  L7_2 = nil

  L7_1 = L7_2

  L7_2 = nil

  L8_1 = L7_2

end

L9_1(L10_1, L11_1)

L9_1 = RegisterNUICallback

L10_1 = "stopPreviewingSound"

function L11_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

  L2_2 = L7_1

  if L2_2 then

    L2_2 = StopSound

    L3_2 = L7_1

    L2_2(L3_2)

    L2_2 = ReleaseSoundId

    L3_2 = L7_1

    L2_2(L3_2)

    L2_2 = ReleaseScriptAudioBank

    L2_2()

    L2_2 = nil

    L7_1 = L2_2

    L2_2 = nil

    L8_1 = L2_2

  end

end

L9_1(L10_1, L11_1)

L9_1 = AddEventHandler

L10_1 = "onResourceStop"

function L11_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L1_2 = GetCurrentResourceName

  L1_2 = L1_2()

  if A0_2 ~= L1_2 then

    return

  end

  L1_2 = pairs

  L2_2 = L0_1

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = ReleaseSoundId

    L8_2 = L6_2

    L7_2(L8_2)

  end

  L1_2 = ReleaseScriptAudioBank

  L1_2()

end

L9_1(L10_1, L11_1)

L9_1 = CreateThread

function L10_1()

  local L0_2, L1_2

  L0_2 = Config

  L0_2 = L0_2.Sound

  L0_2 = L0_2.System

  if "nui" == L0_2 then

    return

  end

  while true do

    L0_2 = FrameworkLoaded

    if L0_2 then

      break

    end

    L0_2 = Wait

    L1_2 = 0

    L0_2(L1_2)

  end

  L0_2 = L4_1

  L0_2 = L0_2()

  if not L0_2 then

    L0_2 = Config

    L0_2 = L0_2.Sound

    L0_2.System = "nui"

  end

  L0_2 = ReleaseScriptAudioBank

  L0_2()

end

L9_1(L10_1)
