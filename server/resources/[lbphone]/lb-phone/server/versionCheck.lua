local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1

L0_1 = GetCurrentResourceName

L0_1 = L0_1()

if "lb-phone" ~= L0_1 then

  L0_1 = Citizen

  L0_1 = L0_1.CreateThreadNow

  function L1_1()

    local L0_2, L1_2, L2_2

    while true do

      L0_2 = infoprint

      L1_2 = "error"

      L2_2 = "The resource name is not ^2lb-phone^7. The resource will not work properly. Please change the resource name to ^2lb-phone^7."

      L0_2(L1_2, L2_2)

      L0_2 = Wait

      L1_2 = 5000

      L0_2(L1_2)

    end

  end

  L0_1(L1_1)

end

L0_1 = PerformHttpRequest

L1_1 = "https://loaf-scripts.com/versions/"

function L2_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2

  if A1_2 then

    L3_2 = print

    L4_2 = A1_2

    L3_2(L4_2)

  end

end

L3_1 = "POST"

L4_1 = json

L4_1 = L4_1.encode

L5_1 = {}

L6_1 = IS_BETA_VERSION

if L6_1 then

  L6_1 = "lb-phone-beta"

  if L6_1 then

    goto lbl_25

  end

end

L6_1 = "phone"

::lbl_25::

L5_1.resource = L6_1

L6_1 = GetResourceMetadata

L7_1 = GetCurrentResourceName

L7_1 = L7_1()

L8_1 = "version"

L9_1 = 0

L6_1 = L6_1(L7_1, L8_1, L9_1)

if not L6_1 then

  L6_1 = "0.0.0"

end

L5_1.version = L6_1

L4_1 = L4_1(L5_1)

L5_1 = {}

L5_1["Content-Type"] = "application/json"

L0_1(L1_1, L2_1, L3_1, L4_1, L5_1)
