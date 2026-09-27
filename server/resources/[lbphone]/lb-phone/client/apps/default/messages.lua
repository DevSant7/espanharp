local L0_1, L1_1, L2_1, L3_1

L0_1 = {}

L1_1 = "sendMessage"

L2_1 = "createGroup"

L3_1 = "renameGroup"

L0_1[1] = L1_1

L0_1[2] = L2_1

L0_1[3] = L3_1

L1_1 = RegisterNUICallback

L2_1 = "Messages"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Messages:"

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

  L3_2 = A0_2.attachments

  if L3_2 then

    L3_2 = A0_2.attachments

    L3_2 = #L3_2

    if 0 == L3_2 then

      goto lbl_38

    end

  end

  L3_2 = A0_2.attachments

  ::lbl_38::

  if not L3_2 then

    A0_2.attachments = nil

  else

    L3_2 = json

    L3_2 = L3_2.encode

    L4_2 = A0_2.attachments

    L3_2 = L3_2(L4_2)

    A0_2.attachments = L3_2

  end

  if "sendMessage" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:messages:messageSent"

    L5_2 = A0_2.number

    L6_2 = A0_2.content

    L7_2 = A0_2.attachments

    L3_2(L4_2, L5_2, L6_2, L7_2)

    L3_2 = TriggerCallback

    L4_2 = "messages:sendMessage"

    L5_2 = A1_2

    L6_2 = A0_2.number

    L7_2 = A0_2.content

    L8_2 = A0_2.attachments

    L9_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)

  elseif "createGroup" == L2_2 then

    L3_2 = {}

    L4_2 = 1

    L5_2 = A0_2.members

    L5_2 = #L5_2

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = A0_2.members

      L8_2 = L8_2[L7_2]

      L8_2 = L8_2.number

      L3_2[L7_2] = L8_2

    end

    L4_2 = TriggerCallback

    L5_2 = "messages:createGroup"

    L6_2 = A1_2

    L7_2 = L3_2

    L8_2 = A0_2.content

    L9_2 = A0_2.attachments

    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)

  elseif "renameGroup" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "messages:renameGroup"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.name

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getRecentMessages" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "messages:getRecentMessages"

    L3_2 = L3_2(L4_2)

    L4_2 = {}

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3, L5_3

      L1_3 = 1

      L2_3 = L4_2

      L2_3 = #L2_3

      L3_3 = 1

      for L4_3 = L1_3, L2_3, L3_3 do

        L5_3 = L4_2

        L5_3 = L5_3[L4_3]

        L5_3 = L5_3.id

        if L5_3 == A0_3 then

          return L4_3

        end

      end

      L1_3 = false

      return L1_3

    end

    L6_2 = 1

    L7_2 = #L3_2

    L8_2 = 1

    for L9_2 = L6_2, L7_2, L8_2 do

      L10_2 = L3_2[L9_2]

      L11_2 = L5_2

      L12_2 = L10_2.channel_id

      L11_2 = L11_2(L12_2)

      if not L11_2 then

        L12_2 = L10_2.is_group

        if L12_2 then

          L12_2 = #L4_2

          L12_2 = L12_2 + 1

          L13_2 = {}

          L14_2 = L10_2.channel_id

          L13_2.id = L14_2

          L14_2 = L10_2.last_message

          L13_2.lastMessage = L14_2

          L14_2 = L10_2.last_message_timestamp

          L13_2.timestamp = L14_2

          L14_2 = L10_2.name

          L13_2.name = L14_2

          L13_2.isGroup = true

          L14_2 = {}

          L15_2 = {}

          L16_2 = L10_2.is_owner

          L15_2.isOwner = L16_2

          L16_2 = L10_2.phone_number

          L15_2.number = L16_2

          L14_2[1] = L15_2

          L13_2.members = L14_2

          L4_2[L12_2] = L13_2

        else

          L12_2 = L10_2.phone_number

          L13_2 = currentPhone

          if L12_2 ~= L13_2 then

            L12_2 = #L4_2

            L12_2 = L12_2 + 1

            L13_2 = {}

            L14_2 = L10_2.channel_id

            L13_2.id = L14_2

            L14_2 = L10_2.last_message

            L13_2.lastMessage = L14_2

            L14_2 = L10_2.last_message_timestamp

            L13_2.timestamp = L14_2

            L14_2 = L10_2.phone_number

            L13_2.number = L14_2

            L13_2.isGroup = false

            L4_2[L12_2] = L13_2

          end

        end

      else

        L12_2 = L10_2.is_group

        if L12_2 then

          L12_2 = L4_2[L11_2]

          L12_2 = L12_2.members

          L13_2 = L4_2[L11_2]

          L13_2 = L13_2.members

          L13_2 = #L13_2

          L13_2 = L13_2 + 1

          L14_2 = {}

          L15_2 = L10_2.is_owner

          L14_2.isOwner = L15_2

          L15_2 = L10_2.phone_number

          L14_2.number = L15_2

          L12_2[L13_2] = L14_2

        end

      end

    end

    L6_2 = 1

    L7_2 = #L3_2

    L8_2 = 1

    for L9_2 = L6_2, L7_2, L8_2 do

      L10_2 = L3_2[L9_2]

      L11_2 = L5_2

      L12_2 = L10_2.channel_id

      L11_2 = L11_2(L12_2)

      if L11_2 then

        L12_2 = L10_2.phone_number

        L13_2 = currentPhone

        if L12_2 == L13_2 then

          L12_2 = L4_2[L11_2]

          L13_2 = L10_2.deleted

          L12_2.deleted = L13_2

          L12_2 = L4_2[L11_2]

          L13_2 = L10_2.unread

          L13_2 = L13_2 > 0

          L12_2.unread = L13_2

        end

      end

    end

    L6_2 = A1_2

    L7_2 = L4_2

    L6_2(L7_2)

  elseif "getMessages" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "messages:getMessages"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3

      L1_3 = 1

      L2_3 = #A0_3

      L3_3 = 1

      for L4_3 = L1_3, L2_3, L3_3 do

        L5_3 = A0_3[L4_3]

        L6_3 = json

        L6_3 = L6_3.decode

        L7_3 = A0_3[L4_3]

        L7_3 = L7_3.attachments

        if not L7_3 then

          L7_3 = "[]"

        end

        L6_3 = L6_3(L7_3)

        L5_3.attachments = L6_3

      end

      L1_3 = A1_2

      L2_3 = A0_3

      L1_3(L2_3)

    end

    L6_2 = A0_2.id

    L7_2 = A0_2.lastId

    L3_2(L4_2, L5_2, L6_2, L7_2)

  else

    if "deleteMessage" == L2_2 then

      L3_2 = Config

      L3_2 = L3_2.DeleteMessages

      if L3_2 then

        L3_2 = TriggerCallback

        L4_2 = "messages:deleteMessage"

        L5_2 = A1_2

        L6_2 = A0_2.id

        L7_2 = A0_2.channel

        L3_2(L4_2, L5_2, L6_2, L7_2)

    end

    elseif "addMember" == L2_2 then

      L3_2 = TriggerCallback

      L4_2 = "messages:addMember"

      L5_2 = A1_2

      L6_2 = A0_2.id

      L7_2 = A0_2.number

      L3_2(L4_2, L5_2, L6_2, L7_2)

    elseif "removeMember" == L2_2 then

      L3_2 = TriggerCallback

      L4_2 = "messages:removeMember"

      L5_2 = A1_2

      L6_2 = A0_2.id

      L7_2 = A0_2.number

      L3_2(L4_2, L5_2, L6_2, L7_2)

    elseif "leaveGroup" == L2_2 then

      L3_2 = TriggerCallback

      L4_2 = "messages:leaveGroup"

      L5_2 = A1_2

      L6_2 = A0_2.id

      L3_2(L4_2, L5_2, L6_2)

    elseif "markRead" == L2_2 then

      L3_2 = TriggerCallback

      L4_2 = "messages:markRead"

      L5_2 = A1_2

      L6_2 = A0_2.id

      L3_2(L4_2, L5_2, L6_2)

    elseif "deleteConversations" == L2_2 then

      L3_2 = TriggerCallback

      L4_2 = "messages:deleteConversations"

      L5_2 = A1_2

      L6_2 = A0_2.channels

      L3_2(L4_2, L5_2, L6_2)

    end

  end

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:messages:newMessage"

