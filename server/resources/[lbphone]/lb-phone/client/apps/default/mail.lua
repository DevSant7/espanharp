local L0_1, L1_1, L2_1, L3_1, L4_1

L0_1 = nil

function L1_1(A0_2)

  local L1_2, L2_2

  if not A0_2 then

    L1_2 = false

    return L1_2

  end

  L1_2 = A0_2.attachments

  if not L1_2 then

    L1_2 = {}

    A0_2.attachments = L1_2

  else

    L1_2 = json

    L1_2 = L1_2.decode

    L2_2 = A0_2.attachments

    L1_2 = L1_2(L2_2)

    A0_2.attachments = L1_2

  end

  L1_2 = A0_2.actions

  if not L1_2 then

    L1_2 = {}

    A0_2.actions = L1_2

  else

    L1_2 = json

    L1_2 = L1_2.decode

    L2_2 = A0_2.actions

    L1_2 = L1_2(L2_2)

    A0_2.actions = L1_2

  end

  return A0_2

end

L2_1 = RegisterNUICallback

L3_1 = "Mail"

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Mail:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L3_2(L4_2, L5_2)

  if "isLoggedIn" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:isLoggedIn"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "createMail" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:createAccount"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L6_2 = L6_2.email

    L7_2 = A0_2.data

    L7_2 = L7_2.password

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "changePassword" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:changePassword"

    L5_2 = A1_2

    L6_2 = A0_2.oldPassword

    L7_2 = A0_2.newPassword

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "deleteAccount" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:deleteAccount"

    L5_2 = A1_2

    L6_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2)

  elseif "login" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:login"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L6_2 = L6_2.email

    L7_2 = A0_2.data

    L7_2 = L7_2.password

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "logout" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:logout"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getMails" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:getMails"

    L5_2 = A1_2

    L6_2 = {}

    L7_2 = A0_2.lastId

    L6_2.lastId = L7_2

    L3_2(L4_2, L5_2, L6_2)

  elseif "getMail" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:getMail"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3

      L1_3 = L1_1

      L2_3 = A0_3

      L1_3 = L1_3(L2_3)

      L0_1 = L1_3

      L2_3 = A1_2

      L3_3 = L1_3

      L2_3(L3_3)

    end

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "search" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:getMails"

    L5_2 = A1_2

    L6_2 = {}

    L7_2 = A0_2.query

    L6_2.search = L7_2

    L7_2 = A0_2.lastId

    L6_2.lastId = L7_2

    L3_2(L4_2, L5_2, L6_2)

  elseif "sendMail" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:sendMail"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "deleteMail" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "mail:deleteMail"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "action" == L2_2 then

    L3_2 = L0_1.id

    L4_2 = A0_2.id

    if L3_2 ~= L4_2 then

      L3_2 = debugprint

      L4_2 = "wrong mail id for action"

      return L3_2(L4_2)

    end

    L3_2 = A0_2.actionId

    if not L3_2 then

      L3_2 = 0

    end

    L3_2 = L3_2 + 1

    L4_2 = L0_1.actions

    L4_2 = L4_2[L3_2]

    if L4_2 then

      L4_2 = L4_2.data

    end

    if not L4_2 then

      L5_2 = debugprint

      L6_2 = "no action found"

      L7_2 = L3_2

      return L5_2(L6_2, L7_2)

    end

    L5_2 = L4_2.data

    if L5_2 then

      L5_2 = L5_2.qbMail

    end

    if L5_2 then

      L5_2 = TriggerEvent

      L6_2 = L4_2.event

      L7_2 = L4_2.data

      L7_2 = L7_2.data

      L5_2(L6_2, L7_2)

      L5_2 = A1_2

      L6_2 = "ok"

      return L5_2(L6_2)

    end

    L5_2 = L4_2.isServer

    if L5_2 then

      L5_2 = TriggerServerEvent

      L6_2 = L4_2.event

      L7_2 = A0_2.id

      L8_2 = L4_2.data

      L5_2(L6_2, L7_2, L8_2)

    else

      L5_2 = TriggerEvent

      L6_2 = L4_2.event

      L7_2 = A0_2.id

      L8_2 = L4_2.data

      L5_2(L6_2, L7_2, L8_2)

    end

    L5_2 = A1_2

    L6_2 = "ok"

    L5_2(L6_2)

  end

end

L2_1(L3_1, L4_1)

L2_1 = RegisterNetEvent

L3_1 = "phone:mail:newMail"

function L4_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "mail:newMail"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L2_1(L3_1, L4_1)

L2_1 = RegisterNetEvent

L3_1 = "phone:mail:mailDeleted"

function L4_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "mail:deleteMail"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L2_1(L3_1, L4_1)