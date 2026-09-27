local L0_1, L1_1, L2_1, L3_1, L4_1

function L0_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L3_2 = debugprint

  L4_2 = DebugPlayerName

  L5_2 = A1_2

  L4_2 = L4_2(L5_2)

  L5_2 = " is now speaking to "

  L6_2 = DebugPlayerName

  L7_2 = A0_2

  L6_2 = L6_2(L7_2)

  if A2_2 then

    L7_2 = " (playing from %s)"

    L8_2 = L7_2

    L7_2 = L7_2.format

    L9_2 = DebugPlayerName

    L10_2 = A2_2

    L9_2, L10_2 = L9_2(L10_2)

    L7_2 = L7_2(L8_2, L9_2, L10_2)

    if L7_2 then

      goto lbl_20

    end

  end

  L7_2 = ""

  ::lbl_20::

  L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2

  L3_2(L4_2)

  L3_2 = TriggerClientEvent

  L4_2 = "phone:phone:addVoiceTarget"

  L5_2 = A1_2

  L6_2 = {}

  L6_2.sources = A0_2

  L3_2(L4_2, L5_2, L6_2)

  L3_2 = TriggerClientEvent

  L4_2 = "phone:phone:addVoiceTarget"

  L5_2 = A0_2

  L6_2 = {}

  L6_2.sources = A1_2

  L6_2.audio = true

  L6_2.phoneCall = true

  L6_2.playFromSource = A2_2

  L3_2(L4_2, L5_2, L6_2)

end

function L1_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = debugprint

  L3_2 = DebugPlayerName

  L4_2 = A1_2

  L3_2 = L3_2(L4_2)

  L4_2 = " stopped speaking to "

  L5_2 = DebugPlayerName

  L6_2 = A0_2

  L5_2 = L5_2(L6_2)

  L3_2 = L3_2 .. L4_2 .. L5_2

  L2_2(L3_2)

  L2_2 = TriggerClientEvent

  L3_2 = "phone:phone:removeVoiceTarget"

  L4_2 = A1_2

  L5_2 = A0_2

  L6_2 = true

  L2_2(L3_2, L4_2, L5_2, L6_2)

  L2_2 = TriggerClientEvent

  L3_2 = "phone:phone:removeVoiceTarget"

  L4_2 = A0_2

  L5_2 = A1_2

  L6_2 = true

  L2_2(L3_2, L4_2, L5_2, L6_2)

end

L2_1 = RegisterNetEvent

L3_1 = "phone:phone:toggleMute"

function L4_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2

  L1_2 = source

  L2_2 = IsInCall

  L3_2 = L1_2

  L2_2, L3_2, L4_2 = L2_2(L3_2)

  if not L4_2 then

    return

  end

  L5_2 = L4_2.caller

  L5_2 = L5_2.source

  if L5_2 == L1_2 then

    L5_2 = L4_2.callee

    L5_2 = L5_2.source

    if L5_2 then

      goto lbl_18

    end

  end

  L5_2 = L4_2.caller

  L5_2 = L5_2.source

  ::lbl_18::

  if not L5_2 then

    return

  end

  L6_2 = L4_2.caller

  L6_2 = L6_2.source

  L6_2 = L6_2 == L1_2

  if L6_2 then

    L7_2 = L4_2.caller

    L7_2 = L7_2.nearby

    if L7_2 then

      goto lbl_35

    end

  end

  L7_2 = L4_2.callee

  L7_2 = L7_2.nearby

  ::lbl_35::

  if L6_2 then

    L8_2 = L4_2.callee

    L8_2 = L8_2.nearby

    if L8_2 then

      goto lbl_43

    end

  end

  L8_2 = L4_2.caller

  L8_2 = L8_2.nearby

  ::lbl_43::

  L9_2 = Player

  L10_2 = L1_2

  L9_2 = L9_2(L10_2)

  L9_2 = L9_2.state

  A0_2 = true == A0_2

  L9_2.mutedCall = A0_2

  L10_2 = L4_2.answered

  if not L10_2 then

    return

  end

  L10_2 = table

  L10_2 = L10_2.clone

  L11_2 = L7_2

  L10_2 = L10_2(L11_2)

  L11_2 = #L10_2

  L11_2 = L11_2 + 1

  L10_2[L11_2] = L1_2

  L11_2 = table

  L11_2 = L11_2.clone

  L12_2 = L8_2

  L11_2 = L11_2(L12_2)

  L12_2 = #L11_2

  L12_2 = L12_2 + 1

  L11_2[L12_2] = L5_2

  L12_2 = 1

  L13_2 = #L11_2

  L14_2 = 1

  for L15_2 = L12_2, L13_2, L14_2 do

    L16_2 = debugprint

    L17_2 = DebugPlayerName

    L18_2 = L11_2[L15_2]

    L17_2 = L17_2(L18_2)

    L18_2 = "set "

    if A0_2 then

      L19_2 = "not "

      if L19_2 then

        goto lbl_87

      end

    end

    L19_2 = ""

    ::lbl_87::

    L20_2 = "audible for"

    L18_2 = L18_2 .. L19_2 .. L20_2

    L19_2 = L10_2

    L16_2(L17_2, L18_2, L19_2)

    L16_2 = TriggerClientEvent

    L17_2 = "phone:phone:setTargetsAudible"

    L18_2 = L11_2[L15_2]

    L19_2 = L10_2

    L20_2 = not A0_2

    L16_2(L17_2, L18_2, L19_2, L20_2)

  end

