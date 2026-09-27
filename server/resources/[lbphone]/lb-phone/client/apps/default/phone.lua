local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1

InExportCall = false

L0_1 = false

L1_1 = false

L2_1 = nil

L3_1 = {}

L4_1 = nil

L5_1 = 0

L6_1 = false

L7_1 = {}

L8_1 = 0

function L9_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L0_2 = debugprint

  L1_2 = "EndCustomCall triggered"

  L0_2(L1_2)

  L0_2 = L4_1

  if L0_2 then

    L0_2 = math

    L0_2 = L0_2.floor

    L1_2 = GetGameTimer

    L1_2 = L1_2()

    L2_2 = L5_1

    L1_2 = L1_2 - L2_2

    L1_2 = L1_2 / 1000

    L1_2 = L1_2 + 0.5

    L0_2 = L0_2(L1_2)

    L1_2 = debugprint

    L2_2 = "Custom call to"

    L3_2 = L4_1.number

    L4_2 = "ended after"

    L5_2 = L0_2

    L6_2 = "seconds"

    L7_2 = "answered:"

    L8_2 = L6_1

    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)

    L1_2 = TriggerServerEvent

    L2_2 = "phone:logCall"

    L3_2 = L4_1.number

    L4_2 = L0_2

    L1_2(L2_2, L3_2, L4_2)

  end

  L0_2 = false

  L1_1 = L0_2

  L0_2 = nil

  L4_1 = L0_2

  L0_2 = nil

  L2_1 = L0_2

  L0_2 = 0

  L5_1 = L0_2

  L0_2 = false

  L6_1 = L0_2

  L0_2 = SetPhoneAction

  L1_2 = "default"

  L0_2(L1_2)

  L0_2 = SendReactMessage

  L1_2 = "call:endCall"

  L0_2(L1_2)

  L0_2 = phoneOpen

  if not L0_2 then

    L0_2 = PlayCloseAnim

    L0_2()

  end

end

function L10_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2

  L1_2 = L3_1

  L1_2 = L1_2[A0_2]

  if not L1_2 then

    L2_2 = pairs

    L3_2 = L7_1

    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)

    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do

      L8_2 = pcall

      function L9_2()

        local L0_3, L1_3

        L0_3 = L7_2.isValid

        L1_3 = A0_2

        return L0_3(L1_3)

      end

      L8_2, L9_2 = L8_2(L9_2)

      if L8_2 and L9_2 then

        L1_2 = L7_2.customNumber

        break

      elseif not L8_2 then

        L10_2 = Citizen

        L10_2 = L10_2.InvokeNative

        L11_2 = 3607903178

        L12_2 = nil

        L13_2 = 0

        L14_2 = Citizen

        L14_2 = L14_2.ResultAsString

        L14_2, L15_2, L16_2, L17_2 = L14_2()

        L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)

        L11_2 = print

        L12_2 = [[

^1SCRIPT ERROR: Dynamic number validator (id %i, by resource '%s') failed: %s^7

%s]]

        L13_2 = L12_2

        L12_2 = L12_2.format

        L14_2 = L6_2

        L15_2 = L7_2.resource

        L16_2 = L9_2 or L16_2

        if not L9_2 then

          L16_2 = ""

        end

        L17_2 = L10_2 or L17_2

        if not L10_2 then

          L17_2 = ""

        end

        L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2)

        L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)

      end

    end

  end

  if not L1_2 then

    L2_2 = false

    return L2_2

  end

  L2_2 = "CUSTOM_NUMBER_"

  L3_2 = math

  L3_2 = L3_2.random

  L4_2 = 9999999

  L3_2 = L3_2(L4_2)

  L2_2 = L2_2 .. L3_2

  L3_2 = true

  L1_1 = L3_2

  L2_1 = L2_2

  L4_1 = L1_2

  L3_2 = GetGameTimer

  L3_2 = L3_2()

  L5_1 = L3_2

  L3_2 = false

  L6_1 = L3_2

  L3_2 = Citizen

  L3_2 = L3_2.CreateThreadNow

  function L4_2()

    local L0_3, L1_3, L2_3

    L0_3 = L1_2.onCall

    L1_3 = {}

    L2_3 = L2_2

    L1_3.id = L2_3

    L2_3 = A0_2

    L1_3.number = L2_3

    function L2_3()

      local L0_4, L1_4

      L0_4 = L6_1

      if not L0_4 then

        L0_4 = L2_1

        L1_4 = L2_2

        if L0_4 == L1_4 then

          goto lbl_9

        end

      end

      do return end

      ::lbl_9::

      L0_4 = true

      L6_1 = L0_4

      L0_4 = SetPhoneAction

      L1_4 = "call"

      L0_4(L1_4)

      L0_4 = SendReactMessage

      L1_4 = "call:connected"

      L0_4(L1_4)

    end

    L1_3.accept = L2_3

    function L2_3()

      local L0_4, L1_4

      L0_4 = L2_1

      L1_4 = L2_2

      if L0_4 == L1_4 then

        L0_4 = L9_1

        L0_4()

      end

    end

    L1_3.deny = L2_3

    function L2_3(A0_4)

      local L1_4, L2_4, L3_4

      L1_4 = L2_1

      L2_4 = L2_2

      if L1_4 == L2_4 then

        L1_4 = SendReactMessage

        L2_4 = "call:setContactData"

        L3_4 = {}

        L3_4.name = A0_4

        L1_4(L2_4, L3_4)

      end

    end

    L1_3.setName = L2_3

    function L2_3()

      local L0_4, L1_4

      L0_4 = L2_1

      L1_4 = L2_2

      L0_4 = L0_4 ~= L1_4

      return L0_4

    end

    L1_3.hasEnded = L2_3

    L0_3(L1_3)

  end

  L3_2(L4_2)

  L3_2 = true

  return L3_2

