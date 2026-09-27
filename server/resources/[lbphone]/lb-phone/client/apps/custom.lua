local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1

L0_1 = RegisterNUICallback

L1_1 = "CustomApp"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = A0_2.app

  L3_2 = A0_2.action

  L4_2 = A1_2

  L5_2 = "ok"

  L4_2(L5_2)

  if not L3_2 or not L2_2 then

    L4_2 = debugprint

    L5_2 = "invalid data"

    L4_2(L5_2)

    return

  end

  L4_2 = Config

  L4_2 = L4_2.CustomApps

  L4_2 = L4_2[L2_2]

  if "open" == L3_2 then

    L5_2 = L4_2 or L5_2

    if L4_2 then

      L5_2 = L4_2.onServerUse

    end

    if L5_2 then

      L5_2 = TriggerServerEvent

      L6_2 = "lb-phone:customApp"

      L7_2 = L2_2

      L5_2(L6_2, L7_2)

    end

    L5_2 = L4_2 or L5_2

    if L4_2 then

      L5_2 = L4_2.ui

    end

    if not L5_2 then

      L5_2 = L4_2 or L5_2

      if L4_2 then

        L5_2 = L4_2.keepOpen

      end

      if not L5_2 then

        L5_2 = debugprint

        L6_2 = "Closing phone due to custom app without ui"

        L5_2(L6_2)

        L5_2 = ToggleOpen

        L6_2 = false

        L5_2(L6_2)

      end

    end

    L5_2 = L4_2 or L5_2

    if L4_2 then

      L5_2 = L4_2.onUse

    end

    if L5_2 then

      L5_2 = Citizen

      L5_2 = L5_2.CreateThreadNow

      function L6_2()

        local L0_3, L1_3

        L0_3 = L4_2.onUse

        L0_3()

      end

      L5_2(L6_2)

    end

    L5_2 = L4_2 or L5_2

    if L4_2 then

      L5_2 = L4_2.onOpen

    end

    if L5_2 then

      L5_2 = Citizen

      L5_2 = L5_2.CreateThreadNow

      function L6_2()

        local L0_3, L1_3

        L0_3 = L4_2.onOpen

        L0_3()

      end

      L5_2(L6_2)

    end

  elseif "close" == L3_2 then

    L5_2 = L4_2 or L5_2

    if L4_2 then

      L5_2 = L4_2.onClose

    end

    if L5_2 then

      L5_2 = L4_2.onClose

      L5_2()

    end

  elseif "install" == L3_2 then

    L5_2 = L4_2 or L5_2

    if L4_2 then

      L5_2 = L4_2.onInstall

    end

    if L5_2 then

      L5_2 = L4_2.onInstall

      L5_2()

    end

  elseif "uninstall" == L3_2 then

    L5_2 = L4_2 or L5_2

    if L4_2 then

      L5_2 = L4_2.onDelete

    end

    if L5_2 then

      L5_2 = L4_2.onDelete

      L5_2()

    end

  end

end

L0_1(L1_1, L2_1)

L0_1 = {}

L1_1 = {}

L1_1.blue = true

L1_1.red = true

L1_1.green = true

L1_1.yellow = true

function L2_1()

  local L0_2, L1_2, L2_2

  L0_2 = math

  L0_2 = L0_2.random

  L1_2 = 999999999

  L0_2 = L0_2(L1_2)

  while true do

    L1_2 = L0_1

    L1_2 = L1_2[L0_2]

    if not L1_2 then

      break

    end

    L1_2 = math

    L1_2 = L1_2.random

    L2_2 = 999999999

    L1_2 = L1_2(L2_2)

    L0_2 = L1_2

  end

  return L0_2

end

L3_1 = RegisterNUICallback

L4_1 = "PopUp"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  if not L2_2 then

    return

  end

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  L2_2()

  L2_2 = L0_1

  L2_2[A0_2] = nil

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNUICallback

L4_1 = "PopUpInputChanged"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = A0_2.id

  L3_2 = A0_2.value

  L4_2 = L0_1

  L4_2 = L4_2[L2_2]

  if not L4_2 then

    return

  end

  L4_2 = A1_2

  L5_2 = "ok"

  L4_2(L5_2)

  L4_2 = L0_1

  L4_2 = L4_2[L2_2]

  L5_2 = L3_2

  L4_2(L5_2)

