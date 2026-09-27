local L0_1, L1_1, L2_1, L3_1, L4_1

L0_1 = {}

L1_1 = "createAccount"

L2_1 = "saveProfile"

L3_1 = "sendMessage"

L0_1[1] = L1_1

L0_1[2] = L2_1

L0_1[3] = L3_1

function L1_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L2_2 = AwaitCallback

  L3_2 = "spark:getMatches"

  L4_2 = A0_2

  L5_2 = A1_2

  L2_2 = L2_2(L3_2, L4_2, L5_2)

  L3_2 = {}

  L4_2 = 1

  L5_2 = #L2_2

  L6_2 = 1

  for L7_2 = L4_2, L5_2, L6_2 do

    L8_2 = L2_2[L7_2]

    L9_2 = {}

    L10_2 = L8_2.name

    L9_2.name = L10_2

    L10_2 = L8_2.phone_number

    L9_2.number = L10_2

    L10_2 = json

    L10_2 = L10_2.decode

    L11_2 = L8_2.photos

    L10_2 = L10_2(L11_2)

    L9_2.photos = L10_2

    L10_2 = L8_2.dob

    L9_2.dob = L10_2

    L10_2 = L8_2.bio

    L9_2.bio = L10_2

    L10_2 = L8_2.is_male

    L9_2.isMale = L10_2

    L10_2 = L8_2.latest_message_timestamp

    L9_2.timestamp = L10_2

    L10_2 = L8_2.unread

    L10_2 = true == L10_2

    L9_2.unread = L10_2

    L10_2 = L8_2.latest_message

    if L10_2 then

      L10_2 = L8_2.latest_message

      L9_2.lastMessage = L10_2

      L10_2 = L8_2.latest_sender

      L9_2.lastSender = L10_2

    end

    L3_2[L7_2] = L9_2

  end

  return L3_2

end

L2_1 = RegisterNUICallback

L3_1 = "Tinder"

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Spark:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  L3_2 = table

  L3_2 = L3_2.contains

  L4_2 = L0_1

  L5_2 = L2_2

  L3_2 = L3_2(L4_2, L5_2)

  if L3_2 then

    L3_2 = CanInteract

    L3_2 = L3_2()

    if not L3_2 then

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    end

  end

  if "createAccount" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "spark:createAccount"

    L5_2 = A1_2

    L6_2 = A0_2.data

    return L3_2(L4_2, L5_2, L6_2)

  elseif "deleteAccount" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "spark:deleteAccount"

    L5_2 = A1_2

    return L3_2(L4_2, L5_2)

  elseif "saveProfile" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "spark:updateAccount"

    L5_2 = A1_2

    L6_2 = A0_2.data

    return L3_2(L4_2, L5_2, L6_2)

  elseif "isLoggedIn" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "spark:isLoggedIn"

    L5_2 = A0_2.phoneNumber

    L3_2 = L3_2(L4_2, L5_2)

    L4_2 = A1_2

    L5_2 = L3_2 or L5_2

    if not L3_2 then

      L5_2 = false

    end

    return L4_2(L5_2)

  elseif "getFeed" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "spark:getFeed"

    L5_2 = A0_2.page

    L3_2 = L3_2(L4_2, L5_2)

    L4_2 = {}

    L5_2 = 1

    L6_2 = #L3_2

    L7_2 = 1

    for L8_2 = L5_2, L6_2, L7_2 do

      L9_2 = L3_2[L8_2]

      L10_2 = {}

      L11_2 = L9_2.name

      L10_2.name = L11_2

      L11_2 = L9_2.dob

      L10_2.dob = L11_2

      L11_2 = L9_2.bio

      L10_2.bio = L11_2

      L11_2 = json

      L11_2 = L11_2.decode

      L12_2 = L9_2.photos

      L11_2 = L11_2(L12_2)

      L10_2.photos = L11_2

      L11_2 = L9_2.phone_number

      L10_2.number = L11_2

      L4_2[L8_2] = L10_2

    end

    L5_2 = A1_2

    L6_2 = L4_2

    L5_2(L6_2)

  elseif "swipe" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "spark:swipe"

    L5_2 = A1_2

    L6_2 = A0_2.number

    L7_2 = A0_2.like

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getNewMatchesCount" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "spark:getNewMatchesCount"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getMatches" == L2_2 then

    L3_2 = A1_2

    L4_2 = L1_1

    L5_2 = false

    L6_2 = A0_2.page

    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L4_2(L5_2, L6_2)

    return L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

  elseif "getRecentMessages" == L2_2 then

    L3_2 = A1_2

    L4_2 = L1_1

    L5_2 = true

    L6_2 = A0_2.page

    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L4_2(L5_2, L6_2)

    return L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

  elseif "sendMessage" == L2_2 then

    A0_2 = A0_2.data

    L3_2 = type

    L4_2 = A0_2.attachments

    L3_2 = L3_2(L4_2)

    if "table" == L3_2 then

      L3_2 = A0_2.attachments

      L3_2 = #L3_2

      if 0 ~= L3_2 then

        goto lbl_150

      end

    end

    A0_2.attachments = nil

    ::lbl_150::

    L3_2 = TriggerCallback

    L4_2 = "spark:sendMessage"

    L5_2 = A1_2

    L6_2 = A0_2.recipient

    L7_2 = A0_2.content

    L8_2 = A0_2.attachments

    if L8_2 then

      L8_2 = A0_2.attachments

    end

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "getMessages" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "spark:getMessages"

    L5_2 = A0_2.number

    L6_2 = A0_2.lastId

    L3_2 = L3_2(L4_2, L5_2, L6_2)

    L4_2 = 1

    L5_2 = #L3_2

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = L3_2[L7_2]

      L8_2 = L8_2.attachments

      if L8_2 then

        L8_2 = L3_2[L7_2]

        L9_2 = json

        L9_2 = L9_2.decode

        L10_2 = L3_2[L7_2]

        L10_2 = L10_2.attachments

        L9_2 = L9_2(L10_2)

        L8_2.attachments = L9_2

      else

        L8_2 = L3_2[L7_2]

        L9_2 = {}

        L8_2.attachments = L9_2

      end

    end

    L4_2 = A1_2

    L5_2 = L3_2

    L4_2(L5_2)

  elseif "markAsRead" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "spark:markAsRead"

    L5_2 = A1_2

    L6_2 = A0_2.number

    L3_2(L4_2, L5_2, L6_2)

  end

end

L2_1(L3_1, L4_1)

L2_1 = RegisterNetEvent

L3_1 = "phone:spark:newMessage"

function L4_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = A0_2.attachments

  if not L1_2 then

    L1_2 = {}

  end

  A0_2.attachments = L1_2

  L1_2 = SendReactMessage

  L2_2 = "tinder:newMessage"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L2_1(L3_1, L4_1)