end

function L11_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = L4_1

  if not L1_2 then

    return

  end

  if "end" == A0_2 then

    L1_2 = L4_1.onEnd

    if L1_2 then

      L1_2 = Citizen

      L1_2 = L1_2.CreateThreadNow

      L2_2 = L4_1.onEnd

      L1_2(L2_2)

    end

    L1_2 = L9_1

    L1_2()

    return

  end

  L2_2 = A0_2

  L1_2 = A0_2.find

  L3_2 = "keypad_"

  L1_2 = L1_2(L2_2, L3_2)

  if L1_2 then

    L1_2 = L4_1.onKeypad

    if not L1_2 then

      return

    end

    L2_2 = A0_2

    L1_2 = A0_2.sub

    L3_2 = 8

    L1_2 = L1_2(L2_2, L3_2)

    if not L1_2 then

      return

    end

    L2_2 = Citizen

    L2_2 = L2_2.CreateThreadNow

    function L3_2()

      local L0_3, L1_3

      L0_3 = L4_1.onKeypad

      L1_3 = L1_2

      L0_3(L1_3)

    end

    L2_2(L3_2)

    return

  end

  L1_2 = L4_1.onAction

  if L1_2 then

    L1_2 = L4_1.onAction

    L2_2 = A0_2

    L1_2(L2_2)

  end

end

L12_1 = RegisterNUICallback