end

L2_1(L3_1, L4_1)

L2_1 = RegisterNetEvent

L3_1 = "phone:phone:toggleSpeaker"

function L4_1(A0_2)

  local L1_2, L2_2

  L1_2 = Player

  L2_2 = source

  L1_2 = L1_2(L2_2)

  L1_2 = L1_2.state

  L2_2 = true == A0_2

  L1_2.speakerphone = L2_2

end

L2_1(L3_1, L4_1)

L2_1 = RegisterNetEvent

L3_1 = "phone:phone:enteredCallProximity"

function L4_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2

  L1_2 = source

  L2_2 = IsInCall

  L3_2 = A0_2

  L2_2, L3_2, L4_2 = L2_2(L3_2)

  L5_2 = debugprint

  L6_2 = "phone:phone:enteredCallProximity:"

  L7_2 = DebugPlayerName

  L8_2 = L1_2

  L7_2 = L7_2(L8_2)

  L8_2 = "entered the proximity of"

  L9_2 = DebugPlayerName

  L10_2 = A0_2

  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L9_2(L10_2)

  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)

  if not L4_2 then

    L5_2 = debugprint

    L6_2 = DebugPlayerName

    L7_2 = A0_2

    L6_2 = L6_2(L7_2)

    L7_2 = "is not in a call"

    L5_2(L6_2, L7_2)

    return

  end

  L5_2 = L4_2.answered

  if not L5_2 then

    L5_2 = debugprint

    L6_2 = "call not answered yet"

    L5_2(L6_2)

    return

  end

  L5_2 = L4_2.caller

  L5_2 = L5_2.source

  L5_2 = L5_2 == A0_2

  if L5_2 then

    L6_2 = L4_2.caller

    L6_2 = L6_2.nearby

    if L6_2 then

      goto lbl_45

    end

  end

  L6_2 = L4_2.callee

  L6_2 = L6_2.nearby

  ::lbl_45::

  if L5_2 then

    L7_2 = L4_2.callee

    L7_2 = L7_2.nearby

    if L7_2 then

      goto lbl_53

    end

  end

  L7_2 = L4_2.caller

  L7_2 = L7_2.nearby

  ::lbl_53::

  if L5_2 then

    L8_2 = L4_2.callee

    L8_2 = L8_2.source

    if L8_2 then

      goto lbl_61

    end

  end

  L8_2 = L4_2.caller

  L8_2 = L8_2.source

  ::lbl_61::

  L9_2 = Player

  L10_2 = A0_2

  L9_2 = L9_2(L10_2)

  L9_2 = L9_2.state

  L10_2 = L9_2.speakerphone

  if not L10_2 then

    L10_2 = debugprint

    L11_2 = DebugPlayerName

    L12_2 = A0_2

    L11_2 = L11_2(L12_2)

    L12_2 = "does not have speakerphone on"

    L10_2(L11_2, L12_2)

    return

  end

  if not L8_2 then

    L10_2 = debugprint

    L11_2 = "other call participant not found"

    L10_2(L11_2)

    return

  end

  L10_2 = Player

  L11_2 = L8_2

  L10_2 = L10_2(L11_2)

  L10_2 = L10_2.state

  L11_2 = L9_2.mutedCall

  if not L11_2 then

    L11_2 = L0_1

    L12_2 = L8_2

    L13_2 = L1_2

    L14_2 = L8_2

    L11_2(L12_2, L13_2, L14_2)

  end

  L11_2 = L10_2.mutedCall

  if not L11_2 then

    L11_2 = L0_1

    L12_2 = L1_2

    L13_2 = L8_2

    L14_2 = A0_2

    L11_2(L12_2, L13_2, L14_2)

  end

  L11_2 = 1

  L12_2 = #L7_2

  L13_2 = 1

  for L14_2 = L11_2, L12_2, L13_2 do

    L15_2 = L7_2[L14_2]

    L16_2 = L10_2.speakerphone

    if L16_2 then

      L16_2 = L9_2.mutedCall

      if not L16_2 then

        L16_2 = L0_1

        L17_2 = L15_2

        L18_2 = L1_2

        L19_2 = L8_2

        L16_2(L17_2, L18_2, L19_2)

      end

    end

    L16_2 = L10_2.speakerphone

    if L16_2 then

      L16_2 = L10_2.mutedCall

      if not L16_2 then

        L16_2 = L0_1

        L17_2 = L1_2

        L18_2 = L15_2

        L19_2 = A0_2

        L16_2(L17_2, L18_2, L19_2)

      end

    end

  end

  L11_2 = table

  L11_2 = L11_2.contains

  L12_2 = L6_2

  L13_2 = L1_2

  L11_2 = L11_2(L12_2, L13_2)

  if L11_2 then

    return

  end

  L11_2 = #L6_2

  L11_2 = L11_2 + 1

  L6_2[L11_2] = L1_2

