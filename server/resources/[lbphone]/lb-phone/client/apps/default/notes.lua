local L0_1, L1_1, L2_1

L0_1 = RegisterNUICallback

L1_1 = "Notes"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Notes:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  L3_2 = A0_2.data

  if L3_2 then

    A0_2 = A0_2.data

  end

  if "create" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "notes:createNote"

    L5_2 = A1_2

    L6_2 = A0_2.title

    L7_2 = A0_2.content

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "save" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "notes:saveNote"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.title

    L8_2 = A0_2.content

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "fetch" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "notes:getNotes"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "remove" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "notes:removeNote"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  end

end

L0_1(L1_1, L2_1)