L13_1 = "Phone"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Phone:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "getContacts" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "getContacts"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3

      L1_3 = Config

      L1_3 = L1_3.Companies

      L1_3 = L1_3.Enabled

      if L1_3 then

        L1_3 = pairs

        L2_3 = Config

        L2_3 = L2_3.Companies

        L2_3 = L2_3.Contacts

        L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3)

        for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do

          L7_3 = #A0_3

          L7_3 = L7_3 + 1

          L8_3 = {}

          L9_3 = L6_3.name

          L8_3.firstname = L9_3

          L9_3 = L6_3.photo

          L8_3.avatar = L9_3

          L8_3.company = L5_3

          A0_3[L7_3] = L8_3

        end

      end

      L1_3 = A1_2

      L2_3 = A0_3

      L1_3(L2_3)

    end

    L3_2(L4_2, L5_2)

  elseif "toggleFavourite" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "toggleFavourite"

    L5_2 = A1_2

    L6_2 = A0_2.number

    L7_2 = A0_2.favourite

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "toggleBlock" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "toggleBlock"

    L5_2 = A1_2

    L6_2 = A0_2.number

    L7_2 = A0_2.blocked

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "removeContact" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "removeContact"

    L5_2 = A1_2

    L6_2 = A0_2.number

    L3_2(L4_2, L5_2, L6_2)

  elseif "updateContact" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "updateContact"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "saveContact" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "saveContact"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "getRecent" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "getRecentCalls"

    L5_2 = A1_2

    L6_2 = A0_2.missed

    L6_2 = true == L6_2

    L7_2 = A0_2.lastId

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getBlockedNumbers" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "getBlockedNumbers"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3

      L1_3 = {}

      L2_3 = pairs

      L3_3 = A0_3

      L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)

      for L6_3, L7_3 in L2_3, L3_3, L4_3, L5_3 do

        L8_3 = L7_3.number

        L1_3[L6_3] = L8_3

      end

      L2_3 = A1_2

      L3_3 = L1_3

      L2_3(L3_3)

    end

    L3_2(L4_2, L5_2)

  elseif "toggleMute" == L2_2 then

    L3_2 = L2_1

    if not L3_2 then

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    else

      L3_2 = L4_1

      if L3_2 then

        L3_2 = L11_1

        L4_2 = A0_2.toggle

        if L4_2 then

          L4_2 = "mute"

          if L4_2 then

            goto lbl_103

          end

        end

        L4_2 = "unmute"

        ::lbl_103::

        L3_2(L4_2)

        L3_2 = A1_2

        L4_2 = A0_2.toggle

        return L3_2(L4_2)

      end

    end

    L3_2 = A0_2.toggle

    if L3_2 then

      L3_2 = RemoveFromCall

      L4_2 = L2_1

      L3_2(L4_2)

    else

      L3_2 = AddToCall

      L4_2 = L2_1

      L3_2(L4_2)

    end

    L3_2 = TriggerServerEvent

    L4_2 = "phone:phone:toggleMute"

    L5_2 = A0_2.toggle

    L3_2(L4_2, L5_2)

    L3_2 = A1_2

    L4_2 = A0_2.toggle

    L3_2(L4_2)

  elseif "toggleSpeaker" == L2_2 then

    L3_2 = L2_1

    if not L3_2 then

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    else

      L3_2 = L4_1

      if L3_2 then

        L3_2 = L11_1

        L4_2 = A0_2.toggle

        if L4_2 then

          L4_2 = "enable_speaker"

          if L4_2 then

            goto lbl_147

          end

        end

        L4_2 = "disable_speaker"

        ::lbl_147::

        L3_2(L4_2)

        L3_2 = A1_2

        L4_2 = A0_2.toggle

        return L3_2(L4_2)

      end

    end

    L3_2 = TriggerServerEvent

    L4_2 = "phone:phone:toggleSpeaker"

    L5_2 = A0_2.toggle

    L3_2(L4_2, L5_2)

    L3_2 = ToggleSpeaker

    L4_2 = A0_2.toggle

    L3_2(L4_2)

    L3_2 = A1_2

    L4_2 = A0_2.toggle

    L3_2(L4_2)

  elseif "sendVoicemail" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "sendVoicemail"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "getVoiceMails" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "getRecentVoicemails"

    L5_2 = A1_2

    L6_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2)

  elseif "deleteVoiceMail" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "deleteVoiceMail"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "keypad" == L2_2 then

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

    L3_2 = L4_1

    if L3_2 then

      L3_2 = L11_1

      L4_2 = "keypad_"

      L5_2 = A0_2.key

      L4_2 = L4_2 .. L5_2

      L3_2(L4_2)

    end

  end

  if "call" == L2_2 then

    L3_2 = A0_2.company

    if L3_2 then

      L3_2 = Config

      L3_2 = L3_2.Companies

      L3_2 = L3_2.Enabled

      if L3_2 then

        L3_2 = A0_2.videoCall

        if not L3_2 then

          goto lbl_217

        end

      end

      L3_2 = A1_2

      L4_2 = false

      do return L3_2(L4_2) end

      ::lbl_217::

      L3_2 = Config

      L3_2 = L3_2.Companies

      L3_2 = L3_2.Contacts

      L4_2 = A0_2.company

      L3_2 = L3_2[L4_2]

      if not L3_2 then

        L3_2 = false

        L4_2 = 1

        L5_2 = Config

        L5_2 = L5_2.Companies

        L5_2 = L5_2.Services

        L5_2 = #L5_2

        L6_2 = 1

        for L7_2 = L4_2, L5_2, L6_2 do

          L8_2 = Config

          L8_2 = L8_2.Companies

          L8_2 = L8_2.Services

          L8_2 = L8_2[L7_2]

          L8_2 = L8_2.job

          L9_2 = A0_2.company

          if L8_2 == L9_2 then

            L3_2 = true

            break

          end

        end

        if not L3_2 then

          L4_2 = A1_2

          L5_2 = false

          return L4_2(L5_2)

        end

      end

    end

    L3_2 = A0_2.videoCall

    L0_1 = L3_2

    L3_2 = AwaitCallback

    L4_2 = "call"

    L5_2 = A0_2

    L3_2 = L3_2(L4_2, L5_2)

    if "unknown_number" == L3_2 then

      L4_2 = L10_1

      L5_2 = A0_2.number

      L4_2 = L4_2(L5_2)

      if L4_2 then

        L4_2 = A1_2

        L5_2 = "CUSTOM_NUMBER"

        return L4_2(L5_2)

      end

      L4_2 = SendReactMessage

      L5_2 = "call:userUnavailable"

      L4_2(L5_2)

      L4_2 = A1_2

      L5_2 = false

      return L4_2(L5_2)

    end

    L4_2 = A1_2

    L5_2 = L3_2

    return L4_2(L5_2)

  elseif "answerCall" == L2_2 then

    L3_2 = IsInCall

    L3_2 = L3_2()

    if L3_2 then

      L3_2 = debugprint

      L4_2 = "answerCall: Already in call"

      L3_2(L4_2)

      return

    end

    L3_2 = IsLive

    L3_2 = L3_2()

    if L3_2 then

      L3_2 = debugprint

      L4_2 = "answerCall: Ending live"

      L3_2(L4_2)

      L3_2 = TriggerCallback

      L4_2 = "instagram:endLive"

      L3_2(L4_2)

    else

      L3_2 = IsWatchingLive

      L3_2 = L3_2()

      if L3_2 then

        L3_2 = debugprint

        L4_2 = "answerCall: Leaving live"

        L3_2(L4_2)

        L3_2 = SendReactMessage

        L4_2 = "instagram:liveEnded"

        L5_2 = IsWatchingLive

        L5_2, L6_2, L7_2, L8_2, L9_2 = L5_2()

        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)

      end

    end

    L3_2 = debugprint

    L4_2 = "Answering call"

    L5_2 = A0_2.callId

    L3_2(L4_2, L5_2)

    L3_2 = TriggerServerEvent

    L4_2 = "phone:sound:stopSound"

    L3_2(L4_2)

    L3_2 = TriggerCallback

    L4_2 = "answerCall"

    L5_2 = A1_2

    L6_2 = A0_2.callId

    L3_2(L4_2, L5_2, L6_2)

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

  elseif "endCall" == L2_2 then

    L3_2 = EndCall

    L3_2()

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

  elseif "flipCamera" == L2_2 then

    L3_2 = ToggleSelfieCam

    L4_2 = IsSelfieCam

    L4_2 = L4_2()

    L4_2 = not L4_2

    L3_2(L4_2)

  elseif "requestVideoCall" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "requestVideoCall"

    L5_2 = A1_2

    L6_2 = A0_2.callId

    L7_2 = A0_2.peerId

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "answerVideoRequest" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "answerVideoRequest"

    L5_2 = A1_2

    L6_2 = A0_2.callId

    L7_2 = A0_2.accept

    L3_2(L4_2, L5_2, L6_2, L7_2)

    L3_2 = A0_2.accept

    if L3_2 then

      L3_2 = true

      L0_1 = L3_2

      L3_2 = EnableWalkableCam

      L3_2()

    end

  elseif "stopVideoCall" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "stopVideoCall"

    L5_2 = A1_2

    L6_2 = A0_2.callId

    L3_2(L4_2, L5_2, L6_2)

  elseif "stopRingtone" == L2_2 then

    L3_2 = StopPhoneSound

    L3_2()

  end

