local L0_1, L1_1, L2_1

L0_1 = RegisterNUICallback

L1_1 = "YellowPages"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Pages:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "getPosts" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "yellowPages:getPosts"

    L5_2 = A1_2

    L6_2 = A0_2.page

    L7_2 = {}

    L8_2 = A0_2.query

    L7_2.search = L8_2

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "sendPost" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "yellowPages:createPost"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "deletePost" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "yellowPages:deletePost"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  end

end

L0_1(L1_1, L2_1)

L0_1 = RegisterNetEvent

L1_1 = "phone:yellowPages:newPost"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = TriggerEvent

  L2_2 = "lb-phone:pages:newPost"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "yellowPages:newPost"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L0_1(L1_1, L2_1)