end

L3_1(L4_1, L5_1)

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L2_2 = assert

  L3_2 = A0_2.buttons

  if L3_2 then

    L3_2 = A0_2.buttons

    L3_2 = #L3_2

    L3_2 = L3_2 > 0

  end

  L4_2 = "You need at least one button"

  L2_2(L3_2, L4_2)

  L2_2 = pairs

  L3_2 = A0_2.buttons

  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)

  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do

    L8_2 = assert

    L9_2 = L7_2.title

    L10_2 = "You need a title for each button"

    L8_2(L9_2, L10_2)

    L8_2 = assert

    L9_2 = L7_2.color

    if not L9_2 then

      L9_2 = "blue"

    end

    L10_2 = L1_1

    L9_2 = L10_2[L9_2]

    L10_2 = "Invalid color"

    L8_2(L9_2, L10_2)

    if true == A1_2 then

      L8_2 = L7_2.cb

      if L8_2 then

        L8_2 = L2_1

        L8_2 = L8_2()

        L9_2 = L7_2.cb

        L10_2 = L0_1

        function L11_2()

          local L0_3, L1_3

          L0_3 = L9_2

          L1_3 = L7_2.callbackId

          L0_3(L1_3)

        end

        L10_2[L8_2] = L11_2

        L7_2.cb = L8_2

    end

    else

      L8_2 = L7_2.callbackId

      if L8_2 then

        L8_2 = L2_1

        L8_2 = L8_2()

        L9_2 = L0_1

        function L10_2()

          local L0_3, L1_3

          L0_3 = A1_2

          L1_3 = L7_2.callbackId

          L0_3(L1_3)

        end

        L9_2[L8_2] = L10_2

        L7_2.cb = L8_2

      end

    end

  end

  L2_2 = A0_2.input

  L3_2 = L2_2 or L3_2

  if L2_2 then

    L3_2 = L2_2.onChange

  end

  if L3_2 then

    L3_2 = L2_1

    L3_2 = L3_2()

    if true == A1_2 then

      L4_2 = L2_2.onChange

      L5_2 = L0_1

      L5_2[L3_2] = L4_2

    else

      L4_2 = L0_1

      function L5_2(A0_3)

        local L1_3, L2_3, L3_3, L4_3

        L1_3 = SendReactMessage

        L2_3 = "customApp:sendMessage"

        L3_3 = {}

        L3_3.identifier = "any"

        L4_3 = {}

        L4_3.type = "popUpInputChanged"

        L4_3.value = A0_3

        L3_3.message = L4_3

        L1_3(L2_3, L3_3)

      end

      L4_2[L3_2] = L5_2

    end

    L2_2.onChange = L3_2

  end

  L3_2 = SendReactMessage

  L4_2 = "onComponentUse"

  L5_2 = {}

  L5_2.type = "popup"

  L5_2.data = A0_2

  L3_2(L4_2, L5_2)

end

L4_1 = RegisterNUICallback

L5_1 = "SetPopUp"

L6_1 = L3_1

L4_1(L5_1, L6_1)

L4_1 = exports

L5_1 = "SetPopUp"

function L6_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = L3_1

  L2_2 = A0_2

  L3_2 = true

  L1_2(L2_2, L3_2)

end

L4_1(L5_1, L6_1)

L4_1 = RegisterNUICallback

L5_1 = "ContextMenu"

