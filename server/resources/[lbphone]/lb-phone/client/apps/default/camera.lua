local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1

cameraOpen = false

L0_1 = false

L1_1 = false

L2_1 = false

L3_1 = nil

L4_1 = nil

L5_1 = {}

L5_1.selfies = "selfie"

L5_1.screenshots = "screenshot"

L5_1.imports = "import"

function L6_1()

  local L0_2, L1_2

  L0_2 = L4_1

  if not L0_2 then

    L0_2 = AwaitCallback

    L1_2 = "camera:getBaseUrl"

    L0_2 = L0_2(L1_2)

  end

  L4_1 = L0_2

  L0_2 = L4_1

  return L0_2

end

GetBaseUrl = L6_1

function L6_1()

  local L0_2, L1_2, L2_2

  L0_2 = CreateMobilePhone

  L1_2 = 0

  L0_2(L1_2)

  L0_2 = CellCamActivate

  L1_2 = true

  L2_2 = true

  L0_2(L1_2, L2_2)

  L0_2 = CellCamActivateSelfieMode

  L1_2 = L0_1

  L0_2(L1_2)

  L0_2 = SetTimeout

  L1_2 = 500

  function L2_2()

    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3

    L0_3 = GetGamePool

    L1_3 = "CObject"

    L0_3 = L0_3(L1_3)

    L1_3 = GetEntityCoords

    L2_3 = PlayerPedId

    L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3 = L2_3()

    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)

    L2_3 = 1

    L3_3 = #L0_3

    L4_3 = 1

    for L5_3 = L2_3, L3_3, L4_3 do

      L6_3 = L0_3[L5_3]

      L7_3 = GetEntityCoords

      L8_3 = L6_3

      L7_3 = L7_3(L8_3)

      L7_3 = L1_3 - L7_3

      L7_3 = #L7_3

      if L7_3 < 4.0 then

        L7_3 = GetEntityModel

        L8_3 = L6_3

        L7_3 = L7_3(L8_3)

        if 413312110 == L7_3 then

          L7_3 = SetEntityAsMissionEntity

          L8_3 = L6_3

          L9_3 = true

          L10_3 = true

          L7_3(L8_3, L9_3, L10_3)

          L7_3 = DeleteObject

          L8_3 = L6_3

          L7_3(L8_3)

        end

      end

    end

  end

  L0_2(L1_2, L2_2)

  while true do

    L0_2 = phoneOpen

    if not L0_2 then

      break

    end

    L0_2 = cameraOpen

    if not L0_2 then

      break

    end

    L0_2 = IsWalkingCamEnabled

    L0_2 = L0_2()

    if L0_2 then

      break

    end

    L0_2 = Wait

    L1_2 = 250

    L0_2(L1_2)

    L0_2 = InvalidateIdleCam

    L0_2()

    L0_2 = InvalidateVehicleIdleCam

    L0_2()

  end

  L0_2 = DestroyMobilePhone

  L0_2()

  L0_2 = cameraOpen

  if L0_2 then

    L0_2 = IsWalkingCamEnabled

    L0_2 = L0_2()

    if not L0_2 then

      while true do

        L0_2 = phoneOpen

        if L0_2 then

          break

        end

        L0_2 = Wait

        L1_2 = 500

        L0_2(L1_2)

      end

      L0_2 = L6_1

      L0_2()

    end

  end

end

function L7_1(A0_2)

  local L1_2, L2_2

  L1_2 = A0_2.album

  if "recents" == L1_2 then

    A0_2.album = nil

  else

    L1_2 = A0_2.album

    if "favourites" == L1_2 then

      A0_2.album = nil

      A0_2.favourites = true

    end

  end

  L1_2 = A0_2.type

  if "videos" == L1_2 then

    L1_2 = {}

    L1_2.showPhotos = false

    L1_2.showVideos = true

    A0_2 = L1_2

  end

  L1_2 = A0_2.type

  if L1_2 then

    A0_2.album = nil

    L2_2 = A0_2.type

    L1_2 = L5_1

    L1_2 = L1_2[L2_2]

    if L1_2 then

      L2_2 = A0_2.type

      L1_2 = L5_1

      L1_2 = L1_2[L2_2]

      A0_2.type = L1_2

    else

      A0_2.type = nil

      A0_2.duplicates = true

    end

  end

  L1_2 = A0_2.showPhotos

  if not L1_2 then

    L1_2 = A0_2.showVideos

    if not L1_2 then

      A0_2.showPhotos = true

      A0_2.showVideos = true

    end

  end

  return A0_2

