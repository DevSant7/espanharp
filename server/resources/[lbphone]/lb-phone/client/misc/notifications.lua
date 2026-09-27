local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1

L0_1 = {}

function L1_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L0_2 = AwaitCallback

  L1_2 = "getNotifications"

  L0_2 = L0_2(L1_2)

  L1_2 = 1

  L2_2 = #L0_2

  L3_2 = 1

  for L4_2 = L1_2, L2_2, L3_2 do

    L5_2 = L0_2[L4_2]

    L6_2 = L5_2.content

    if nil == L6_2 then

      L6_2 = L5_2.title

      L5_2.content = L6_2

      L5_2.title = nil

    end

    L6_2 = L5_2.custom_data

    if L6_2 then

      L6_2 = json

      L6_2 = L6_2.decode

      L7_2 = L5_2.custom_data

      L6_2 = L6_2(L7_2)

      L7_2 = L6_2.buttons

      if L7_2 then

        L7_2 = L6_2.buttons

        L5_2.actions = L7_2

        L8_2 = L5_2.id

        L7_2 = L0_1

        L7_2[L8_2] = L5_2

      end

      L5_2.custom_data = nil

    end

  end

  return L0_2

end

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  if not A0_2 then

    L1_2 = true

    return L1_2

  end

  L1_2 = L0_1

  L1_2 = L1_2[A0_2]

  if L1_2 then

    L1_2 = L0_1

    L1_2[A0_2] = nil

  end

  L1_2 = type

  L2_2 = A0_2

  L1_2 = L1_2(L2_2)

  if "string" == L1_2 then

    L2_2 = A0_2

    L1_2 = A0_2.find

    L3_2 = "client%-notification%-"

    L1_2 = L1_2(L2_2, L3_2)

    if L1_2 then

      L1_2 = true

      return L1_2

    end

  end

  L1_2 = type

  L2_2 = A0_2

  L1_2 = L1_2(L2_2)

  if "number" ~= L1_2 then

    L1_2 = true

    return L1_2

  end

  L1_2 = AwaitCallback

  L2_2 = "deleteNotification"

  L3_2 = A0_2

  return L1_2(L2_2, L3_2)

end

function L3_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L1_2 = AwaitCallback

  L2_2 = "clearNotifications"

  L3_2 = A0_2

  L1_2 = L1_2(L2_2, L3_2)

  if not L1_2 then

    L2_2 = false

    return L2_2

  end

  L2_2 = 1

  L3_2 = L0_1

  L3_2 = #L3_2

  L4_2 = 1

  for L5_2 = L2_2, L3_2, L4_2 do

    L6_2 = L0_1

    L6_2 = L6_2[L5_2]

    L7_2 = L6_2.app

    if L7_2 == A0_2 then

      L7_2 = L0_1

      L7_2[L5_2] = nil

    end

  end

  return L1_2

end

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  if L2_2 then

    L2_2 = L2_2.actions

  end

  if not L2_2 then

    L3_2 = debugprint

    L4_2 = "No buttons found for notification"

    L5_2 = A0_2

    L6_2 = L0_1

    L3_2(L4_2, L5_2, L6_2)

    L3_2 = false

    return L3_2

  end

  L3_2 = L2_2[A1_2]

  if not L3_2 then

    L4_2 = debugprint

    L5_2 = "Button not found for notification"

    L6_2 = A0_2

    L7_2 = A1_2

    L4_2(L5_2, L6_2, L7_2)

    L4_2 = false

    return L4_2

  end

  L4_2 = L3_2.event

  if L4_2 then

    L4_2 = L3_2.server

    if L4_2 then

      L4_2 = TriggerServerEvent

      L5_2 = L3_2.event

      L6_2 = L3_2.data

      L4_2(L5_2, L6_2)

    else

      L4_2 = TriggerEvent

      L5_2 = L3_2.event

      L6_2 = L3_2.data

      L4_2(L5_2, L6_2)

    end

  end

  L4_2 = L3_2.remove

  if L4_2 then

    L4_2 = SendReactMessage

    L5_2 = "removeNotification"

    L6_2 = A0_2

    L4_2(L5_2, L6_2)

    L4_2 = L0_1

    L4_2[A0_2] = nil

  end

  L4_2 = type

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  if "number" == L4_2 then

    L4_2 = AwaitCallback

    L5_2 = "deleteNotification"

    L6_2 = A0_2

    L4_2(L5_2, L6_2)

  end

  L4_2 = true

  return L4_2

