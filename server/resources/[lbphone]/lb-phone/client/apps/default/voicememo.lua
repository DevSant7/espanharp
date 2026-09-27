local L0_1, L1_1, L2_1

L0_1 = RegisterNUICallback

L1_1 = "VoiceMemo"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "VoiceMemo:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "upload" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "voiceMemo:saveRecording"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "get" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "voiceMemo:getMemos"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "delete" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "voiceMemo:deleteMemo"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "rename" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "voiceMemo:renameMemo"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.title

    L3_2(L4_2, L5_2, L6_2, L7_2)

  end

end

L0_1(L1_1, L2_1)