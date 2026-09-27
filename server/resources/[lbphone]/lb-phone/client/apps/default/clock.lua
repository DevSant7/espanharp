local L0_1, L1_1, L2_1

L0_1 = RegisterNUICallback

L1_1 = "Clock"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Clock:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "getAlarms" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "clock:getAlarms"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "createAlarm" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "clock:createAlarm"

    L5_2 = A1_2

    L6_2 = A0_2.label

    L7_2 = A0_2.hours

    L8_2 = A0_2.minutes

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "deleteAlarm" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "clock:deleteAlarm"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "toggleAlarm" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "clock:toggleAlarm"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.enabled

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "updateAlarm" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "clock:updateAlarm"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.label

    L8_2 = A0_2.hours

    L9_2 = A0_2.minutes

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)

  end

end

L0_1(L1_1, L2_1)