end

function L8_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2

  L1_2 = nil

  L2_2 = CustomGetUploadMethod

  if L2_2 then

    L2_2 = CustomGetUploadMethod

    L3_2 = A0_2

    L2_2 = L2_2(L3_2)

    L1_2 = L2_2

  else

    L2_2 = UploadMethods

    if not L2_2 then

      L2_2 = infoprint

      L3_2 = "error"

      L4_2 = "Upload methods not found"

      L2_2(L3_2, L4_2)

      L2_2 = "No upload methods found. The server devs have broken the upload.lua file. Tell the server devs to reinstall lb-phone."

      return L2_2

    end

    L2_2 = UploadMethods

    L3_2 = Config

    L3_2 = L3_2.UploadMethod

    L3_2 = L3_2[A0_2]

    L2_2 = L2_2[L3_2]

    if not L2_2 then

      L3_2 = infoprint

      L4_2 = "error"

      L5_2 = "Upload methods not found for "

      L6_2 = A0_2

      L3_2(L4_2, L5_2, L6_2)

      L3_2 = "No upload methods found for '"

      L4_2 = tostring

      L5_2 = Config

      L5_2 = L5_2.UploadMethod

      L5_2 = L5_2[A0_2]

      L4_2 = L4_2(L5_2)

      L5_2 = "'. Tell the server devs to reinstall lb-phone."

      L3_2 = L3_2 .. L4_2 .. L5_2

      return L3_2

    end

    L3_2 = L2_2[A0_2]

    L1_2 = L3_2 or L1_2

    if not L3_2 then

      L1_2 = L2_2.Default

    end

    if not L1_2 then

      L3_2 = infoprint

      L4_2 = "error"

      L5_2 = "Upload method not found for "

      L6_2 = A0_2

      L3_2(L4_2, L5_2, L6_2)

      L3_2 = "No upload method found for '"

      L4_2 = A0_2

      L5_2 = "' using '"

      L6_2 = tostring

      L7_2 = Config

      L7_2 = L7_2.UploadMethod

      L7_2 = L7_2[A0_2]

      L6_2 = L6_2(L7_2)

      L7_2 = "'. Tell the server devs to reinstall lb-phone."

      L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2

      return L3_2

    end

  end

  L2_2 = L1_2.method

  if not L2_2 then

    L2_2 = Config

    L2_2 = L2_2.UploadMethod

    L2_2 = L2_2[A0_2]

    L1_2.method = L2_2

  end

  L2_2 = L1_2.sendPlayer

  if L2_2 then

    L2_2 = L1_2.player

    if not L2_2 then

      L2_2 = {}

      L3_2 = GetIdentifier

      L3_2 = L3_2()

      L2_2.identifier = L3_2

      L3_2 = GetPlayerName

      L4_2 = PlayerId

      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L4_2()

      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)

      L2_2.name = L3_2

      L1_2.player = L2_2

    end

  end

  L2_2 = L1_2.url

  L3_2 = L2_2

  L2_2 = L2_2.find

  L4_2 = "BASE_URL"

  L2_2 = L2_2(L3_2, L4_2)

  if L2_2 then

    L2_2 = L1_2.url

    L3_2 = L2_2

    L2_2 = L2_2.gsub

    L4_2 = "BASE_URL"

    L5_2 = GetBaseUrl

    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L5_2()

    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)

    L1_2.url = L2_2

  end

  L2_2 = false

  L3_2 = L1_2.url

  L4_2 = L3_2

  L3_2 = L3_2.find

  L5_2 = "API_KEY"

  L3_2 = L3_2(L4_2, L5_2)

  if L3_2 then

    L2_2 = true

  else

    L3_2 = L1_2.headers

    if L3_2 then

      L3_2 = pairs

      L4_2 = L1_2.headers

      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)

      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do

        L10_2 = L8_2

        L9_2 = L8_2.find

        L11_2 = "API_KEY"

        L9_2 = L9_2(L10_2, L11_2)

        if L9_2 then

          L2_2 = true

          break

        end

      end

    end

  end

  if L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "camera:getUploadApiKey"

    L5_2 = A0_2

    L3_2 = L3_2(L4_2, L5_2)

    L4_2 = L1_2.url

    L5_2 = L4_2

    L4_2 = L4_2.gsub

    L6_2 = "API_KEY"

    L7_2 = L3_2

    L4_2 = L4_2(L5_2, L6_2, L7_2)

    L1_2.url = L4_2

    L4_2 = L1_2.headers

    if L4_2 then

      L4_2 = pairs

      L5_2 = L1_2.headers

      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)

      for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do

        L10_2 = L1_2.headers

        L12_2 = L9_2

        L11_2 = L9_2.gsub

        L13_2 = "API_KEY"

        L14_2 = L3_2

        L11_2 = L11_2(L12_2, L13_2, L14_2)

        L10_2[L8_2] = L11_2

      end

    end

  end

  L3_2 = L1_2.url

  L4_2 = L3_2

  L3_2 = L3_2.find

  L5_2 = "PRESIGNED_URL"

  L3_2 = L3_2(L4_2, L5_2)

  if L3_2 then

    L3_2 = AwaitCallback

    L4_2 = "camera:getPresignedUrl"

    L5_2 = A0_2

    L3_2 = L3_2(L4_2, L5_2)

    if not L3_2 then

      L4_2 = infoprint

      L5_2 = "error"

      L6_2 = "Failed to get presigned url for "

      L7_2 = A0_2

      L6_2 = L6_2 .. L7_2

      L4_2(L5_2, L6_2)

      L4_2 = "Failed to get presigned url for '"

      L5_2 = A0_2

      L6_2 = "'. The devs have most likely not set a valid token in lb-phone/server/apiKeys.lua. Tell the server devs to check the console for errors."

      L4_2 = L4_2 .. L5_2 .. L6_2

      return L4_2

    end

    L4_2 = L1_2.url

    L5_2 = L4_2

    L4_2 = L4_2.gsub

    L6_2 = "PRESIGNED_URL"

    L7_2 = L3_2

    L4_2 = L4_2(L5_2, L6_2, L7_2)

    L1_2.presignedUrl = L4_2

  end

  return L1_2