function L6_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  if not L2_2 then

    return

  end

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  L2_2()

  L2_2 = L0_1

  L2_2[A0_2] = nil

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L4_1(L5_1, L6_1)

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L2_2 = assert

  L3_2 = A0_2.buttons

  if L3_2 then

    L3_2 = A0_2.buttons

    L3_2 = #L3_2

    L3_2 = L3_2 > 0

  end

  L4_2 = "You need at least one button"

  L2_2(L3_2, L4_2)

  L2_2 = pairs

  L3_2 = A0_2.buttons

  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)

  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do

    L8_2 = assert

    L9_2 = L7_2.title

    L10_2 = "You need a title for each button"

    L8_2(L9_2, L10_2)

    L8_2 = assert

    L9_2 = L7_2.color

    if not L9_2 then

      L9_2 = "blue"

    end

    L10_2 = L1_1

    L9_2 = L10_2[L9_2]

    L10_2 = "Invalid colour"

    L8_2(L9_2, L10_2)

    if true == A1_2 then

      L8_2 = assert

      L9_2 = L7_2.cb

      L10_2 = "You need a callback for each button"

      L8_2(L9_2, L10_2)

    else

      L8_2 = assert

      L9_2 = L7_2.callbackId

      L10_2 = "You need a callback for each button"

      L8_2(L9_2, L10_2)

    end

    L8_2 = L2_1

    L8_2 = L8_2()

    L9_2 = L7_2.cb

    L10_2 = L0_1

    function L11_2()

      local L0_3, L1_3

      L0_3 = A1_2

      if true == L0_3 then

        L0_3 = L9_2

        L0_3()

      else

        L0_3 = A1_2

        L1_3 = L7_2.callbackId

        L0_3(L1_3)

      end

    end

    L10_2[L8_2] = L11_2

    L7_2.cb = L8_2

  end

  L2_2 = SendReactMessage

  L3_2 = "onComponentUse"

  L4_2 = {}

  L4_2.type = "contextmenu"

  L4_2.data = A0_2

  L2_2(L3_2, L4_2)

end

L5_1 = RegisterNUICallback

L6_1 = "SetContextMenu"

L7_1 = L4_1

L5_1(L6_1, L7_1)

L5_1 = exports

L6_1 = "SetContextMenu"

function L7_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = L4_1

  L2_2 = A0_2

  L3_2 = true

  L1_2(L2_2, L3_2)

end

L5_1(L6_1, L7_1)

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = type

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  if "table" ~= L2_2 or not A0_2 then

    L2_2 = {}

    A0_2 = L2_2

  end

  L2_2 = nil

  L3_2 = phoneOpen

  L4_2 = L2_1

  L4_2 = L4_2()

  A0_2.id = L4_2

  if not L3_2 then

    L5_2 = debugprint

    L6_2 = "Opening phone due to camera component"

    L5_2(L6_2)

    L5_2 = ToggleOpen

    L6_2 = true

    L5_2(L6_2)

  end

  if not A1_2 then

    L5_2 = promise

    L5_2 = L5_2.new

    L5_2 = L5_2()

    L2_2 = L5_2

  end

  L5_2 = L0_1

  function L6_2(A0_3)

    local L1_3, L2_3, L3_3

    L1_3 = A1_2

    if L1_3 then

      L1_3 = A1_2

      L2_3 = A0_3.url

      L1_3(L2_3)

    else

      L1_3 = L2_2

      L2_3 = L1_3

      L1_3 = L1_3.resolve

      L3_3 = A0_3.url

      L1_3(L2_3, L3_3)

    end

    L1_3 = L3_2

    if not L1_3 then

      L1_3 = debugprint

      L2_3 = "Closing phone due to camera component"

      L1_3(L2_3)

      L1_3 = ToggleOpen

      L2_3 = false

      L1_3(L2_3)

    end

  end

  L5_2[L4_2] = L6_2

  L5_2 = SendReactMessage

  L6_2 = "onComponentUse"

  L7_2 = {}

  L7_2.type = "camera"

  L7_2.data = A0_2

  L5_2(L6_2, L7_2)

  if not A1_2 then

    L5_2 = Citizen

    L5_2 = L5_2.Await

    L6_2 = L2_2

    return L5_2(L6_2)

  end

end

L6_1 = exports

L7_1 = "SetCameraComponent"

L8_1 = L5_1

L6_1(L7_1, L8_1)

function L6_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = assert

  L2_2 = A0_2

  L3_2 = "You need to provide a phone number"

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "onComponentUse"

  L3_2 = {}

  L3_2.type = "contactmodal"

  L3_2.data = A0_2

  L1_2(L2_2, L3_2)

end

L7_1 = RegisterNUICallback

L8_1 = "SetContactModal"

function L9_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = L6_1

  L3_2 = A0_2

  L2_2(L3_2)

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L7_1(L8_1, L9_1)

L7_1 = exports

L8_1 = "SetContactModal"

L9_1 = L6_1

L7_1(L8_1, L9_1)

L7_1 = {}

L8_1 = {}

L9_1 = "image"

L8_1[1] = L9_1

L7_1.gallery = L8_1

L8_1 = {}

L9_1 = "gif"

L8_1[1] = L9_1