end

L12_1(L13_1, L14_1)

function L12_1()

  local L0_2, L1_2

  L0_2 = TriggerServerEvent

  L1_2 = "phone:sound:stopSound"

  L0_2(L1_2)

  L0_2 = TriggerServerEvent

  L1_2 = "phone:endCall"

  L0_2(L1_2)

  L0_2 = L4_1

  if L0_2 then

    L0_2 = L11_1

    L1_2 = "end"

    L0_2(L1_2)

  end

end

EndCall = L12_1

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:setCall"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2

  L1_2 = HasPhoneItem

  L2_2 = currentPhone

  L1_2 = L1_2(L2_2)

  if not L1_2 then

    L1_2 = debugprint

    L2_2 = "no phone, not showing call"

    L1_2(L2_2)

    return

  end

  L1_2 = phoneDisabled

  if L1_2 then

    L1_2 = debugprint

    L2_2 = "phone is disabled, not showing call"

    L1_2(L2_2)

    return

  end

  L1_2 = IsPhoneDead

  L1_2 = L1_2()

  if L1_2 then

    L1_2 = debugprint

    L2_2 = "phone is dead, not showing call"

    L1_2(L2_2)

    return

  end

  L1_2 = L4_1

  if not L1_2 then

    L1_2 = L1_1

    if not L1_2 then

      goto lbl_41

    end

  end

  L1_2 = debugprint

  L2_2 = "in a (custom?) call"

  L3_2 = tostring

  L4_2 = L4_1

  L3_2 = L3_2(L4_2)

  L4_2 = tostring

  L5_2 = L1_1

  L4_2, L5_2 = L4_2(L5_2)

  L1_2(L2_2, L3_2, L4_2, L5_2)

  do return end

  ::lbl_41::

  L1_2 = IsPedDeadOrDying

  L2_2 = PlayerPedId

  L2_2 = L2_2()

  L3_2 = false

  L1_2 = L1_2(L2_2, L3_2)

  if L1_2 then

    L1_2 = debugprint

    L2_2 = "player is dead, not showing call"

    L1_2(L2_2)

    return

  else

    L1_2 = CanOpenPhone

    if L1_2 then

      L1_2 = CanOpenPhone

      L1_2 = L1_2()

      if not L1_2 then

        L1_2 = debugprint

        L2_2 = "can't open phone, not showing call"

        L1_2(L2_2)

        return

      end

    end

  end

  L1_2 = A0_2.videoCall

  L0_1 = L1_2

  L1_2 = A0_2.hideCallerId

  if not L1_2 then

    L1_2 = settings

    if L1_2 then

      L1_2 = L1_2.sound

      if L1_2 then

        L1_2 = L1_2.ringtones

      end

    end

    if L1_2 then

      L1_2 = A0_2.number

      if L1_2 then

        L1_2 = settings

        L1_2 = L1_2.sound

        L1_2 = L1_2.ringtones

        L2_2 = A0_2.number

        L1_2 = L1_2[L2_2]

        if L1_2 then

          goto lbl_89

        end

      end

    end

  end

  L1_2 = nil

  ::lbl_89::

  L2_2 = PlayPhoneSound

  L3_2 = "ringtone"

  L4_2 = L1_2

  L2_2(L3_2, L4_2)

  L2_2 = SendReactMessage

  L3_2 = "incomingCall"

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:enableExportCall"

