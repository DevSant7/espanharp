local L0_1, L1_1, L2_1

L0_1 = RegisterNUICallback

L1_1 = "MarketPlace"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "MarketPlace:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "getPosts" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "marketplace:getPosts"

    L5_2 = A0_2

    L3_2 = L3_2(L4_2, L5_2)

    L4_2 = 1

    L5_2 = #L3_2

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = L3_2[L7_2]

      L9_2 = json

      L9_2 = L9_2.decode

      L10_2 = L3_2[L7_2]

      L10_2 = L10_2.attachments

      L9_2 = L9_2(L10_2)

      L8_2.attachments = L9_2

    end

    L4_2 = A1_2

    L5_2 = L3_2

    L4_2(L5_2)

  elseif "sendPost" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "marketplace:createPost"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "deletePost" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "marketplace:deletePost"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  end

end

L0_1(L1_1, L2_1)

L0_1 = RegisterNetEvent

L1_1 = "phone:marketplace:newPost"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = TriggerEvent

  L2_2 = "lb-phone:marketplace:newPost"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "marketPlace:newPost"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L0_1(L1_1, L2_1)