L7_1.gif = L8_1

L8_1 = {}

L9_1 = "emoji"

L8_1[1] = L9_1

L7_1.emoji = L8_1

L8_1 = {}

L9_1 = "url"

L8_1[1] = L9_1

L7_1.camera = L8_1

L8_1 = {}

L9_1 = "color"

L8_1[1] = L9_1

L7_1.colorpicker = L8_1

L8_1 = {}

L9_1 = "contact"

L8_1[1] = L9_1

L7_1.contactselector = L8_1

L8_1 = RegisterNUICallback

L9_1 = "UsedComponent"

function L10_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = A0_2 or nil

  if A0_2 then

    L2_2 = A0_2.id

  end

  if L2_2 then

    L3_2 = L0_1

    L3_2 = L3_2[L2_2]

    if L3_2 then

      goto lbl_11

    end

  end

  do return end

  ::lbl_11::

  L3_2 = L0_1

  L3_2 = L3_2[L2_2]

  L4_2 = A0_2

  L3_2(L4_2)

  L3_2 = L0_1

  L3_2[L2_2] = nil

  L3_2 = A1_2

  L4_2 = "ok"

  L3_2(L4_2)

end

L8_1(L9_1, L10_1)

function L8_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = A0_2.component

  L3_2 = assert

  L4_2 = L2_2

  L5_2 = "You need to specify a component"

  L3_2(L4_2, L5_2)

  L3_2 = assert

  L4_2 = L7_1

  L4_2 = L4_2[L2_2]

  L5_2 = "Invalid component"

  L3_2(L4_2, L5_2)

  L3_2 = L2_1

  L3_2 = L3_2()

  L4_2 = L0_1

  function L5_2(A0_3)

    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3

    L1_3 = {}

    L2_3 = pairs

    L4_3 = L2_2

    L3_3 = L7_1

    L3_3 = L3_3[L4_3]

    L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)

    for L6_3, L7_3 in L2_3, L3_3, L4_3, L5_3 do

      L8_3 = #L1_3

      L8_3 = L8_3 + 1

      L9_3 = A0_3[L7_3]

      L1_3[L8_3] = L9_3

    end

    L2_3 = A1_2

    L3_3 = table

    L3_3 = L3_3.unpack

    L4_3 = L1_3

    L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L3_3(L4_3)

    L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)

  end

  L4_2[L3_2] = L5_2

  A0_2.id = L3_2

  L4_2 = SendReactMessage

  L5_2 = "onComponentUse"

  L6_2 = {}

  L6_2.type = L2_2

  L6_2.data = A0_2

  L4_2(L5_2, L6_2)

end

L9_1 = RegisterNUICallback

L10_1 = "ShowComponent"

L11_1 = L8_1

L9_1(L10_1, L11_1)

L9_1 = exports

L10_1 = "ShowComponent"

L11_1 = L8_1

L9_1(L10_1, L11_1)

L9_1 = RegisterNUICallback

L10_1 = "CreateCall"

function L11_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = CreateCall

  L3_2 = A0_2

  L2_2(L3_2)

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L9_1(L10_1, L11_1)

L9_1 = RegisterNUICallback

L10_1 = "GetSettings"

function L11_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = A1_2

  L3_2 = settings

  L2_2(L3_2)

end

L9_1(L10_1, L11_1)

L9_1 = RegisterNUICallback

L10_1 = "GetLocale"

function L11_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = A1_2

  L3_2 = L

  L4_2 = A0_2.path

  L5_2 = A0_2.format

  L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)

  L2_2(L3_2, L4_2, L5_2)

end

L9_1(L10_1, L11_1)

L9_1 = RegisterNUICallback

L10_1 = "SendNotification"

function L11_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  if A0_2 then

    L2_2 = A0_2.customData

    if L2_2 then

      L2_2 = A0_2.customData

      L2_2 = L2_2.buttons

      if L2_2 then

        L2_2 = A0_2.customData

        L2_2.buttons = nil

        L2_2 = debugprint

        L3_2 = "You cannot create notifications with buttons from the NUI."

        L2_2(L3_2)

      end

    end

  end

  L2_2 = TriggerEvent

  L3_2 = "phone:sendNotification"

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

  L2_2 = A1_2

  L3_2 = true

  L2_2(L3_2)

end

L9_1(L10_1, L11_1)