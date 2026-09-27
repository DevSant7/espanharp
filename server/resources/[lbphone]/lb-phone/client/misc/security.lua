local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1

L0_1 = nil

L1_1 = nil

L2_1 = nil

function L3_1(A0_2)

  local L1_2, L2_2

  L1_2 = debugprint

  L2_2 = "ResetSecurity triggered"

  L1_2(L2_2)

  L1_2 = nil

  L0_1 = L1_2

  L1_2 = nil

  L1_1 = L1_2

  L1_2 = nil

  L2_1 = L1_2

  if not A0_2 then

    L1_2 = SendReactMessage

    L2_2 = "resetSecurity"

    L1_2(L2_2)

  end

end

ResetSecurity = L3_1

function L3_1()

  local L0_2, L1_2, L2_2

  L0_2 = L2_1

  if not L0_2 then

    L0_2 = AwaitCallback

    L1_2 = "security:getIdentifier"

    L0_2 = L0_2(L1_2)

    L2_1 = L0_2

    L0_2 = debugprint

    L1_2 = "getIdentifier:"

    L2_2 = L2_1

    L0_2(L1_2, L2_2)

  end

  L0_2 = L2_1

  if not L0_2 then

    L0_2 = "unknown"

  end

  return L0_2

end

GetIdentifier = L3_1

function L3_1(A0_2)

  local L1_2, L2_2, L3_2

  if A0_2 then

    L1_2 = type

    L2_2 = A0_2

    L1_2 = L1_2(L2_2)

    if "string" == L1_2 then

      L1_2 = #A0_2

      if 4 ~= L1_2 then

        L1_2 = debugprint

        L2_2 = "invalid data.pin: invalid length"

        L3_2 = A0_2

        L1_2(L2_2, L3_2)

        L1_2 = false

        return L1_2

      else

        L1_2 = tonumber

        L2_2 = A0_2

        L1_2 = L1_2(L2_2)

        if not L1_2 then

          L1_2 = debugprint

          L2_2 = "invalid data.pin: failed to convert to number"

          L3_2 = A0_2

          L1_2(L2_2, L3_2)

          L1_2 = false

          return L1_2

        end

      end

      L1_2 = true

      return L1_2

    end

  end

  L1_2 = false

  return L1_2

end

L4_1 = RegisterNUICallback

L5_1 = "Security"

