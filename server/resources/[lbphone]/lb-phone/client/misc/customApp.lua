local L0_1, L1_1, L2_1

function L0_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = {}

  L2_2 = A0_2.identifier

  L1_2.identifier = L2_2

  L2_2 = A0_2.resourceName

  L1_2.resourceName = L2_2

  L1_2.custom = true

  L2_2 = A0_2.name

  L1_2.name = L2_2

  L2_2 = A0_2.icon

  L1_2.icon = L2_2

  L2_2 = A0_2.description

  L1_2.description = L2_2

  L2_2 = A0_2.images

  L1_2.images = L2_2

  L2_2 = A0_2.developer

  L1_2.developer = L2_2

  L2_2 = A0_2.size

  if not L2_2 then

    L2_2 = 42000

  end

  L1_2.size = L2_2

  L2_2 = A0_2.price

  L1_2.price = L2_2

  L2_2 = A0_2.game

  L1_2.game = L2_2

  L2_2 = A0_2.landscape

  if not L2_2 then

    L2_2 = false

  end

  L1_2.landscape = L2_2

  L2_2 = A0_2.defaultApp

  L2_2 = not L2_2

  L1_2.removable = L2_2

  L2_2 = A0_2.disableInAppNotifications

  L1_2.disableInAppNotifications = L2_2

  L2_2 = A0_2.ui

  L1_2.ui = L2_2

  L2_2 = A0_2.fixBlur

  L1_2.fixBlur = L2_2

  L2_2 = HasAccessToApp

  L3_2 = A0_2.identifier

  L2_2 = L2_2(L3_2)

  L1_2.access = L2_2

  return L1_2

end

FormatCustomAppDataForUI = L0_1

L0_1 = exports

L1_1 = "SendCustomAppMessage"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L2_2 = GetInvokingResource

  L2_2 = L2_2()

  if not A0_2 then

    L3_2 = infoprint

    L4_2 = "error"

    L5_2 = "SendCustomAppMessage: No identifier provided by resource "

    L6_2 = L2_2

    L5_2 = L5_2 .. L6_2

    L3_2(L4_2, L5_2)

    L3_2 = false

    L4_2 = "No identifier provided"

    return L3_2, L4_2

  end

  L3_2 = Config

  L3_2 = L3_2.CustomApps

  L3_2 = L3_2[A0_2]

  if not L3_2 then

    L3_2 = infoprint

    L4_2 = "error"

    L5_2 = "SendCustomAppMessage: App "

    L6_2 = A0_2

    L7_2 = " does not exist. Triggered by: "

    L8_2 = L2_2

    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2

    L3_2(L4_2, L5_2)

    L3_2 = false

    L4_2 = "App does not exist"

    return L3_2, L4_2

  end

  L3_2 = Config

  L3_2 = L3_2.CustomApps

  L3_2 = L3_2[A0_2]

  L3_2 = L3_2.resourceName

  if L3_2 ~= L2_2 then

    L3_2 = infoprint

    L4_2 = "error"

    L5_2 = "SendCustomAppMessage: App "

    L6_2 = A0_2

    L7_2 = " was not created by "

    L8_2 = L2_2

    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2

    L3_2(L4_2, L5_2)

    L3_2 = false

    L4_2 = "App was not created by "

    L5_2 = L2_2

    L4_2 = L4_2 .. L5_2

    return L3_2, L4_2

  end

  L3_2 = SendReactMessage

  L4_2 = "customApp:sendMessage"

  L5_2 = {}

  L5_2.identifier = A0_2

  L5_2.message = A1_2

  L3_2(L4_2, L5_2)

  L3_2 = true

  return L3_2

end

L0_1(L1_1, L2_1)

L0_1 = exports