end

function L9_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2

  L0_2 = {}

  L1_2 = Config

  L1_2 = L1_2.KeyBinds

  L1_2 = L1_2.TakePhoto

  if L1_2 then

    L1_2 = L1_2.Command

  end

  if L1_2 then

    L1_2 = #L0_2

    L1_2 = L1_2 + 1

    L2_2 = L

    L3_2 = "BACKEND.CAMERA.TAKE_PHOTO"

    L4_2 = {}

    L5_2 = Config

    L5_2 = L5_2.KeyBinds

    L5_2 = L5_2.TakePhoto

    L5_2 = L5_2.bindData

    L5_2 = L5_2.instructional

    L4_2.key = L5_2

    L2_2 = L2_2(L3_2, L4_2)

    L0_2[L1_2] = L2_2

  end

  L1_2 = Config

  L1_2 = L1_2.KeyBinds

  L1_2 = L1_2.FlipCamera

  if L1_2 then

    L1_2 = L1_2.Command

  end

  if L1_2 then

    L1_2 = #L0_2

    L1_2 = L1_2 + 1

    L2_2 = L

    L3_2 = "BACKEND.CAMERA.FLIP_CAMERA"

    L4_2 = {}

    L5_2 = Config

    L5_2 = L5_2.KeyBinds

    L5_2 = L5_2.FlipCamera

    L5_2 = L5_2.bindData

    L5_2 = L5_2.instructional

    L4_2.key = L5_2

    L2_2 = L2_2(L3_2, L4_2)

    L0_2[L1_2] = L2_2

  end

  L1_2 = Config

  L1_2 = L1_2.KeyBinds

  L1_2 = L1_2.ToggleFlash

  if L1_2 then

    L1_2 = L1_2.Command

  end

  if L1_2 then

    L1_2 = #L0_2

    L1_2 = L1_2 + 1

    L2_2 = L

    L3_2 = "BACKEND.CAMERA.TOGGLE_FLASH"

    L4_2 = {}

    L5_2 = Config

    L5_2 = L5_2.KeyBinds

    L5_2 = L5_2.ToggleFlash

    L5_2 = L5_2.bindData

    L5_2 = L5_2.instructional

    L4_2.key = L5_2

    L2_2 = L2_2(L3_2, L4_2)

    L0_2[L1_2] = L2_2

  end

  L1_2 = Config

  L1_2 = L1_2.KeyBinds

  L1_2 = L1_2.LeftMode

  if L1_2 then

    L1_2 = L1_2.Command

  end

  if L1_2 then

    L1_2 = Config

    L1_2 = L1_2.KeyBinds

    L1_2 = L1_2.RightMode

    if L1_2 then

      L1_2 = L1_2.Command

    end

    if L1_2 then

      L1_2 = #L0_2

      L1_2 = L1_2 + 1

      L2_2 = L

      L3_2 = "BACKEND.CAMERA.CHANGE_MODE"

      L4_2 = {}

      L5_2 = Config

      L5_2 = L5_2.KeyBinds

      L5_2 = L5_2.LeftMode

      L5_2 = L5_2.bindData

      L5_2 = L5_2.instructional

      L4_2.key = L5_2

      L5_2 = Config

      L5_2 = L5_2.KeyBinds

      L5_2 = L5_2.RightMode

      L5_2 = L5_2.bindData

      L5_2 = L5_2.instructional

      L4_2.key2 = L5_2

      L2_2 = L2_2(L3_2, L4_2)

      L0_2[L1_2] = L2_2

    end

  end

  L1_2 = Config

  L1_2 = L1_2.KeyBinds

  L1_2 = L1_2.RollLeft

  if L1_2 then

    L1_2 = L1_2.Command

  end

  if L1_2 then

    L1_2 = Config

    L1_2 = L1_2.KeyBinds

    L1_2 = L1_2.RollRight

    if L1_2 then

      L1_2 = L1_2.Command

    end

    if L1_2 then

      L1_2 = #L0_2

      L1_2 = L1_2 + 1

      L2_2 = L

      L3_2 = "BACKEND.CAMERA.ROLL"

      L4_2 = {}

      L5_2 = Config

      L5_2 = L5_2.KeyBinds

      L5_2 = L5_2.RollLeft

      L5_2 = L5_2.bindData

      L5_2 = L5_2.instructional

      L4_2.key = L5_2

      L5_2 = Config

      L5_2 = L5_2.KeyBinds

      L5_2 = L5_2.RollRight

      L5_2 = L5_2.bindData

      L5_2 = L5_2.instructional

      L4_2.key2 = L5_2

      L2_2 = L2_2(L3_2, L4_2)

      L0_2[L1_2] = L2_2

    end

  end

  L1_2 = Config

  L1_2 = L1_2.Camera

  if L1_2 then

    L1_2 = L1_2.Freeze

    if L1_2 then

      L1_2 = L1_2.Enabled

    end

  end

  if L1_2 then

    L1_2 = Config

    L1_2 = L1_2.KeyBinds

    L1_2 = L1_2.FreezeCamera

    if L1_2 then

      L1_2 = L1_2.Command

    end

    if L1_2 then

      L1_2 = #L0_2

      L1_2 = L1_2 + 1

      L2_2 = L

      L3_2 = "BACKEND.CAMERA.FREEZE"

      L4_2 = {}

      L5_2 = Config

      L5_2 = L5_2.KeyBinds

      L5_2 = L5_2.FreezeCamera

      L5_2 = L5_2.bindData

      L5_2 = L5_2.instructional

      L4_2.key = L5_2

      L2_2 = L2_2(L3_2, L4_2)

      L0_2[L1_2] = L2_2

    end

  end

  L1_2 = Config

  L1_2 = L1_2.KeyBinds

  L1_2 = L1_2.Focus

  if L1_2 then

    L1_2 = L1_2.Command

  end

  if L1_2 then

    L1_2 = #L0_2

    L1_2 = L1_2 + 1

    L2_2 = L

    L3_2 = "BACKEND.CAMERA.TOGGLE_CURSOR"

    L4_2 = {}

    L5_2 = Config

    L5_2 = L5_2.KeyBinds

    L5_2 = L5_2.Focus

    L5_2 = L5_2.bindData

    L5_2 = L5_2.instructional

    L4_2.key = L5_2

    L2_2 = L2_2(L3_2, L4_2)

    L0_2[L1_2] = L2_2

  end

  return L0_2