function L3_1(A0_2, A1_2, A2_2, A3_2, A4_2)

  local L5_2, L6_2, L7_2, L8_2, L9_2

  L5_2 = SendReactMessage

  L6_2 = "messages:newMessage"

  L7_2 = {}

  L7_2.channelId = A0_2

  L7_2.messageId = A1_2

  L7_2.sender = A2_2

  L7_2.content = A3_2

  if A4_2 then

    L8_2 = json

    L8_2 = L8_2.decode

    L9_2 = A4_2

    L8_2 = L8_2(L9_2)

    if L8_2 then

      goto lbl_19

    end

  end

  L8_2 = {}

  ::lbl_19::

  L7_2.attachments = L8_2

  L5_2(L6_2, L7_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:messages:messageDeleted"

function L3_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2

  L3_2 = SendReactMessage

  L4_2 = "messages:messageDeleted"

  L5_2 = {}

  L5_2.channelId = A0_2

  L5_2.messageId = A1_2

  L5_2.isLastMessage = A2_2

  L3_2(L4_2, L5_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:messages:renameGroup"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "messages:renameGroup"

  L4_2 = {}

  L4_2.channelId = A0_2

  L4_2.name = A1_2

  L2_2(L3_2, L4_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:messages:memberAdded"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "messages:addMember"

  L4_2 = {}

  L4_2.channelId = A0_2

  L4_2.number = A1_2

  L2_2(L3_2, L4_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:messages:memberRemoved"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "messages:removeMember"

  L4_2 = {}

  L4_2.channelId = A0_2

  L4_2.number = A1_2

  L2_2(L3_2, L4_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:messages:ownerChanged"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "messages:changeOwner"

  L4_2 = {}

  L4_2.channelId = A0_2

  L4_2.number = A1_2

  L2_2(L3_2, L4_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:messages:newChannel"

function L3_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "messages:newChannel"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L1_1(L2_1, L3_1)