L1_1 = "AddCustomApp"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = GetInvokingResource

  L1_2 = L1_2()

  L2_2 = A0_2 or L2_2

  if A0_2 then

    L2_2 = A0_2.identifier

  end

  if not L2_2 then

    L2_2 = false

    L3_2 = "No identifier provided"

    return L2_2, L3_2

  end

  L2_2 = A0_2 or L2_2

  if A0_2 then

    L2_2 = A0_2.name

  end

  if not L2_2 then

    L2_2 = false

    L3_2 = "No name provided"

    return L2_2, L3_2

  end

  L2_2 = A0_2 or L2_2

  if A0_2 then

    L2_2 = A0_2.description

  end

  if not L2_2 then

    L2_2 = false

    L3_2 = "No description provided"

    return L2_2, L3_2

  end

  L2_2 = Config

  L2_2 = L2_2.CustomApps

  L3_2 = A0_2.identifier

  L2_2 = L2_2[L3_2]

  if L2_2 then

    L2_2 = false

    L3_2 = "App already exists"

    return L2_2, L3_2

  end

  L2_2 = Config

  L2_2 = L2_2.CustomApps

  L3_2 = A0_2.identifier

  L4_2 = {}

  L5_2 = A0_2.identifier

  L4_2.identifier = L5_2

  L4_2.resourceName = L1_2

  L4_2.custom = true

  L5_2 = A0_2.name

  L4_2.name = L5_2

  L5_2 = A0_2.icon

  L4_2.icon = L5_2

  L5_2 = A0_2.description

  L4_2.description = L5_2

  L5_2 = A0_2.images

  L4_2.images = L5_2

  L5_2 = A0_2.developer

  L4_2.developer = L5_2

  L5_2 = A0_2.size

  if not L5_2 then

    L5_2 = 42000

  end

  L4_2.size = L5_2

  L5_2 = A0_2.price

  L4_2.price = L5_2

  L5_2 = A0_2.game

  L4_2.game = L5_2

  L5_2 = A0_2.landscape

  if not L5_2 then

    L5_2 = false

  end

  L4_2.landscape = L5_2

  L5_2 = A0_2.defaultApp

  L5_2 = not L5_2

  L4_2.removable = L5_2

  L5_2 = A0_2.defaultApp

  L4_2.defaultApp = L5_2

  L5_2 = A0_2.disableInAppNotifications

  L4_2.disableInAppNotifications = L5_2

  L5_2 = A0_2.ui

  L4_2.ui = L5_2

  L5_2 = A0_2.fixBlur

  L4_2.fixBlur = L5_2

  L5_2 = A0_2.onOpen

  L4_2.onOpen = L5_2

  L5_2 = A0_2.onClose

  L4_2.onClose = L5_2

  L5_2 = A0_2.onUse

  L4_2.onUse = L5_2

  L5_2 = A0_2.onDelete

  L4_2.onDelete = L5_2

  L5_2 = A0_2.onInstall

  L4_2.onInstall = L5_2

  L2_2[L3_2] = L4_2

  L2_2 = debugprint

  L3_2 = "adding custom app"

  L4_2 = A0_2.identifier

  L2_2(L3_2, L4_2)

  L2_2 = SendReactMessage

  L3_2 = "addCustomApp"

  L4_2 = FormatCustomAppDataForUI

  L5_2 = Config

  L5_2 = L5_2.CustomApps

  L6_2 = A0_2.identifier

  L5_2 = L5_2[L6_2]

  L4_2, L5_2, L6_2 = L4_2(L5_2)

  L2_2(L3_2, L4_2, L5_2, L6_2)

  L2_2 = true

  return L2_2

end

L0_1(L1_1, L2_1)

L0_1 = exports

L1_1 = "RemoveCustomApp"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = GetInvokingResource

  L1_2 = L1_2()

  if not A0_2 then

    L2_2 = false

    L3_2 = "No identifier provided"

    return L2_2, L3_2

  end

  L2_2 = Config

  L2_2 = L2_2.CustomApps

  L2_2 = L2_2[A0_2]

  if not L2_2 then

    L2_2 = false

    L3_2 = "App does not exist"

    return L2_2, L3_2

  end

  L2_2 = Config

  L2_2 = L2_2.CustomApps

  L2_2 = L2_2[A0_2]

  L2_2 = L2_2.resourceName

  if L2_2 ~= L1_2 then

    L2_2 = false

    L3_2 = "App was not created by "

    L4_2 = L1_2

    L3_2 = L3_2 .. L4_2

    return L2_2, L3_2

  end

  L2_2 = Config

  L2_2 = L2_2.CustomApps

  L2_2[A0_2] = nil

  L2_2 = SendReactMessage

  L3_2 = "removeCustomApp"

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

  L2_2 = true

  return L2_2

end

L0_1(L1_1, L2_1)

L0_1 = AddEventHandler

L1_1 = "onResourceStop"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L1_2 = pairs

  L2_2 = Config

  L2_2 = L2_2.CustomApps

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = L6_2.resourceName

    if L7_2 == A0_2 then

      L7_2 = Config

      L7_2 = L7_2.CustomApps

      L7_2[L5_2] = nil

      L7_2 = SendReactMessage

      L8_2 = "removeCustomApp"

      L9_2 = L5_2

      L7_2(L8_2, L9_2)

      L7_2 = debugprint

      L8_2 = "Removed app "

      L9_2 = L5_2

      L10_2 = " due to resource stopping"

      L8_2 = L8_2 .. L9_2 .. L10_2

      L7_2(L8_2)

    end

  end

end

L0_1(L1_1, L2_1)