end

L10_1 = RegisterNUICallback

L11_1 = "Camera"

function L12_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  if not A0_2 then

    L2_2 = debugprint

    L3_2 = "Camera data is nil"

    return L2_2(L3_2)

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Camera:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "open" == L2_2 then

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

    cameraOpen = true

    L3_2 = DisplayCameraButtons

    L4_2 = L9_1

    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L4_2()

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)

    L3_2 = Config

    L3_2 = L3_2.Camera

    if L3_2 then

      L3_2 = L3_2.Enabled

    end

    if L3_2 then

      L3_2 = EnableWalkableCam

      L3_2()

    else

      L3_2 = L6_1

      L3_2()

    end

  elseif "saveToGallery" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:saveToGallery"

    L5_2 = A1_2

    L6_2 = A0_2.link

    L7_2 = A0_2.size

    L8_2 = A0_2.isVideo

    if L8_2 then

      L8_2 = true

      if L8_2 then

        goto lbl_56

      end

    end

    L8_2 = false

    ::lbl_56::

    L9_2 = A0_2.type

    L10_2 = A0_2.shouldLog

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)

  elseif "deleteFromGallery" == L2_2 then

    L3_2 = type

    L4_2 = A0_2.ids

    L3_2 = L3_2(L4_2)

    if "table" ~= L3_2 then

      L3_2 = {}

      L4_2 = A0_2.ids

      L3_2[1] = L4_2

      A0_2.ids = L3_2

    end

    L3_2 = TriggerCallback

    L4_2 = "camera:deleteFromGallery"

    L5_2 = A1_2

    L6_2 = A0_2.ids

    L3_2(L4_2, L5_2, L6_2)

  elseif "getLastImage" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:getLastImage"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getImages" == L2_2 then

    L3_2 = L7_1

    L4_2 = A0_2.filter

    if not L4_2 then

      L4_2 = {}

    end

    L3_2 = L3_2(L4_2)

    L4_2 = AwaitCallback

    L5_2 = "camera:getImages"

    L6_2 = L3_2

    L7_2 = A0_2.page

    if not L7_2 then

      L7_2 = 0

    end

    L4_2 = L4_2(L5_2, L6_2, L7_2)

    L5_2 = {}

    L6_2 = 1

    L7_2 = #L4_2

    L8_2 = 1

    for L9_2 = L6_2, L7_2, L8_2 do

      L10_2 = L4_2[L9_2]

      L11_2 = {}

      L12_2 = L10_2.id

      L11_2.id = L12_2

      L12_2 = L10_2.link

      L11_2.src = L12_2

      L12_2 = L10_2.is_video

      L11_2.isVideo = L12_2

      L12_2 = L10_2.metadata

      L11_2.type = L12_2

      L12_2 = L10_2.is_favourite

      L11_2.favourite = L12_2

      L12_2 = L10_2.timestamp

      L11_2.timestamp = L12_2

      L12_2 = L10_2.size

      if not L12_2 then

        L12_2 = 0

      end

      L11_2.size = L12_2

      L5_2[L9_2] = L11_2

    end

    L6_2 = A1_2

    L7_2 = L5_2

    L6_2(L7_2)

  elseif "getAlbums" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:getHomePageData"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "createAlbum" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:createAlbum"

    L5_2 = A1_2

    L6_2 = A0_2.title

    L3_2(L4_2, L5_2, L6_2)

  elseif "renameAlbum" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:renameAlbum"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.title

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "addToAlbum" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:addToAlbum"

    L5_2 = A1_2

    L6_2 = A0_2.album

    L7_2 = A0_2.ids

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "removeFromAlbum" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:removeFromAlbum"

    L5_2 = A1_2

    L6_2 = A0_2.album

    L7_2 = A0_2.ids

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "deleteAlbum" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:deleteAlbum"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "removeMemberFromAlbum" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:removeMemberFromAlbum"

    L5_2 = A1_2

    L6_2 = A0_2.number

    L7_2 = A0_2.album

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "leaveSharedAlbum" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:leaveSharedAlbum"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "getAlbumMembers" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:getAlbumMembers"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "toggleFavourites" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "camera:toggleFavourites"

    L5_2 = A1_2

    L6_2 = A0_2.favourite

    L7_2 = A0_2.ids

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "toggleVideo" == L2_2 then

    L3_2 = L1_1

    L4_2 = A0_2.toggled

    if L3_2 == L4_2 then

      L3_2 = A1_2

      L4_2 = "ok"

      return L3_2(L4_2)

    end

    L3_2 = A0_2.toggled

    L1_1 = L3_2

    cameraOpen = true

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

    L3_2 = SendReactMessage

    L4_2 = "camera:toggleMicrophone"

    L5_2 = IsTalking

    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L5_2()

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)

    L3_2 = L1_1

    if not L3_2 then

      L3_2 = Config

      L3_2 = L3_2.Camera

      if L3_2 then

        L3_2 = L3_2.Enabled

      end

      if not L3_2 then

        goto lbl_253

      end

    end

    L3_2 = EnableWalkableCam

    L4_2 = L0_1

    L3_2(L4_2)

    goto lbl_442

    ::lbl_253::

    L3_2 = DisableWalkableCam

    L3_2()

    L3_2 = L6_1

    L3_2()

  elseif "toggleHud" == L2_2 then

    L3_2 = A0_2.toggled

    L3_2 = not L3_2

    L2_1 = L3_2

    L3_2 = TriggerEvent

    L4_2 = "lb-phone:toggleHud"

    L5_2 = L2_1

    L3_2(L4_2, L5_2)

    L3_2 = ToggleHudComponents

    L4_2 = A0_2.toggled

    L4_2 = not L4_2

    L3_2(L4_2)

    L3_2 = Wait

    L4_2 = 100

    L3_2(L4_2)

    L3_2 = A1_2

    L4_2 = true

    L3_2(L4_2)

  elseif "getUploadApi" == L2_2 then

    L3_2 = A1_2

    L4_2 = L8_1

    L5_2 = A0_2.uploadType

    L4_2 = L4_2(L5_2)

    if not L4_2 then

      L4_2 = false

    end

    L3_2(L4_2)

  elseif "toggleLandscape" == L2_2 then

    L3_2 = GetPhoneObject

    L3_2 = L3_2()

    L4_2 = PlayerPedId

    L4_2 = L4_2()

    if L3_2 then

      L5_2 = DoesEntityExist

      L6_2 = L3_2

      L5_2 = L5_2(L6_2)

      if L5_2 then

        goto lbl_306

      end

    end

    L5_2 = A1_2

    L6_2 = "ok"

    do return L5_2(L6_2) end

    ::lbl_306::

    L5_2 = A0_2.toggled

    if L5_2 then

      L5_2 = AttachEntityToEntity

      L6_2 = L3_2

      L7_2 = L4_2

      L8_2 = GetPedBoneIndex

      L9_2 = L4_2

      L10_2 = 28422

      L8_2 = L8_2(L9_2, L10_2)

      L9_2 = -0.03

      L10_2 = -0.005

      L11_2 = -0.02

      L12_2 = 0.0

      L13_2 = 90.0

      L14_2 = 180.0

      L15_2 = false

      L16_2 = false

      L17_2 = false

      L18_2 = false

      L19_2 = 2

      L20_2 = true

      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)

    else

      L5_2 = AttachEntityToEntity

      L6_2 = L3_2

      L7_2 = L4_2

      L8_2 = GetPedBoneIndex

      L9_2 = L4_2

      L10_2 = 28422

      L8_2 = L8_2(L9_2, L10_2)

      L9_2 = 0.0

      L10_2 = -0.005

      L11_2 = 0.0

      L12_2 = 0.0

      L13_2 = 0.0

      L14_2 = 180.0

      L15_2 = false

      L16_2 = false

      L17_2 = false

      L18_2 = false

      L19_2 = 2

      L20_2 = true

      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)

    end

    L5_2 = A1_2

    L6_2 = "ok"

    L5_2(L6_2)

  elseif "flipCamera" == L2_2 then

    L3_2 = A0_2.value

    L3_2 = true == L3_2

    A0_2.value = L3_2

    L3_2 = L0_1

    L4_2 = A0_2.value

    if L3_2 == L4_2 then

      L3_2 = A1_2

      L4_2 = "ok"

      return L3_2(L4_2)

    end

    L3_2 = A0_2.value

    L0_1 = L3_2

    L3_2 = IsWalkingCamEnabled

    L3_2 = L3_2()

    if L3_2 then

      L3_2 = ToggleSelfieCam

      L4_2 = L0_1

      L3_2(L4_2)

    else

      L3_2 = CellCamActivateSelfieMode

      L4_2 = L0_1

      L3_2(L4_2)

    end

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

  elseif "setQuickZoom" == L2_2 then

    L3_2 = A0_2.value

    L4_2 = IsWalkingCamEnabled

    L4_2 = L4_2()

    if L4_2 then

      L4_2 = SetCameraZoom

      L5_2 = L3_2

      L4_2(L5_2)

    end

    L4_2 = A1_2

    L5_2 = true

    L4_2(L5_2)

  elseif "setRecordingPeerId" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:camera:setPeer"

    L5_2 = A0_2.peerId

    L3_2(L4_2, L5_2)

    L3_2 = A0_2.peerId

    L3_1 = L3_2

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

  else

    if "endedRecording" == L2_2 then

      L3_2 = L3_1

      if L3_2 then

        L3_2 = TriggerServerEvent

        L4_2 = "phone:camera:endedRecording"

        L5_2 = L3_1

        L3_2(L4_2, L5_2)

        L3_2 = nil

        L3_1 = L3_2

        L3_2 = A1_2

        L4_2 = "ok"

        L3_2(L4_2)

    end

    elseif "close" == L2_2 then

      cameraOpen = false

      L3_2 = false

      L1_1 = L3_2

      L3_2 = false

      L0_1 = L3_2

      L3_2 = StopDisplayingCameraButtons

      L3_2()

      L3_2 = DisableWalkableCam

      L3_2()

      L3_2 = A1_2

      L4_2 = "ok"

      L3_2(L4_2)

    end

  end

  ::lbl_442::