end

L2_1(L3_1, L4_1)

L2_1 = RegisterNetEvent

L3_1 = "phone:phone:leftCallProximity"

function L4_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2

  L1_2 = source

  L2_2 = IsInCall

  L3_2 = A0_2

  L2_2, L3_2, L4_2 = L2_2(L3_2)

  if not L4_2 then

    return

  end

  L5_2 = L4_2.answered

  if not L5_2 then

    return

  end

  L5_2 = L4_2.caller

  L5_2 = L5_2.source

  L5_2 = L5_2 == A0_2

  if L5_2 then

    L6_2 = L4_2.caller

    L6_2 = L6_2.nearby

    if L6_2 then

      goto lbl_26

    end

  end

  L6_2 = L4_2.callee

  L6_2 = L6_2.nearby

  ::lbl_26::

  L7_2 = table

  L7_2 = L7_2.contains

  L8_2 = L6_2

  L9_2 = L1_2

  L7_2, L8_2 = L7_2(L8_2, L9_2)

  if not L7_2 then

    return

  end

  if L5_2 then

    L9_2 = L4_2.callee

    L9_2 = L9_2.source

    if L9_2 then

      goto lbl_42

    end

  end

  L9_2 = L4_2.caller

  L9_2 = L9_2.source

  ::lbl_42::

  if not L9_2 then

    return

  end

  L10_2 = debugprint

  L11_2 = "phone:phone:leftCallProximity"

  L12_2 = DebugPlayerName

  L13_2 = L1_2

  L12_2 = L12_2(L13_2)

  L13_2 = DebugPlayerName

  L14_2 = A0_2

  L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L13_2(L14_2)

  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)

  L10_2 = L1_1

  L11_2 = L9_2

  L12_2 = L1_2

  L10_2(L11_2, L12_2)

  L10_2 = table

  L10_2 = L10_2.remove

  L11_2 = L6_2

  L12_2 = L8_2

  L10_2(L11_2, L12_2)

  if L5_2 then

    L10_2 = L4_2.callee

    L10_2 = L10_2.nearby

    if L10_2 then

      goto lbl_71

    end

  end

  L10_2 = L4_2.caller

  L10_2 = L10_2.nearby

  ::lbl_71::

  L11_2 = 1

  L12_2 = #L10_2

  L13_2 = 1

  for L14_2 = L11_2, L12_2, L13_2 do

    L15_2 = L10_2[L14_2]

    L16_2 = L1_1

    L17_2 = L15_2

    L18_2 = L1_2

    L16_2(L17_2, L18_2)

  end