function L14_1()

  local L0_2, L1_2

  InExportCall = true

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:connectCall"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = debugprint

  L3_2 = "phone:phone:connectCall"

  L4_2 = A0_2

  L5_2 = A1_2

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = true

  L1_1 = L2_2

  L2_1 = A0_2

  L2_2 = AddToCall

  L3_2 = A0_2

  L2_2(L3_2)

  if A1_2 then

    return

  end

  L2_2 = StopPhoneSound

  L2_2()

  L2_2 = SetPhoneAction

  L3_2 = "call"

  L2_2(L3_2)

  L2_2 = SendReactMessage

  L3_2 = "call:connected"

  L2_2(L3_2)

  L2_2 = L0_1

  if L2_2 then

    L2_2 = EnableWalkableCam

    L2_2()

  end

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:endCall"

function L14_1()

  local L0_2, L1_2, L2_2

  L0_2 = debugprint

  L1_2 = "phone:phone:endCall"

  L0_2(L1_2)

  L0_2 = L1_1

  L1_2 = false

  L1_1 = L1_2

  L1_2 = false

  L0_1 = L1_2

  L1_2 = SetPhoneAction

  L2_2 = "default"

  L1_2(L2_2)

  L1_2 = DisableWalkableCam

  L1_2()

  L1_2 = phoneOpen

  if not L1_2 and L0_2 then

    L1_2 = debugprint

    L2_2 = "close anim"

    L1_2(L2_2)

    L1_2 = PlayCloseAnim

    L1_2()

  end

  L1_2 = StopPhoneSound

  L1_2()

  L1_2 = RemoveFromCall

  L2_2 = L2_1

  L1_2(L2_2)

  L1_2 = nil

  L2_1 = L1_2

  InExportCall = false

  L1_2 = TriggerServerEvent

  L2_2 = "phone:sound:stopSound"

  L1_2(L2_2)

  L1_2 = SendReactMessage

  L2_2 = "call:endCall"

  L1_2(L2_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:userUnavailable"

function L14_1()

  local L0_2, L1_2

  L0_2 = debugprint

  L1_2 = "phone:phone:userUnavailable"

  L0_2(L1_2)

  L0_2 = SendReactMessage

  L1_2 = "call:userUnavailable"

  L0_2(L1_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:userBusy"

function L14_1()

  local L0_2, L1_2

  L0_2 = debugprint

  L1_2 = "phone:phone:userBusy"

  L0_2(L1_2)

  L0_2 = SendReactMessage

  L1_2 = "call:userBusy"

  L0_2(L1_2)

end

L12_1(L13_1, L14_1)

function L12_1()

  local L0_2, L1_2

  L0_2 = L1_1

  return L0_2

end

IsInCall = L12_1

L12_1 = exports

L13_1 = "IsInCall"

L14_1 = IsInCall

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "AddContact"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  L2_2 = "table" == L2_2

  L3_2 = "contact must be a table"

  L1_2(L2_2, L3_2)

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2.number

  L2_2 = L2_2(L3_2)

  L2_2 = "string" == L2_2

  L3_2 = "contact.number must be a string"

  L1_2(L2_2, L3_2)

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2.firstname

  L2_2 = L2_2(L3_2)

  L2_2 = "string" == L2_2

  L3_2 = "contact.firstname must be a string"

  L1_2(L2_2, L3_2)

  L1_2 = AwaitCallback

  L2_2 = "saveContact"

  L3_2 = A0_2

  L1_2 = L1_2(L2_2, L3_2)

  if L1_2 then

    L2_2 = SendReactMessage

    L3_2 = "phone:contactAdded"

    L4_2 = A0_2

    L2_2(L3_2, L4_2)

  end

  return L1_2

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:videoRequested"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = debugprint

  L2_2 = "phone:phone:videoRequested"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "call:videoRequested"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:videoRequestAnswered"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = debugprint

  L2_2 = "phone:phone:videoRequestAnswered"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "call:videoRequestAnswered"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  if A0_2 then

    L1_2 = true

    L0_1 = L1_2

    L1_2 = EnableWalkableCam

    L1_2()

  end

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:stopVideoCall"

function L14_1()

  local L0_2, L1_2

  L0_2 = debugprint

  L1_2 = "phone:phone:stopVideoCall"

  L0_2(L1_2)

  L0_2 = SendReactMessage

  L1_2 = "call:stopVideoCall"

  L0_2(L1_2)

  L0_2 = false

  L0_1 = L0_2

  L0_2 = DisableWalkableCam

  L0_2()

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:phone:contactAdded"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = debugprint

  L2_2 = "phone:phone:contactAdded"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "phone:contactAdded"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L12_1(L13_1, L14_1)

function L12_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  L2_2 = "table" == L2_2

  L3_2 = "options must be a table"

  L1_2(L2_2, L3_2)

  L1_2 = assert

  L2_2 = A0_2.number

  if not L2_2 then

    L2_2 = A0_2.company

  end

  L3_2 = "options must contain either a number or company"

  L1_2(L2_2, L3_2)

  L1_2 = currentPhone

  if not L1_2 then

    L1_2 = debugprint

    L2_2 = "no phone"

    return L1_2(L2_2)

  end

  L1_2 = A0_2.hideNumber

  if nil == L1_2 then

    L1_2 = settings

    if L1_2 then

      L1_2 = L1_2.phone

      if L1_2 then

        L1_2 = L1_2.showCallerId

      end

    end

    if false == L1_2 then

      A0_2.hideNumber = true

    end

  end

  L1_2 = A0_2.company

  if L1_2 then

    L1_2 = Config

    L1_2 = L1_2.Companies

    L1_2 = L1_2.Enabled

    if not L1_2 then

      L1_2 = debugprint

      L2_2 = "company calls are disabled in config"

      return L1_2(L2_2)

    end

    L1_2 = false

    L2_2 = A0_2.company

    L3_2 = Config

    L3_2 = L3_2.Companies

    L3_2 = L3_2.Contacts

    L4_2 = A0_2.company

    L3_2 = L3_2[L4_2]

    if L3_2 then

      L3_2 = Config

      L3_2 = L3_2.Companies

      L3_2 = L3_2.Contacts

      L4_2 = A0_2.company

      L3_2 = L3_2[L4_2]

      L2_2 = L3_2.name

      L1_2 = true

    else

      L3_2 = 1

      L4_2 = Config

      L4_2 = L4_2.Companies

      L4_2 = L4_2.Services

      L4_2 = #L4_2

      L5_2 = 1

      for L6_2 = L3_2, L4_2, L5_2 do

        L7_2 = Config

        L7_2 = L7_2.Companies

        L7_2 = L7_2.Services

        L7_2 = L7_2[L6_2]

        L8_2 = L7_2.job

        L9_2 = A0_2.company

        if L8_2 == L9_2 then

          L1_2 = true

          L2_2 = L7_2.name

          break

        end

      end

    end

    if not L1_2 then

      L3_2 = debugprint

      L4_2 = "invalid company"

      return L3_2(L4_2)

    end

    L3_2 = debugprint

    L4_2 = "CreateCall: company"

    L5_2 = A0_2

    L3_2(L4_2, L5_2)

    L3_2 = SendReactMessage

    L4_2 = "call"

    L5_2 = {}

    L6_2 = A0_2.company

    L5_2.company = L6_2

    L5_2.companylabel = L2_2

    L6_2 = A0_2.hideNumber

    L6_2 = true == L6_2

    L5_2.hideCallerId = L6_2

    L3_2(L4_2, L5_2)

  else

    L1_2 = debugprint

    L2_2 = "CreateCall: number"

    L3_2 = A0_2

    L1_2(L2_2, L3_2)

    L1_2 = SendReactMessage

    L2_2 = "call"

    L3_2 = {}

    L4_2 = A0_2.number

    L3_2.number = L4_2

    L4_2 = A0_2.videoCall

    L4_2 = true == L4_2

    L3_2.videoCall = L4_2

    L4_2 = A0_2.hideNumber

    L4_2 = true == L4_2

    L3_2.hideCallerId = L4_2

    L1_2(L2_2, L3_2)

  end

end

CreateCall = L12_1

L12_1 = exports

L13_1 = "CreateCall"

L14_1 = CreateCall

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "CreateCustomNumber"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = GetInvokingResource

  L2_2 = L2_2()

  L3_2 = assert

  L4_2 = type

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L4_2 = "string" == L4_2

  L5_2 = "number must be a string"

  L3_2(L4_2, L5_2)

  L3_2 = assert

  L4_2 = type

  L5_2 = A1_2

  L4_2 = L4_2(L5_2)

  L4_2 = "table" == L4_2

  L5_2 = "data must be a table"

  L3_2(L4_2, L5_2)

  L3_2 = assert

  L4_2 = type

  L5_2 = A1_2.onCall

  L4_2 = L4_2(L5_2)

  L4_2 = "function" == L4_2

  L5_2 = "data.onCall must be a function"

  L3_2(L4_2, L5_2)

  L3_2 = L3_1

  L3_2 = L3_2[A0_2]

  if L3_2 then

    L3_2 = false

    L4_2 = "Number already exists"

    return L3_2, L4_2

  end

  L3_2 = L3_1

  L4_2 = {}

  L4_2.resource = L2_2

  L4_2.number = A0_2

  L5_2 = A1_2.onCall

  L4_2.onCall = L5_2

  L5_2 = A1_2.onEnd

  L4_2.onEnd = L5_2

  L5_2 = A1_2.onAction

  L4_2.onAction = L5_2

  L5_2 = A1_2.onKeypad

  L4_2.onKeypad = L5_2

  L3_2[A0_2] = L4_2

  L3_2 = true

  return L3_2

end

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "RemoveCustomNumber"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = GetInvokingResource

  L1_2 = L1_2()

  L2_2 = assert

  L3_2 = type

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  L3_2 = "string" == L3_2

  L4_2 = "number must be a string"

  L2_2(L3_2, L4_2)

  L2_2 = L3_1

  L2_2 = L2_2[A0_2]

  if not L2_2 then

    L2_2 = false

    L3_2 = "Number does not exist"

    return L2_2, L3_2

  end

  L2_2 = L3_1

  L2_2 = L2_2[A0_2]

  if L2_2 then

    L2_2 = L2_2.resource

  end

  if L2_2 ~= L1_2 then

    L2_2 = false

    L3_2 = "Number was not created by "

    L4_2 = L1_2

    L3_2 = L3_2 .. L4_2

    return L2_2, L3_2

  end

  L2_2 = L3_1

  L2_2[A0_2] = nil

  L2_2 = true

  return L2_2

end

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "EndCustomCall"

function L14_1()

  local L0_2, L1_2

  L0_2 = L4_1

  if L0_2 then

    L0_2 = L9_1

    L0_2()

    L0_2 = true

    return L0_2

  end

  L0_2 = false

  return L0_2

end

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "CreateDynamicCustomNumber"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = GetInvokingResource

  L2_2 = L2_2()

  L3_2 = assert

  L4_2 = type

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L4_2 = "function" == L4_2

  L5_2 = "validator must be a function"

  L3_2(L4_2, L5_2)

  L3_2 = assert

  L4_2 = type

  L5_2 = A1_2

  L4_2 = L4_2(L5_2)

  L4_2 = "table" == L4_2

  L5_2 = "data must be a table"

  L3_2(L4_2, L5_2)

  L3_2 = assert

  L4_2 = type

  L5_2 = A1_2.onCall

  L4_2 = L4_2(L5_2)

  L4_2 = "function" == L4_2

  L5_2 = "data.onCall must be a function"

  L3_2(L4_2, L5_2)

  L3_2 = L8_1

  L3_2 = L3_2 + 1

  L8_1 = L3_2

  L4_2 = L8_1

  L3_2 = L7_1

  L5_2 = {}

  L5_2.isValid = A0_2

  L5_2.customNumber = A1_2

  L5_2.resource = L2_2

  L3_2[L4_2] = L5_2

  L3_2 = L8_1

  return L3_2

end

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "RemoveDynamicCustomNumber"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2

  L1_2 = GetInvokingResource

  L1_2 = L1_2()

  L2_2 = assert

  L3_2 = type

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  L3_2 = "number" == L3_2

  L4_2 = "id must be a number"

  L2_2(L3_2, L4_2)

  L2_2 = L7_1

  L2_2 = L2_2[A0_2]

  if not L2_2 then

    L3_2 = false

    L4_2 = "Dynamic number does not exist"

    return L3_2, L4_2

  end

  L3_2 = L2_2.resource

  if L3_2 ~= L1_2 then

    L3_2 = false

    L4_2 = "Dynamic number was not created by "

    L5_2 = L1_2

    L4_2 = L4_2 .. L5_2

    return L3_2, L4_2

  end

  L3_2 = L7_1

  L3_2[A0_2] = nil

  L3_2 = true

  return L3_2

end

L12_1(L13_1, L14_1)

L12_1 = AddEventHandler

L13_1 = "onResourceStop"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L1_2 = GetCurrentResourceName

  L1_2 = L1_2()

  if A0_2 == L1_2 then

    return

  end

  L1_2 = pairs

  L2_2 = L3_1

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = L6_2.resource

    if L7_2 == A0_2 then

      L7_2 = debugprint

      L8_2 = "Removed custom number"

      L9_2 = L5_2

      L10_2 = "due to resource stopping"

      L7_2(L8_2, L9_2, L10_2)

      L7_2 = L4_1

      if L7_2 == L6_2 then

        L7_2 = L11_1

        L8_2 = "end"

        L7_2(L8_2)

      end

      L7_2 = L3_1

      L7_2[L5_2] = nil

    end

  end

  L1_2 = pairs

  L2_2 = L7_1

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = L6_2.resource

    if L7_2 == A0_2 then

      L7_2 = debugprint

      L8_2 = "Removed dynamic custom number id"

      L9_2 = L5_2

      L10_2 = "due to resource stopping"

      L7_2(L8_2, L9_2, L10_2)

      L7_2 = L7_1

      L7_2[L5_2] = nil

    end

  end

end

L12_1(L13_1, L14_1)