end

L10_1(L11_1, L12_1)

L10_1 = exports

L11_1 = "SaveToGallery"

function L12_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  L2_2 = "string" == L2_2

  L3_2 = "Expected string for link, got "

  L4_2 = type

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L3_2 = L3_2 .. L4_2

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "saveMedia"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L10_1(L11_1, L12_1)

L10_1 = RegisterNetEvent

L11_1 = "phone:photos:addMemberToAlbum"

function L12_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "photos:addMemberToAlbum"

  L4_2 = {}

  L4_2.albumId = A0_2

  L4_2.phoneNumber = A1_2

  L2_2(L3_2, L4_2)

end

L10_1(L11_1, L12_1)

L10_1 = RegisterNetEvent

L11_1 = "phone:photos:removeMemberFromAlbum"

function L12_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "photos:removeMemberFromAlbum"

  L4_2 = {}

  L4_2.albumId = A0_2

  L4_2.phoneNumber = A1_2

  L2_2(L3_2, L4_2)

end

L10_1(L11_1, L12_1)

L10_1 = RegisterNetEvent

L11_1 = "phone:photos:addSharedAlbum"

function L12_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "photos:addSharedAlbum"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L10_1(L11_1, L12_1)

L10_1 = RegisterNetEvent

L11_1 = "phone:photos:updateAlbum"

function L12_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = debugprint

  L2_2 = "phone:photos:updateAlbum"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "photos:updateAlbum"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L10_1(L11_1, L12_1)