function L6_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Security:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L5_2 = A0_2

  L3_2(L4_2, L5_2)

  if "setPin" == L2_2 then

    L3_2 = A0_2.pin

    L4_2 = L0_1

    if L3_2 == L4_2 then

      L3_2 = debugprint

      L4_2 = "Failed to set pin: new pin is the same as the old pin"

      L3_2(L4_2)

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    end

    L3_2 = L3_1

    L4_2 = A0_2.pin

    L3_2 = L3_2(L4_2)

    if not L3_2 then

      L3_2 = debugprint

      L4_2 = "Failed to set pin: invalid pin"

      L3_2(L4_2)

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    end

    L3_2 = AwaitCallback

    L4_2 = "security:setPin"

    L5_2 = A0_2.pin

    L6_2 = L0_1

    L3_2 = L3_2(L4_2, L5_2, L6_2)

    if L3_2 then

      L4_2 = debugprint

      L5_2 = "Successfully set pin to"

      L6_2 = A0_2.pin

      L4_2(L5_2, L6_2)

      L4_2 = A0_2.pin

      L0_1 = L4_2

    else

      L4_2 = debugprint

      L5_2 = "Failed to set pin"

      L4_2(L5_2)

    end

    L4_2 = A1_2

    L5_2 = L3_2

    L4_2(L5_2)

  elseif "removePin" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "security:removePin"

    L5_2 = L0_1

    L3_2 = L3_2(L4_2, L5_2)

    if L3_2 then

      L4_2 = ResetSecurity

      L4_2()

    end

    L4_2 = A1_2

    L5_2 = L3_2

    L4_2(L5_2)

  elseif "verifyPin" == L2_2 then

    L3_2 = L0_1

    if L3_2 then

      L3_2 = debugprint

      L4_2 = "Has cached pin"

      L5_2 = L0_1

      L6_2 = A0_2.pin

      L3_2(L4_2, L5_2, L6_2)

      L3_2 = A1_2

      L4_2 = L0_1

      L5_2 = A0_2.pin

      L4_2 = L4_2 == L5_2

      return L3_2(L4_2)

    end

    L3_2 = L3_1

    L4_2 = A0_2.pin

    L3_2 = L3_2(L4_2)

    if not L3_2 then

      L3_2 = debugprint

      L4_2 = "Failed to verify pin: invalid pin"

      L3_2(L4_2)

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    end

    L3_2 = AwaitCallback

    L4_2 = "security:verifyPin"

    L5_2 = A0_2.pin

    L3_2 = L3_2(L4_2, L5_2)

    L4_2 = debugprint

    L5_2 = "security:verifyPin returned:"

    L6_2 = L3_2

    L4_2(L5_2, L6_2)

    if L3_2 then

      L4_2 = debugprint

      L5_2 = "Correct pin, caching it"

      L6_2 = A0_2.pin

      L4_2(L5_2, L6_2)

      L4_2 = A0_2.pin

      L0_1 = L4_2

    end

    L4_2 = A1_2

    L5_2 = L3_2

    L4_2(L5_2)

  end

  if "setFaceId" == L2_2 then

    L3_2 = L0_1

    if L3_2 then

      L3_2 = L0_1

      L4_2 = A0_2.pin

      if L3_2 == L4_2 then

        goto lbl_140

      end

    end

    L3_2 = debugprint

    L4_2 = "Failed to enable Face Unlock: incorrect pin"

    L3_2(L4_2)

    L3_2 = debugprint

    L4_2 = L0_1

    L5_2 = A0_2.pin

    L3_2(L4_2, L5_2)

    L3_2 = A1_2

    L4_2 = false

    do return L3_2(L4_2) end

    ::lbl_140::

    L3_2 = debugprint

    L4_2 = "Correct pin, triggering enableFaceUnlock"

    L3_2(L4_2)

    L3_2 = TriggerCallback

    L4_2 = "security:enableFaceUnlock"

    L5_2 = A1_2

    L6_2 = A0_2.pin

    L3_2(L4_2, L5_2, L6_2)

  elseif "removeFaceId" == L2_2 then

    L3_2 = L0_1

    if L3_2 then

      L3_2 = L0_1

      L4_2 = A0_2.pin

      if L3_2 == L4_2 then

        goto lbl_165

      end

    end

    L3_2 = debugprint

    L4_2 = "Failed to disable Face Unlock: incorrect pin"

    L3_2(L4_2)

    L3_2 = A1_2

    L4_2 = false

    do return L3_2(L4_2) end

    ::lbl_165::

    L3_2 = debugprint

    L4_2 = "Correct pin, triggering disableFaceUnlock"

    L3_2(L4_2)

    L3_2 = TriggerCallback

    L4_2 = "security:disableFaceUnlock"

    L5_2 = A1_2

    L6_2 = A0_2.pin

    L3_2(L4_2, L5_2, L6_2)

  elseif "verifyFace" == L2_2 then

    L3_2 = IsFaceObstructed

    L3_2 = L3_2()

    if L3_2 then

      L3_2 = debugprint

      L4_2 = "Face is obstructed"

      L3_2(L4_2)

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    end

    L3_2 = L2_1

    if not L3_2 then

      L3_2 = GetIdentifier

      L3_2()

    end

    L3_2 = L1_1

    if L3_2 then

      L3_2 = debugprint

      L4_2 = "Has cached face, returning:"

      L5_2 = L1_1

      L6_2 = L2_1

      L5_2 = L5_2 == L6_2

      L3_2(L4_2, L5_2)

      L3_2 = A1_2

      L4_2 = L1_1

      L5_2 = L2_1

      L4_2 = L4_2 == L5_2

      return L3_2(L4_2)

    end

    L3_2 = AwaitCallback

    L4_2 = "security:verifyFace"

    L3_2 = L3_2(L4_2)

    L4_2 = debugprint

    L5_2 = "security:verifyFace returned:"

    L6_2 = L3_2

    L4_2(L5_2, L6_2)

    if L3_2 then

      L4_2 = L2_1

      L1_1 = L4_2

    end

    L4_2 = A1_2

    L5_2 = L3_2

    L4_2(L5_2)

  end

  if "factoryReset" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:factoryReset"

    L3_2(L4_2)

  end

end

L4_1(L5_1, L6_1)

L4_1 = RegisterNetEvent

L5_1 = "phone:factoryReset"

function L6_1()

  local L0_2, L1_2

  L0_2 = OnDeath

  L0_2()

  L0_2 = ResetSecurity

  L0_2()

  L0_2 = FetchPhone

  L0_2()

end

L4_1(L5_1, L6_1)

L4_1 = RegisterNetEvent

L5_1 = "phone:security:reset"

function L6_1(A0_2)

  local L1_2, L2_2

  L1_2 = currentPhone

  if A0_2 == L1_2 then

    L1_2 = ResetSecurity

    L1_2()

    L1_2 = Wait

    L2_2 = 500

    L1_2(L2_2)

    L1_2 = FetchPhone

    L1_2()

  end

end

L4_1(L5_1, L6_1)