end

L5_1 = RegisterNUICallback

L6_1 = "Notifications"

function L7_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Notifications:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "getNotifications" == L2_2 then

    L3_2 = A1_2

    L4_2 = L1_1

    L4_2, L5_2, L6_2 = L4_2()

    return L3_2(L4_2, L5_2, L6_2)

  else

    if "deleteNotification" == L2_2 then

      L3_2 = A0_2.id

      if nil ~= L3_2 then

        L3_2 = A1_2

        L4_2 = L2_1

        L5_2 = A0_2.id

        L4_2, L5_2, L6_2 = L4_2(L5_2)

        return L3_2(L4_2, L5_2, L6_2)

    end

    elseif "clearNotifications" == L2_2 then

      L3_2 = A1_2

      L4_2 = L3_1

      L5_2 = A0_2.app

      L4_2, L5_2, L6_2 = L4_2(L5_2)

      return L3_2(L4_2, L5_2, L6_2)

    elseif "button" == L2_2 then

      L3_2 = A1_2

      L4_2 = L4_1

      L5_2 = A0_2.id

      L6_2 = A0_2.buttonId

      if not L6_2 then

        L6_2 = 0

      end

      L6_2 = L6_2 + 1

      L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2)

      return L3_2(L4_2, L5_2, L6_2)

    end

  end

end

L5_1(L6_1, L7_1)

L5_1 = RegisterNetEvent

L6_1 = "phone:sendNotification"

function L7_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = HasPhoneItem

  L2_2 = currentPhone

  L1_2 = L1_2(L2_2)

  if L1_2 then

    L1_2 = phoneDisabled

    if not L1_2 then

      goto lbl_13

    end

  end

  L1_2 = debugprint

  L2_2 = "no phone, not showing notification"

  L1_2(L2_2)

  do return end

  ::lbl_13::

  L1_2 = A0_2.id

  if not L1_2 then

    L1_2 = "client-notification-"

    L2_2 = math

    L2_2 = L2_2.random

    L2_2 = L2_2()

    L1_2 = L1_2 .. L2_2

    A0_2.id = L1_2

  end

  L1_2 = A0_2.content

  if nil == L1_2 then

    L1_2 = A0_2.title

    A0_2.content = L1_2

    A0_2.title = nil

  end

  L1_2 = A0_2.customData

  if L1_2 then

    L1_2 = A0_2.customData

    L1_2 = L1_2.buttons

    if L1_2 then

      L1_2 = A0_2.id

      if L1_2 then

        L1_2 = A0_2.customData

        L1_2 = L1_2.buttons

        A0_2.actions = L1_2

        L2_2 = A0_2.id

        L1_2 = L0_1

        L1_2[L2_2] = A0_2

      end

    end

    A0_2.customData = nil

  end

  L1_2 = SendReactMessage

  L2_2 = "newNotification"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = phoneOpen

  if not L1_2 then

    L1_2 = Config

    L1_2 = L1_2.NotificationsUpdateZIndex

    if L1_2 then

      L1_2 = SetNuiZindex

      if L1_2 then

        L1_2 = SetNuiZindex

        L2_2 = 99

        L1_2(L2_2)

      end

    end

  end

end

L5_1(L6_1, L7_1)

L5_1 = exports

L6_1 = "SendNotification"

function L7_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = "client-notification-"

  L2_2 = math

  L2_2 = L2_2.random

  L2_2 = L2_2()

  L1_2 = L1_2 .. L2_2

  A0_2.id = L1_2

  L1_2 = TriggerEvent

  L2_2 = "phone:sendNotification"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L5_1(L6_1, L7_1)

L5_1 = exports

L6_1 = "DeleteNotification"

L7_1 = L2_1

L5_1(L6_1, L7_1)