end

L2_1(L3_1, L4_1)

L2_1 = AddEventHandler

L3_1 = "lb-phone:callEnded"

function L4_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2

  L1_2 = A0_2.caller

  L1_2 = L1_2.source

  L2_2 = A0_2.callee

  L2_2 = L2_2.source

  L3_2 = A0_2.caller

  L3_2 = L3_2.nearby

  if L3_2 then

    L3_2 = table

    L3_2 = L3_2.clone

    L4_2 = A0_2.caller

    L4_2 = L4_2.nearby

    L3_2 = L3_2(L4_2)

  end

  L4_2 = A0_2.callee

  L4_2 = L4_2.nearby

  if L4_2 then

    L4_2 = table

    L4_2 = L4_2.clone

    L5_2 = A0_2.callee

    L5_2 = L5_2.nearby

    L4_2 = L4_2(L5_2)

  end

  if L3_2 and L2_2 then

    L5_2 = #L3_2

    if L5_2 > 0 then

      L5_2 = TriggerClientEvent

      L6_2 = "phone:phone:removeVoiceTarget"

      L7_2 = L2_2

      L8_2 = L3_2

      L9_2 = true

      L5_2(L6_2, L7_2, L8_2, L9_2)

      L5_2 = 1

      L6_2 = #L3_2

      L7_2 = 1

      for L8_2 = L5_2, L6_2, L7_2 do

        L9_2 = TriggerClientEvent

        L10_2 = "phone:phone:removeVoiceTarget"

        L11_2 = L3_2[L8_2]

        L12_2 = L2_2

        L13_2 = true

        L9_2(L10_2, L11_2, L12_2, L13_2)

        if L4_2 then

          L9_2 = #L4_2

          if L9_2 > 0 then

            L9_2 = TriggerClientEvent

            L10_2 = "phone:phone:removeVoiceTarget"

            L11_2 = L3_2[L8_2]

            L12_2 = L4_2

            L13_2 = true

            L9_2(L10_2, L11_2, L12_2, L13_2)

          end

        end

      end

    end

  end

  if L4_2 and L1_2 then

    L5_2 = #L4_2

    if L5_2 > 0 then

      L5_2 = TriggerClientEvent

      L6_2 = "phone:phone:removeVoiceTarget"

      L7_2 = L1_2

      L8_2 = L4_2

      L9_2 = true

      L5_2(L6_2, L7_2, L8_2, L9_2)

      L5_2 = 1

      L6_2 = #L4_2

      L7_2 = 1

      for L8_2 = L5_2, L6_2, L7_2 do

        L9_2 = TriggerClientEvent

        L10_2 = "phone:phone:removeVoiceTarget"

        L11_2 = L4_2[L8_2]

        L12_2 = L1_2

        L13_2 = true

        L9_2(L10_2, L11_2, L12_2, L13_2)

        if L3_2 then

          L9_2 = #L3_2

          if L9_2 > 0 then

            L9_2 = TriggerClientEvent

            L10_2 = "phone:phone:removeVoiceTarget"

            L11_2 = L4_2[L8_2]

            L12_2 = L3_2

            L13_2 = true

            L9_2(L10_2, L11_2, L12_2, L13_2)

          end

        end

      end

    end

  end

end

L2_1(L3_1, L4_1)
