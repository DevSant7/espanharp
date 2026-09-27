local L0_1, L1_1, L2_1

L0_1 = RegisterNUICallback

L1_1 = "DarkChat"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "DarkChat:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "getUsername" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:getUsername"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "setPassword" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:setPassword"

    L5_2 = A1_2

    L6_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2)

  elseif "login" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:login"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "logout" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:logout"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "changePassword" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:changePassword"

    L5_2 = A1_2

    L6_2 = A0_2.oldPassword

    L7_2 = A0_2.newPassword

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "deleteAccount" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:deleteAccount"

    L5_2 = A1_2

    L6_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2)

  elseif "register" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:register"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getChannels" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:getChannels"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "createChannel" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:createChannel"

    L5_2 = A1_2

    L6_2 = A0_2.channel

    L7_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "joinChannel" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:joinChannel"

    L5_2 = A1_2

    L6_2 = A0_2.channel

    L7_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getMessages" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:getMessages"

    L5_2 = A1_2

    L6_2 = A0_2.channel

    L7_2 = A0_2.lastId

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "sendMessage" == L2_2 then

    L3_2 = CanInteract

    L3_2 = L3_2()

    if not L3_2 then

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    end

    L3_2 = TriggerCallback

    L4_2 = "darkchat:sendMessage"

    L5_2 = A1_2

    L6_2 = A0_2.channel

    L7_2 = A0_2.content

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "leaveChannel" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "darkchat:leaveChannel"

    L5_2 = A1_2

    L6_2 = A0_2.channel

    L3_2(L4_2, L5_2, L6_2)

  end

end

L0_1(L1_1, L2_1)

L0_1 = RegisterNetEvent

L1_1 = "phone:darkChat:newMessage"

function L2_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2

  L3_2 = SendReactMessage

  L4_2 = "darkChat:newMessage"

  L5_2 = {}

  L5_2.channel = A0_2

  L5_2.sender = A1_2

  L5_2.content = A2_2

  L3_2(L4_2, L5_2)

end

L0_1(L1_1, L2_1)

L0_1 = RegisterNetEvent

L1_1 = "phone:darkChat:updateChannel"

function L2_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2

  L3_2 = SendReactMessage

  L4_2 = "darkChat:updateChannel"

  L5_2 = {}

  L5_2.action = A2_2

  L5_2.channel = A0_2

  L5_2.username = A1_2

  L3_2(L4_2, L5_2)

end

L0_1(L1_1, L2_1)

L0_1 = RegisterNetEvent

L1_1 = "phone:darkChat:joinChannel"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "darkChat:addChannel"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L0_1(L1_1, L2_1)

L0_1 = RegisterNetEvent

L1_1 = "phone:darkChat:leaveChannel"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "darkChat:leaveChannel"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L0_1(L1_1, L2_1)