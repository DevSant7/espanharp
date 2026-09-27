local L0_1, L1_1, L2_1, L3_1

function L0_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = currentPhone

  if A0_2 == L2_2 then

    L2_2 = debugprint

    L3_2 = "can't apply backup since it's the currently equipped number"

    L2_2(L3_2)

    L2_2 = A1_2

    L3_2 = false

    return L2_2(L3_2)

  end

  L2_2 = AwaitCallback

  L3_2 = "backup:applyBackup"

  L4_2 = A0_2

  L2_2 = L2_2(L3_2, L4_2)

  L3_2 = debugprint

  L4_2 = "phone:backup:applyBackup"

  L5_2 = A0_2

  L6_2 = ":"

  L7_2 = L2_2

  L3_2(L4_2, L5_2, L6_2, L7_2)

  L3_2 = A1_2

  L4_2 = L2_2

  L3_2(L4_2)

  if not L2_2 then

    return

  end

  L3_2 = Wait

  L4_2 = 5000

  L3_2(L4_2)

  L3_2 = OnDeath

  L3_2()

  L3_2 = Wait

  L4_2 = 500

  L3_2(L4_2)

  L3_2 = FetchPhone

  L3_2()

  L3_2 = Wait

  L4_2 = 500

  L3_2(L4_2)

  L3_2 = ToggleOpen

  L4_2 = true

  L3_2(L4_2)

end

L1_1 = RegisterNUICallback

L2_1 = "Backup"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Backup:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "create" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "backup:createBackup"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "delete" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "backup:deleteBackup"

    L5_2 = A1_2

    L6_2 = A0_2.number

    L3_2(L4_2, L5_2, L6_2)

  elseif "apply" == L2_2 then

    L3_2 = L0_1

    L4_2 = A0_2.number

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "get" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "backup:getBackups"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  end

end

L1_1(L2_1, L3_1)