local L0_1, L1_1, L2_1

L0_1 = RegisterNUICallback

L1_1 = "AppStore"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "AppStore:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "buyApp" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "appstore:buyApp"

    L5_2 = A1_2

    L6_2 = A0_2.price

    L3_2(L4_2, L5_2, L6_2)

  end

end

L0_1(L1_1, L2_1)