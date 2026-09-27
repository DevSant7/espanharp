local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1

L0_1 = DisableControlAction

L1_1 = IsNuiFocused

L2_1 = DisablePlayerFiring

phoneData = nil

currentPhone = nil

settings = nil

phoneOpen = false

L3_1 = {}

SavedLocations = L3_1

PhoneOnScreen = false

L3_1 = nil

L4_1 = nil

L5_1 = nil

L6_1 = nil

function L7_1()

  local L0_2, L1_2

  L0_2 = L6_1

  if L0_2 then

    return

  end

  L0_2 = debugprint

  L1_2 = "waiting for config to be received"

  L0_2(L1_2)

  while true do

    L0_2 = L6_1

    if L0_2 then

      break

    end

    L0_2 = Wait

    L1_2 = 0

    L0_2(L1_2)

  end

  L0_2 = debugprint

  L1_2 = "config received"

  L0_2(L1_2)

end

function L8_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L0_2 = GetBaseUrl

  L0_2 = L0_2()

  L1_2 = L0_2

  L2_2 = string

  L2_2 = L2_2.find

  L3_2 = L0_2

  L4_2 = "%.users%.cfx%.re"

  L2_2 = L2_2(L3_2, L4_2)

  if L2_2 then

    L2_2 = #L0_2

    L4_2 = L0_2

    L3_2 = L0_2.reverse

    L3_2 = L3_2(L4_2)

    L4_2 = L3_2

    L3_2 = L3_2.find

    L5_2 = "-"

    L3_2 = L3_2(L4_2, L5_2)

    if not L3_2 then

      L3_2 = #L0_2

      L3_2 = L3_2 + 1

    end

    L2_2 = L2_2 - L3_2

    L2_2 = L2_2 + 1

    L3_2 = string

    L3_2 = L3_2.sub

    L4_2 = L0_2

    L5_2 = L2_2 + 1

    L6_2 = #L0_2

    L7_2 = ".users.cfx.re"

    L7_2 = #L7_2

    L6_2 = L6_2 - L7_2

    L3_2 = L3_2(L4_2, L5_2, L6_2)

    L1_2 = L3_2

  end

  return L1_2

end

function L9_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L0_2 = debugprint

  L1_2 = "FetchPhone triggered"

  L0_2(L1_2)

  L0_2 = L5_1

  if L0_2 then

    L0_2 = debugprint

    L1_2 = "already fetching phone"

    L0_2(L1_2)

    return

  else

    L0_2 = L6_1

    if not L0_2 then

      L0_2 = debugprint

      L1_2 = "config has not been received by the UI yet"

      L0_2(L1_2)

      return

    end

  end

  L0_2 = true

  L5_1 = L0_2

  while true do

    L0_2 = FrameworkLoaded

    if L0_2 then

      break

    end

    L0_2 = debugprint

    L1_2 = "waiting for framework to load"

    L0_2(L1_2)

    L0_2 = Wait

    L1_2 = 500

    L0_2(L1_2)

  end

  L0_2 = debugprint

  L1_2 = "triggering phone:playerLoaded"

  L0_2(L1_2)

  L0_2 = nil

  L1_2 = L4_1

  if L1_2 then

    L1_2 = currentPhone

    if L1_2 then

      goto lbl_49

    end

  end

  L1_2 = AwaitCallback

  L2_2 = "playerLoaded"

  L1_2 = L1_2(L2_2)

  L0_2 = L1_2

  L3_1 = L0_2

  L1_2 = true

  L4_1 = L1_2

  goto lbl_50

  ::lbl_49::

  L0_2 = L3_1

  ::lbl_50::

  L1_2 = debugprint

  L2_2 = "got number"

  L3_2 = L0_2

  L1_2(L2_2, L3_2)

  if not L0_2 then

    L1_2 = debugprint

    L2_2 = "no number, checking if player has item"

    L1_2(L2_2)

    L1_2 = HasPhoneItem

    L1_2 = L1_2()

    if L1_2 then

      L1_2 = debugprint

      L2_2 = "player has item; triggering phone:generatePhoneNumber"

      L1_2(L2_2)

      L1_2 = AwaitCallback

      L2_2 = "generatePhoneNumber"

      L1_2 = L1_2(L2_2)

      L0_2 = L1_2

      L1_2 = debugprint

      L2_2 = "got number"

      L3_2 = L0_2

      L1_2(L2_2, L3_2)

    else

      L1_2 = debugprint

      L2_2 = "player does not have item"

      L1_2(L2_2)

    end

  end

  if not L0_2 then

    L1_2 = false

    L5_1 = L1_2

    L1_2 = currentPhone

    if L1_2 then

      L1_2 = debugprint

      L2_2 = "no number. using SetPhone"

      L1_2(L2_2)

      L1_2 = SetPhone

      L1_2()

    end

    L1_2 = debugprint

    L2_2 = "no number, returning"

    L1_2(L2_2)

    return

  end

  L1_2 = json

  L1_2 = L1_2.decode

  L2_2 = GetConfigFile

  L3_2 = "defaultSettings.json"

  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2(L3_2)

  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)

  L2_2 = AwaitCallback

  L3_2 = "getLatestVersion"

  L2_2 = L2_2(L3_2)

  L3_2 = GetResourceMetadata

  L4_2 = GetCurrentResourceName

  L4_2 = L4_2()

  L5_2 = "version"

  L6_2 = 0

  L3_2 = L3_2(L4_2, L5_2, L6_2)

  if not L2_2 then

    L2_2 = L3_2

  end

  L4_2 = Config

  L4_2 = L4_2.DefaultLocale

  L1_2.locale = L4_2

  L1_2.version = L3_2

  L1_2.latestVersion = L2_2

  L4_2 = false

  L5_2 = debugprint

  L6_2 = "fetching phone data"

  L5_2(L6_2)

  L5_2 = AwaitCallback

  L6_2 = "getPhone"

  L7_2 = L0_2

  L5_2 = L5_2(L6_2, L7_2)

  L6_2 = debugprint

  L7_2 = "got phone data"

  L8_2 = json

  L8_2 = L8_2.encode

  L9_2 = L5_2

  L8_2, L9_2, L10_2 = L8_2(L9_2)

  L6_2(L7_2, L8_2, L9_2, L10_2)

  if L5_2 then

    L6_2 = L5_2.settings

    if L6_2 then

      L1_2 = L5_2.settings

    end

    L6_2 = L5_2.name

    if L6_2 then

      L6_2 = L5_2.name

      L1_2.name = L6_2

    else

      L6_2 = AwaitCallback

      L7_2 = "getCharacterName"

      L6_2 = L6_2(L7_2)

      L7_2 = L

      L8_2 = "BACKEND.MISC.X_PHONE"

      L9_2 = {}

      L10_2 = L6_2.firstname

      L9_2.name = L10_2

      L10_2 = L6_2.lastname

      L9_2.lastname = L10_2

      L7_2 = L7_2(L8_2, L9_2)

      L1_2.name = L7_2

    end

    L1_2.version = L3_2

    L1_2.latestVersion = L2_2

    L6_2 = AwaitCallback

    L7_2 = "maps:getSavedLocations"

    L6_2 = L6_2(L7_2)

    SavedLocations = L6_2

    L6_2 = L5_2.is_setup

    L4_2 = L6_2 or L4_2

    if not L6_2 then

      L4_2 = false

    end

    currentPhone = L0_2

    L6_2 = {}

    L6_2.isSetup = L4_2

    L6_2.phoneNumber = L0_2

    if L1_2 and type(L1_2) == "table" and L1_2.apps and type(L1_2.apps) == "table" then
      print("^3[lb-phone Debug]^7 Settings apps BEFORE sanitization: " .. json.encode(L1_2.apps))
      local foundSpotify = false
      for i, group in pairs(L1_2.apps) do
        if type(group) == "table" then
          for j, val in pairs(group) do
            -- Corrigir Music para spotify
            if val == "Music" or val == "music" then
              group[j] = "spotify"
              foundSpotify = true
            elseif val == "spotify" then
              foundSpotify = true
            end
            -- Corrigir Banking para nubank
            if val == "Banking" then
              group[j] = "nubank"
            end
          end
        end
      end
      if not foundSpotify then
        local homeGroup = L1_2.apps[2] or L1_2.apps["2"]
        if type(homeGroup) == "table" then
          table.insert(homeGroup, "spotify")
        end
      end
      print("^2[lb-phone Debug]^7 Settings apps AFTER sanitization: " .. json.encode(L1_2.apps))
    else
      print("^1[lb-phone Debug]^7 Settings or Settings.apps is not a table!")
    end

    L6_2.settings = L1_2
    L7_2 = 100
    L6_2.battery = L7_2

    L7_2 = L8_1

    L7_2 = L7_2()

    L6_2.serverIdentifier = L7_2

    phoneData = L6_2

    L6_2 = L7_1

    L6_2()

    L6_2 = debugprint

    L7_2 = "triggering phone:setPhoneData"

    L6_2(L7_2)

    L6_2 = SendReactMessage

    L7_2 = "setPhoneData"

    L8_2 = phoneData

    L6_2(L7_2, L8_2)

    L6_2 = TriggerEvent

    L7_2 = "lb-phone:numberChanged"

    L8_2 = L0_2

    L6_2(L7_2, L8_2)

    L6_2 = Wait

    L7_2 = 250

    L6_2(L7_2)

  end

  L6_2 = FetchCryptoCoins

  if L6_2 then

    L6_2 = FetchCryptoCoins

    L6_2()

  end

  settings = L1_2

  L6_2 = false

  L5_1 = L6_2

end

FetchPhone = L9_1

function L9_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2

  L1_2 = debugprint

  L2_2 = "RefreshPhone triggered"

  L1_2(L2_2)

  L1_2 = L5_1

  if L1_2 then

    L1_2 = debugprint

    L2_2 = "phone is being fetched, waiting before refreshing"

    L1_2(L2_2)

    while true do

      L1_2 = L5_1

      if not L1_2 then

        break

      end

      L1_2 = Wait

      L2_2 = 0

      L1_2(L2_2)

    end

  end

  L1_2 = Config

  L1_2 = L1_2.DynamicWebRTC

  if L1_2 then

    L1_2 = L1_2.Enabled

  end

  if L1_2 then

    L1_2 = AwaitCallback

    L2_2 = "getWebRTCCredentials"

    L1_2 = L1_2(L2_2)

    L2_2 = Config

    L2_2 = L2_2.DynamicWebRTC

    L2_2 = L2_2.RemoveStun

    if L2_2 and L1_2 then

      L2_2 = #L1_2

      L3_2 = 1

      L4_2 = -1

      for L5_2 = L2_2, L3_2, L4_2 do

        L6_2 = L1_2[L5_2]

        L6_2 = L6_2.credential

        if not L6_2 then

          L6_2 = table

          L6_2 = L6_2.remove

          L7_2 = L1_2

          L8_2 = L5_2

          L6_2(L7_2, L8_2)

        end

      end

    end

    if L1_2 then

      L2_2 = Config

      L3_2 = Config

      L3_2 = L3_2.RTCConfig

      if not L3_2 then

        L3_2 = {}

      end

      L2_2.RTCConfig = L3_2

      L2_2 = Config

      L2_2 = L2_2.RTCConfig

      L2_2.iceServers = L1_2

    end

  end

  L1_2 = false

  L6_1 = L1_2

  L1_2 = json

  L1_2 = L1_2.decode

  L2_2 = GetConfigFile

  L3_2 = "config.json"

  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L2_2(L3_2)

  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

  L2_2 = {}

  L3_2 = Config

  L3_2 = L3_2.Valet

  L3_2 = L3_2.Enabled

  if L3_2 then

    L3_2 = true

    if L3_2 then

      goto lbl_80

    end

  end

  L3_2 = false

  ::lbl_80::

  L2_2.enabled = L3_2

  L3_2 = Config

  L3_2 = L3_2.Valet

  L3_2 = L3_2.Price

  if not L3_2 then

    L3_2 = 0

  end

  L2_2.price = L3_2

  L3_2 = Config

  L3_2 = L3_2.Valet

  L3_2 = L3_2.VehicleTypes

  if not L3_2 then

    L3_2 = {}

    L4_2 = "car"

    L3_2[1] = L4_2

  end

  L2_2.vehicleTypes = L3_2

  L1_2.valet = L2_2

  L2_2 = Config

  L2_2 = L2_2.Locations

  L1_2.locations = L2_2

  L2_2 = Config

  L2_2 = L2_2.AllowExternal

  L1_2.AllowExternal = L2_2

  L2_2 = Config

  L2_2 = L2_2.ExternalBlacklistedDomains

  L1_2.ExternalBlacklistedDomains = L2_2

  L2_2 = Config

  L2_2 = L2_2.ExternalWhitelistedDomains

  L1_2.ExternalWhitelistedDomains = L2_2

  L2_2 = Config

  L2_2 = L2_2.EmailDomain

  L1_2.EmailDomain = L2_2

  L2_2 = Config

  L2_2 = L2_2.RealTime

  L1_2.RealTime = L2_2

  L2_2 = Config

  L2_2 = L2_2.CurrencyFormat

  L1_2.CurrencyFormat = L2_2

  L2_2 = Config

  L2_2 = L2_2.DeleteMessages

  L1_2.DeleteMessages = L2_2

  L2_2 = Config

  L2_2 = L2_2.Battery

  L1_2.Battery = L2_2

  L2_2 = Config

  L2_2 = L2_2.RTCConfig

  L1_2.rtc = L2_2

  L2_2 = Config

  L2_2 = L2_2.PromoteBirdy

  L1_2.PromoteBirdy = L2_2

  L2_2 = Config

  L2_2 = L2_2.DynamicIsland

  L1_2.DynamicIsland = L2_2

  L2_2 = Config

  L2_2 = L2_2.SetupScreen

  L1_2.SetupScreen = L2_2

  L2_2 = Config

  L2_2 = L2_2.MaxTransferAmount

  L1_2.MaxTransferAmount = L2_2

  L2_2 = Config

  L2_2 = L2_2.EnableMessagePay

  L1_2.EnableMessagePay = L2_2

  L2_2 = Config

  L2_2 = L2_2.EnableGIFs

  L1_2.EnableGIFs = L2_2

  L2_2 = Config

  L2_2 = L2_2.GIFsFilter

  if not L2_2 then

    L2_2 = "low"

  end

  L1_2.GIFsFilter = L2_2

  L2_2 = Config

  L2_2 = L2_2.EnableVoiceMessages

  L1_2.EnableVoiceMessages = L2_2

  L2_2 = Config

  L2_2 = L2_2.DefaultLocale

  L1_2.DefaultLocale = L2_2

  L2_2 = Config

  L2_2 = L2_2.DateLocale

  L1_2.DateLocale = L2_2

  L2_2 = Config

  L2_2 = L2_2.Debug

  L1_2.Debug = L2_2

  L2_2 = Config

  L2_2 = L2_2.TrendyTTS

  if not L2_2 then

    L2_2 = {}

    L3_2 = {}

    L4_2 = "English (US) - Female"

    L5_2 = "en_us_001"

    L3_2[1] = L4_2

    L3_2[2] = L5_2

    L2_2[1] = L3_2

  end

  L1_2.TikTokTTS = L2_2

  L2_2 = Config

  L2_2 = L2_2.Voice

  L2_2 = L2_2.RecordNearby

  L1_2.recordNearbyVoices = L2_2

  L2_2 = Config

  L2_2 = L2_2.FrameColor

  L1_2.frameColor = L2_2

  L2_2 = Config

  L2_2 = L2_2.AllowFrameColorChange

  L1_2.allowFrameColorChange = L2_2

  L2_2 = Config

  L2_2 = L2_2.KeyBinds

  L2_2 = L2_2.UnlockPhone

  if L2_2 then

    L2_2 = L2_2.Bind

  end

  if not L2_2 then

    L2_2 = nil

  end

  L1_2.unlockPhoneKey = L2_2

  L2_2 = Config

  L2_2 = L2_2.DeleteMail

  L1_2.DeleteMail = L2_2

  L2_2 = Config

  L2_2 = L2_2.ChangePassword

  L1_2.ChangePassword = L2_2

  L2_2 = Config

  L2_2 = L2_2.DeleteAccount

  L1_2.DeleteAccount = L2_2

  L2_2 = Config

  L2_2 = L2_2.Camera

  if L2_2 then

    L2_2 = L2_2.Enabled

  end

  if not L2_2 then

    L2_2 = false

  end

  L1_2.CustomCamera = L2_2

  L2_2 = Config

  L2_2 = L2_2.UsernameFilter

  if L2_2 then

    L2_2 = L2_2.Regex

  end

  if not L2_2 then

    L2_2 = "[a-zA-Z0-9]+"

  end

  L1_2.UsernameFilter = L2_2

  L2_2 = Config

  L2_2 = L2_2.Crypto

  if L2_2 then

    L2_2 = Config

    L2_2 = L2_2.Crypto

    L2_2 = L2_2.Limits

    if L2_2 then

      goto lbl_238

    end

  end

  L2_2 = {}

  L2_2.Buy = 1000000

  L2_2.Sell = 1000000

  ::lbl_238::

  L1_2.CryptoLimit = L2_2

  L2_2 = Config

  L2_2 = L2_2.Browser

  L1_2.Browser = L2_2

  L2_2 = Config

  L2_2 = L2_2.CustomMaps

  L1_2.CustomMaps = L2_2

  L2_2 = {}

  L3_2 = Config

  L3_2 = L3_2.Sound

  L3_2 = L3_2.System

  L2_2.system = L3_2

  L3_2 = Config

  L3_2 = L3_2.Sound

  L3_2 = L3_2.Ringtones

  L2_2.ringtones = L3_2

  L3_2 = Config

  L3_2 = L3_2.Sound

  L3_2 = L3_2.Notifications

  L2_2.notifications = L3_2

  L3_2 = Config

  L3_2 = L3_2.Sound

  L3_2 = L3_2.AppNotifications

  L2_2.appNotifications = L3_2

  L1_2.sound = L2_2

  L2_2 = Config

  L2_2 = L2_2.AppDownloadTime

  L1_2.AppDownloadTime = L2_2

  L2_2 = Config

  L2_2 = L2_2.PhoneNumber

  L2_2 = L2_2.Length

  if not L2_2 then

    L2_2 = 7

  end

  L3_2 = Config

  L3_2 = L3_2.PhoneNumber

  L3_2 = L3_2.Prefixes

  L3_2 = #L3_2

  if L3_2 > 0 then

    L3_2 = Config

    L3_2 = L3_2.PhoneNumber

    L3_2 = L3_2.Prefixes

    L3_2 = L3_2[1]

    L3_2 = #L3_2

    if L3_2 then

      goto lbl_287

    end

  end

  L3_2 = 0

  ::lbl_287::

  L4_2 = L2_2 + L3_2

  L1_2.PhoneNumberLength = L4_2

  L4_2 = Config

  L4_2 = L4_2.PhoneNumber

  L4_2 = L4_2.Format

  L1_2.Format = L4_2

  L4_2 = {}

  L5_2 = Config

  L5_2 = L5_2.Image

  if L5_2 then

    L5_2 = L5_2.Mime

  end

  if not L5_2 then

    L5_2 = "image/png"

  end

  L4_2.mime = L5_2

  L5_2 = Config

  L5_2 = L5_2.Image

  if L5_2 then

    L5_2 = L5_2.Quality

  end

  if not L5_2 then

    L5_2 = 1.0

  end

  L4_2.quality = L5_2

  L1_2.imageOptions = L4_2

  L4_2 = {}

  L5_2 = Config

  L5_2 = L5_2.Video

  if L5_2 then

    L5_2 = L5_2.Bitrate

  end

  if not L5_2 then

    L5_2 = 250

  end

  L4_2.bitrate = L5_2

  L5_2 = Config

  L5_2 = L5_2.Video

  if L5_2 then

    L5_2 = L5_2.MaxSize

  end

  if not L5_2 then

    L5_2 = 10

  end

  L4_2.size = L5_2

  L5_2 = Config

  L5_2 = L5_2.Video

  if L5_2 then

    L5_2 = L5_2.MaxDuration

  end

  if not L5_2 then

    L5_2 = 60

  end

  L4_2.duration = L5_2

  L5_2 = Config

  L5_2 = L5_2.Video

  if L5_2 then

    L5_2 = L5_2.FrameRate

  end

  if not L5_2 then

    L5_2 = 24

  end

  L4_2.fps = L5_2

  L1_2.videoOptions = L4_2

  L4_2 = table

  L4_2 = L4_2.deep_clone

  L5_2 = Config

  L5_2 = L5_2.Companies

  L4_2 = L4_2(L5_2)

  L1_2.Companies = L4_2

  L4_2 = L1_2.Companies

  if L4_2 then

    L4_2 = L4_2.Services

  end

  if L4_2 then

    L4_2 = 1

    L5_2 = L1_2.Companies

    L5_2 = L5_2.Services

    L5_2 = #L5_2

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = L1_2.Companies

      L8_2 = L8_2.Services

      L8_2 = L8_2[L7_2]

      L9_2 = L8_2.onCustomIconClick

      if L9_2 then

        L8_2.onCustomIconClick = true

      end

    end

  end

  L4_2 = Config

  L4_2 = L4_2.CustomApps

  if L4_2 then

    L4_2 = pairs

    L5_2 = Config

    L5_2 = L5_2.CustomApps

    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)

    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do

      L10_2 = L1_2.apps

      L11_2 = FormatCustomAppDataForUI

      L12_2 = L9_2

      L11_2 = L11_2(L12_2)

      L10_2[L8_2] = L11_2

    end

  end

  L4_2 = pairs

  L5_2 = L1_2.apps

  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)

  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do

    L10_2 = HasAccessToApp

    L11_2 = L8_2

    L10_2 = L10_2(L11_2)

    L9_2.access = L10_2

  end

  L4_2 = json

  L4_2 = L4_2.decode

  L5_2 = GetConfigFile

  L6_2 = "defaultSettings.json"

  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L5_2(L6_2)

  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

  L1_2.defaultSettings = L4_2

  function L4_2(A0_3)

    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3

    L1_3 = L1_2.defaultSettings

    L1_3 = L1_3.apps

    L2_3 = 1

    L3_3 = #L1_3

    L4_3 = 1

    for L5_3 = L2_3, L3_3, L4_3 do

      L6_3 = 1

      L7_3 = L1_3[L5_3]

      L7_3 = #L7_3

      L8_3 = 1

      for L9_3 = L6_3, L7_3, L8_3 do

        L10_3 = L1_3[L5_3]

        L10_3 = L10_3[L9_3]

        if L10_3 == A0_3 then

          L10_3 = table

          L10_3 = L10_3.remove

          L11_3 = L1_3[L5_3]

          L12_3 = L9_3

          L10_3(L11_3, L12_3)

          break

        end

      end

    end

  end

  L5_2 = Config

  L5_2 = L5_2.Framework

  if "standalone" == L5_2 then

    L5_2 = Config

    L5_2 = L5_2.CustomFramework

    if not L5_2 then

      L5_2 = L1_2.apps

      L5_2.Wallet = nil

      L5_2 = L1_2.apps

      L5_2.Home = nil

      L5_2 = L1_2.apps

      L5_2.Garage = nil

      L5_2 = L1_2.apps

      L5_2.Services = nil

      L5_2 = L4_2

      L6_2 = "Wallet"

      L5_2(L6_2)

      L5_2 = L4_2

      L6_2 = "Home"

      L5_2(L6_2)

      L5_2 = L4_2

      L6_2 = "Garage"

      L5_2(L6_2)

      L5_2 = L4_2

      L6_2 = "Services"

      L5_2(L6_2)

    end

  end

  L5_2 = Config

  L5_2 = L5_2.HouseScript

  if not L5_2 then

    L5_2 = L1_2.apps

    L5_2.Home = nil

    L5_2 = debugprint

    L6_2 = "No Config.HouseScript, removed home app"

    L5_2(L6_2)

    L5_2 = L4_2

    L6_2 = "Home"

    L5_2(L6_2)

  end

  L5_2 = Config

  L5_2 = L5_2.Crypto

  if L5_2 then

    L5_2 = Config

    L5_2 = L5_2.Crypto

    L5_2 = L5_2.Enabled

    if L5_2 then

      goto lbl_473

    end

  end

  L5_2 = L1_2.apps

  L5_2.Crypto = nil

  L5_2 = debugprint

  L6_2 = "Config.Crypto not enabled, removed crypto app"

  L5_2(L6_2)

  L5_2 = L4_2

  L6_2 = "Crypto"

  L5_2(L6_2)

  ::lbl_473::

  L5_2 = pairs

  L6_2 = GetHiddenApps

  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L6_2()

  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do

    L11_2 = L1_2.apps

    L11_2 = L11_2[L9_2]

    if L11_2 then

      L11_2 = L1_2.apps

      L11_2 = L11_2[L9_2]

      L11_2.hidden = L10_2

    end

  end

  L5_2 = SendReactMessage

  L6_2 = "setConfig"

  L7_2 = L1_2

  L5_2(L6_2, L7_2)

  L5_2 = L7_1

  L5_2()

  L5_2 = phoneData

  if L5_2 then

    L5_2 = debugprint

    L6_2 = "phoneData is defined"

    L5_2(L6_2)

    L5_2 = SendReactMessage

    L6_2 = "setPhoneData"

    L7_2 = phoneData

    L5_2(L6_2, L7_2)

    return

  end

  if A0_2 then

    return

  end

  L5_2 = FetchPhone

  L5_2()

end

RefreshPhone = L9_1

L9_1 = RegisterNetEvent

L10_1 = "lb-phone:jobUpdated"

function L11_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2

  L1_2 = Config

  L1_2 = L1_2.WhitelistApps

  if not L1_2 then

    L1_2 = Config

    L1_2 = L1_2.BlacklistApps

    if not L1_2 then

      return

    end

  end

  L1_2 = debugprint

  L2_2 = "Job updated, refreshing whitelisted & blacklisted apps"

  L1_2(L2_2)

  L1_2 = pairs

  L2_2 = Config

  L2_2 = L2_2.WhitelistApps

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = SendReactMessage

    L8_2 = "app:setHasAccess"

    L9_2 = {}

    L9_2.app = L5_2

    L10_2 = HasAccessToApp

    L11_2 = L5_2

    L12_2 = A0_2.job

    L13_2 = A0_2.grade

    L10_2 = L10_2(L11_2, L12_2, L13_2)

    L9_2.hasAccess = L10_2

    L7_2(L8_2, L9_2)

  end

  L1_2 = pairs

  L2_2 = Config

  L2_2 = L2_2.BlacklistApps

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = SendReactMessage

    L8_2 = "app:setHasAccess"

    L9_2 = {}

    L9_2.app = L5_2

    L10_2 = HasAccessToApp

    L11_2 = L5_2

    L12_2 = A0_2.job

    L13_2 = A0_2.grade

    L10_2 = L10_2(L11_2, L12_2, L13_2)

    L9_2.hasAccess = L10_2

    L7_2(L8_2, L9_2)

  end

  L1_2 = pairs

  L2_2 = Config

  L2_2 = L2_2.CustomApps

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = SendReactMessage

    L8_2 = "app:setHasAccess"

    L9_2 = {}

    L9_2.app = L5_2

    L10_2 = HasAccessToApp

    L11_2 = L5_2

    L12_2 = A0_2.job

    L13_2 = A0_2.grade

    L10_2 = L10_2(L11_2, L12_2, L13_2)

    L9_2.hasAccess = L10_2

    L7_2(L8_2, L9_2)

  end

end

L9_1(L10_1, L11_1)

L9_1 = RegisterNUICallback

L10_1 = "configReceived"

function L11_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = debugprint

  L3_2 = "UI has received the config (configReceived triggered)"

  L2_2(L3_2)

  L2_2 = true

  L6_1 = L2_2

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L9_1(L10_1, L11_1)

L9_1 = RegisterNUICallback

L10_1 = "getPhoneData"

function L11_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = debugprint

  L3_2 = "getPhoneData triggered"

  L2_2(L3_2)

  while true do

    L2_2 = FrameworkLoaded

    if L2_2 then

      break

    end

    L2_2 = Wait

    L3_2 = 500

    L2_2(L3_2)

  end

  L2_2 = Wait

  L3_2 = 1000

  L2_2(L3_2)

  L2_2 = RefreshPhone

  L2_2()

  if not A1_2 then

    L2_2 = debugprint

    L3_2 = "cb is not defined in getPhoneData"

    L4_2 = A0_2

    return L2_2(L3_2, L4_2)

  end

  L2_2 = A1_2

  L3_2 = true

  L2_2(L3_2)

end

L9_1(L10_1, L11_1)

function L9_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2

  L0_2 = PlayerId

  L0_2 = L0_2()

  while true do

    L1_2 = phoneOpen

    if not L1_2 then

      break

    end

    L1_2 = Wait

    L2_2 = 0

    L1_2(L2_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 199

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 200

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 24

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 25

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 69

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 70

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 91

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 92

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 106

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 114

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 140

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 141

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 142

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 257

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 263

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 264

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 330

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 331

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = L2_1

    L2_2 = L0_2

    L3_2 = true

    L1_2(L2_2, L3_2)

    L1_2 = L1_1

    L1_2 = L1_2()

    if L1_2 then

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 1

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 2

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 245

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 14

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 15

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 16

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 17

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 37

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 50

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 99

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 115

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 180

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 181

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 198

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 241

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 242

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 261

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 262

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

      L1_2 = L0_1

      L2_2 = 0

      L3_2 = 85

      L4_2 = true

      L1_2(L2_2, L3_2, L4_2)

    end

  end

  while true do

    L1_2 = IsDisabledControlPressed

    L2_2 = 0

    L3_2 = 200

    L1_2 = L1_2(L2_2, L3_2)

    if not L1_2 then

      break

    end

    L1_2 = L0_1

    L2_2 = 0

    L3_2 = 200

    L4_2 = true

    L1_2(L2_2, L3_2, L4_2)

    L1_2 = Wait

    L2_2 = 0

    L1_2(L2_2)

  end

  L1_2 = cameraOpen

  if L1_2 then

    L1_2 = IsWalkingCamEnabled

    L1_2 = L1_2()

    if L1_2 then

      L1_2 = IsSelfieCam

      L1_2 = L1_2()

      L2_2 = DisableWalkableCam

      L2_2()

      while true do

        L2_2 = phoneOpen

        if L2_2 then

          break

        end

        L2_2 = Wait

        L3_2 = 500

        L2_2(L3_2)

      end

      L2_2 = cameraOpen

      if L2_2 then

        L2_2 = SetPhoneAction

        L3_2 = "camera"

        L2_2(L3_2)

        L2_2 = EnableWalkableCam

        L3_2 = L1_2

        L2_2(L3_2)

      end

    end

  end

end

L10_1 = false

function L11_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = L10_1

  if L2_2 then

    return

  end

  L2_2 = type

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  if "boolean" ~= L2_2 then

    L2_2 = phoneOpen

    A0_2 = not L2_2

  end

  A0_2 = true == A0_2

  L2_2 = debugprint

  L3_2 = "ToggleOpen triggered"

  L4_2 = tostring

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L5_2 = tostring

  L6_2 = A1_2

  L5_2, L6_2 = L5_2(L6_2)

  L2_2(L3_2, L4_2, L5_2, L6_2)

  L2_2 = phoneDisabled

  if L2_2 and A0_2 then

    L2_2 = debugprint

    L3_2 = "phone is disabled, returning"

    L2_2(L3_2)

    return

  else

    L2_2 = phoneOpen

    if L2_2 == A0_2 then

      L2_2 = debugprint

      L3_2 = "phoneOpen & open are both the same value, returning"

      L2_2(L3_2)

      return

    else

      L2_2 = FrameworkLoaded

      if not L2_2 and A0_2 then

        L2_2 = infoprint

        L3_2 = "warning"

        L4_2 = "Framework not loaded"

        L2_2(L3_2, L4_2)

        return

      else

        if A0_2 then

          L2_2 = IsPedDeadOrDying

          L3_2 = PlayerPedId

          L3_2 = L3_2()

          L4_2 = true

          L2_2 = L2_2(L3_2, L4_2)

          if L2_2 then

            L2_2 = debugprint

            L3_2 = "player ped is dead/dying, returning"

            L2_2(L3_2)

            return

        end

        else

          if A0_2 then

            L2_2 = CanOpenPhone

            if L2_2 then

              L2_2 = CanOpenPhone

              L2_2 = L2_2()

              if not L2_2 then

                L2_2 = debugprint

                L3_2 = "CanOpenPhone returned false, returning"

                L2_2(L3_2)

                return

            end

          end

          else

            if A0_2 then

              L2_2 = ValidateChecks

              L3_2 = "openPhone"

              L2_2 = L2_2(L3_2)

              if not L2_2 then

                L2_2 = debugprint

                L3_2 = "ValidateChecks returned false for openPhone, returning"

                L2_2(L3_2)

                return

            end

            else

              if A0_2 then

                L2_2 = L1_1

                L2_2 = L2_2()

                if L2_2 then

                  L2_2 = Config

                  L2_2 = L2_2.DisableOpenNUI

                  if L2_2 then

                    L2_2 = infoprint

                    L3_2 = "info"

                    L4_2 = "Not opening the phone as another script has NUI focus. You can disable this behavior by setting Config.DisableOpenNUI to false."

                    L2_2(L3_2, L4_2)

                    return

                end

              end

              else

                L2_2 = GetResourceState

                L3_2 = "lb-tablet"

                L2_2 = L2_2(L3_2)

                if "started" == L2_2 then

                  L2_2 = Config

                  L2_2 = L2_2.DisableTabletOpenPhone

                  if not L2_2 then

                    L2_2 = pcall

                    function L3_2()

                      local L0_3, L1_3

                      L0_3 = exports

                      L0_3 = L0_3["lb-tablet"]

                      L1_3 = L0_3

                      L0_3 = L0_3.IsOpen

                      return L0_3(L1_3)

                    end

                    L2_2, L3_2 = L2_2(L3_2)

                    if L2_2 and L3_2 then

                      L4_2 = infoprint

                      L5_2 = "info"

                      L6_2 = "Not opening the phone as the tablet is open. You can disable this behavior by adding Config.DisableTabletOpenPhone = true to the config."

                      L4_2(L5_2, L6_2)

                      return

                    end

                  end

                end

              end

            end

          end

        end

      end

    end

  end

  L2_2 = L5_1

  if L2_2 then

    L2_2 = true

    L10_1 = L2_2

    while true do

      L2_2 = L5_1

      if not L2_2 then

        break

      end

      L2_2 = Wait

      L3_2 = 0

      L2_2(L3_2)

    end

    L2_2 = false

    L10_1 = L2_2

  end

  if A0_2 then

    L2_2 = currentPhone

    if not L2_2 then

      L2_2 = debugprint

      L3_2 = "no phone, fetching"

      L2_2(L3_2)

      L2_2 = FetchPhone

      L2_2()

      L2_2 = currentPhone

      if not L2_2 then

        L2_2 = debugprint

        L3_2 = "still no phone after fetching, returning"

        L2_2(L3_2)

        return

      end

    end

  end

  if A0_2 then

    L2_2 = HasPhoneItem

    L3_2 = currentPhone

    L2_2 = L2_2(L3_2)

    if not L2_2 then

      L2_2 = debugprint

      L3_2 = "HasPhoneItem returned false. Phone number:"

      L4_2 = tostring

      L5_2 = currentPhone

      L4_2, L5_2, L6_2 = L4_2(L5_2)

      L2_2(L3_2, L4_2, L5_2, L6_2)

      L2_2 = TriggerServerEvent

      L3_2 = "phone:togglePhone"

      L2_2(L3_2)

      L2_2 = SendReactMessage

      L3_2 = "closePhone"

      L2_2(L3_2)

      return

    end

  end

  if not A0_2 then

    L2_2 = IsWalkingCamEnabled

    L2_2 = L2_2()

    if L2_2 then

      L2_2 = IsSelfieCam

      L2_2 = L2_2()

      if L2_2 then

        L2_2 = ToggleSelfieCam

        L3_2 = false

        L2_2(L3_2)

      end

    end

  end

  if not A0_2 then

    L2_2 = Config

    L2_2 = L2_2.EndLiveClose

    if L2_2 then

      L2_2 = IsWatchingLive

      L2_2 = L2_2()

      L3_2 = EndLive

      L3_2()

      if L2_2 then

        L3_2 = SendReactMessage

        L4_2 = "instagram:liveEnded"

        L5_2 = L2_2

        L3_2(L4_2, L5_2)

      end

    end

  end

  phoneOpen = A0_2

  L2_2 = true

  L10_1 = L2_2

  if A0_2 then

    L2_2 = debugprint

    L3_2 = "should open phone. sending openPhone event to ui"

    L2_2(L3_2)

    L2_2 = SendReactMessage

    L3_2 = "openPhone"

    L2_2(L3_2)

    if not A1_2 then

      L2_2 = SetNuiFocus

      L3_2 = true

      L4_2 = true

      L2_2(L3_2, L4_2)

      L2_2 = SetNuiFocusKeepInput

      L3_2 = Config

      L3_2 = L3_2.KeepInput

      L2_2(L3_2)

    end

    L2_2 = Config

    L2_2 = L2_2.KeepInput

    if L2_2 then

      L2_2 = CreateThread

      L3_2 = L9_1

      L2_2(L3_2)

    end

    L2_2 = ControllerThread

    if L2_2 then

      L2_2 = CreateThread

      L3_2 = ControllerThread

      L2_2(L3_2)

    end

    L2_2 = debugprint

    L3_2 = "setting animation action"

    L2_2(L3_2)

    L2_2 = IsWalkingCamEnabled

    L2_2 = L2_2()

    if L2_2 then

      L2_2 = SetPhoneAction

      L3_2 = "camera"

      L2_2(L3_2)

    else

      L2_2 = IsInCall

      L2_2 = L2_2()

      if L2_2 then

        L2_2 = SetPhoneAction

        L3_2 = "call"

        L2_2(L3_2)

      else

        L2_2 = SetPhoneAction

        L3_2 = "default"

        L2_2(L3_2)

      end

    end

  else

    L2_2 = debugprint

    L3_2 = "sending closePhone event to ui"

    L2_2(L3_2)

    L2_2 = PlayCloseAnim

    L2_2()

    L2_2 = SetNuiFocus

    L3_2 = false

    L4_2 = false

    L2_2(L3_2, L4_2)

    L2_2 = SetNuiFocusKeepInput

    L3_2 = false

    L2_2(L3_2)

    L2_2 = SendReactMessage

    L3_2 = "closePhone"

    L2_2(L3_2)

  end

  L2_2 = TriggerServerEvent

  L3_2 = "phone:togglePhone"

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

  L2_2 = TriggerEvent

  L3_2 = "lb-phone:phoneToggled"

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

  L2_2 = false

  L10_1 = L2_2

end

ToggleOpen = L11_1

L11_1 = RegisterNUICallback

L12_1 = "toggleInput"

function L13_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

  L2_2 = Config

  L2_2 = L2_2.KeepInput

  if not L2_2 then

    return

  end

  L2_2 = Config

  L2_2 = L2_2.DisableFocusTalking

  if L2_2 then

    L2_2 = IsDisabledControlPressed

    L3_2 = 0

    L4_2 = 249

    L2_2 = L2_2(L3_2, L4_2)

    if L2_2 then

      goto lbl_25

    end

  end

  L2_2 = IsDisabledControlJustReleased

  L3_2 = 0

  L4_2 = 249

  L2_2 = L2_2(L3_2, L4_2)

  ::lbl_25::

  if L2_2 then

    if A0_2 then

      L2_2 = debugprint

      L3_2 = "PTT is pressed, ignoring toggle focus"

      L2_2(L3_2)

      return

    end

    L2_2 = debugprint

    L3_2 = "PTT is pressed, waiting before toggling focus"

    L2_2(L3_2)

    while true do

      L2_2 = Config

      L2_2 = L2_2.DisableFocusTalking

      if L2_2 then

        L2_2 = IsDisabledControlPressed

        L3_2 = 0

        L4_2 = 249

        L2_2 = L2_2(L3_2, L4_2)

        if L2_2 then

          goto lbl_50

        end

      end

      L2_2 = IsDisabledControlJustReleased

      L3_2 = 0

      L4_2 = 249

      L2_2 = L2_2(L3_2, L4_2)

      if not L2_2 then

        break

      end

      ::lbl_50::

      L2_2 = Wait

      L3_2 = 100

      L2_2(L3_2)

    end

  end

  if A0_2 then

    L2_2 = Wait

    L3_2 = 200

    L2_2(L3_2)

  end

  L2_2 = SetNuiFocusKeepInput

  L3_2 = not A0_2

  L2_2(L3_2)

end

L11_1(L12_1, L13_1)

L11_1 = false

L12_1 = AddEventHandler

L13_1 = "lb-phone:keyPressed"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = IsPauseMenuActive

  L1_2 = L1_2()

  if L1_2 then

    return

  end

  if "Open" == A0_2 then

    L1_2 = debugprint

    L2_2 = "Pressed open keybind"

    L1_2(L2_2)

    L1_2 = ToggleOpen

    L2_2 = phoneOpen

    L2_2 = not L2_2

    L1_2(L2_2)

  elseif "Focus" == A0_2 then

    L1_2 = phoneOpen

    if L1_2 then

      L1_2 = L11_1

      if not L1_2 then

        goto lbl_25

      end

    end

    do return end

    ::lbl_25::

    L1_2 = Config

    L1_2 = L1_2.DisableFocusTalking

    if L1_2 then

      L1_2 = IsDisabledControlPressed

      L2_2 = 0

      L3_2 = 249

      L1_2 = L1_2(L2_2, L3_2)

      if L1_2 then

        goto lbl_41

      end

    end

    L1_2 = IsDisabledControlJustReleased

    L2_2 = 0

    L3_2 = 249

    L1_2 = L1_2(L2_2, L3_2)

    ::lbl_41::

    if L1_2 then

      L1_2 = debugprint

      L2_2 = "PTT is pressed, waiting before toggling focus"

      L1_2(L2_2)

      L1_2 = true

      L11_1 = L1_2

      while true do

        L1_2 = IsDisabledControlPressed

        L2_2 = 0

        L3_2 = 249

        L1_2 = L1_2(L2_2, L3_2)

        if not L1_2 then

          L1_2 = IsDisabledControlJustReleased

          L2_2 = 0

          L3_2 = 249

          L1_2 = L1_2(L2_2, L3_2)

          if not L1_2 then

            break

          end

        end

        L1_2 = Wait

        L2_2 = 0

        L1_2(L2_2)

      end

      L1_2 = false

      L11_1 = L1_2

    end

    L1_2 = L1_1

    L1_2 = L1_2()

    L2_2 = SetNuiFocus

    L3_2 = not L1_2

    L4_2 = not L1_2

    L2_2(L3_2, L4_2)

    if not L1_2 then

      L2_2 = SetNuiFocusKeepInput

      L3_2 = Config

      L3_2 = L3_2.KeepInput

      L2_2(L3_2)

    else

      L2_2 = SetNuiFocusKeepInput

      L3_2 = false

      L2_2(L3_2)

    end

  elseif "StopSounds" == A0_2 then

    L1_2 = SendReactMessage

    L2_2 = "stopSounds"

    L1_2(L2_2)

  end

  if "AnswerCall" == A0_2 or "DeclineCall" == A0_2 then

    L1_2 = CanOpenPhone

    if L1_2 then

      L1_2 = CanOpenPhone

      L1_2 = L1_2()

      if not L1_2 then

        L1_2 = debugprint

        L2_2 = "CanOpenPhone returned false, not answering/declining call"

        L1_2(L2_2)

        return

    end

    else

      L1_2 = ValidateChecks

      L2_2 = "openPhone"

      L1_2 = L1_2(L2_2)

      if not L1_2 then

        L1_2 = debugprint

        L2_2 = "ValidateChecks returned false for openPhone, not answering/declining call"

        L1_2(L2_2)

        return

      end

    end

    if "AnswerCall" == A0_2 then

      L1_2 = SendReactMessage

      L2_2 = "usedCommand"

      L3_2 = "answer"

      L1_2(L2_2, L3_2)

    elseif "DeclineCall" == A0_2 then

      L1_2 = SendReactMessage

      L2_2 = "usedCommand"

      L3_2 = "decline"

      L1_2(L2_2, L3_2)

    end

  end

  if "TakePhoto" == A0_2 then

    L1_2 = SendReactMessage

    L2_2 = "camera:usedCommand"

    L3_2 = "toggleTaking"

    L1_2(L2_2, L3_2)

  elseif "ToggleFlash" == A0_2 then

    L1_2 = SendReactMessage

    L2_2 = "camera:usedCommand"

    L3_2 = "toggleFlash"

    L1_2(L2_2, L3_2)

  elseif "LeftMode" == A0_2 then

    L1_2 = SendReactMessage

    L2_2 = "camera:usedCommand"

    L3_2 = "leftMode"

    L1_2(L2_2, L3_2)

  elseif "RightMode" == A0_2 then

    L1_2 = SendReactMessage

    L2_2 = "camera:usedCommand"

    L3_2 = "rightMode"

    L1_2(L2_2, L3_2)

  elseif "FlipCamera" == A0_2 then

    L1_2 = SendReactMessage

    L2_2 = "camera:usedCommand"

    L3_2 = "toggleFlip"

    L1_2(L2_2, L3_2)

  end

end

L12_1(L13_1, L14_1)

L12_1 = pairs

L13_1 = Config

L13_1 = L13_1.KeyBinds

L12_1, L13_1, L14_1, L15_1 = L12_1(L13_1)

for L16_1, L17_1 in L12_1, L13_1, L14_1, L15_1 do

  L18_1 = L17_1.Command

  if not L18_1 then

  else

    L18_1 = L17_1.Command

    L19_1 = L18_1

    L18_1 = L18_1.lower

    L18_1 = L18_1(L19_1)

    L17_1.Command = L18_1

    L18_1 = L17_1.Bind

    if L18_1 then

      L18_1 = AddKeyBind

      L19_1 = {}

      L20_1 = L17_1.Command

      L19_1.name = L20_1

      L20_1 = L17_1.Description

      if not L20_1 then

        L20_1 = "no description"

      end

      L19_1.description = L20_1

      L20_1 = L17_1.Bind

      L19_1.defaultKey = L20_1

      L20_1 = L17_1.Mapper

      L19_1.defaultMapper = L20_1

      L20_1 = L17_1.SecondaryBind

      L19_1.secondaryKey = L20_1

      L20_1 = L17_1.SecondaryMapper

      L19_1.secondaryMapper = L20_1

      function L20_1()

        local L0_2, L1_2, L2_2

        L0_2 = TriggerEvent

        L1_2 = "lb-phone:keyPressed"

        L2_2 = L16_1

        L0_2(L1_2, L2_2)

      end

      L19_1.onPress = L20_1

      function L20_1(A0_2)

        local L1_2, L2_2, L3_2, L4_2

        L1_2 = TriggerEvent

        L2_2 = "lb-tablet:keyReleased"

        L3_2 = L16_1

        L4_2 = A0_2

        L1_2(L2_2, L3_2, L4_2)

      end

      L19_1.onRelease = L20_1

      L18_1 = L18_1(L19_1)

      L17_1.bindData = L18_1

    else

      L18_1 = RegisterCommand

      L19_1 = L17_1.Command

      function L20_1()

        local L0_2, L1_2, L2_2, L3_2

        L0_2 = TriggerEvent

        L1_2 = "lb-phone:keyPressed"

        L2_2 = L16_1

        L0_2(L1_2, L2_2)

        L0_2 = Wait

        L1_2 = 0

        L0_2(L1_2)

        L0_2 = TriggerEvent

        L1_2 = "lb-phone:keyReleased"

        L2_2 = L16_1

        L3_2 = 0

        L0_2(L1_2, L2_2, L3_2)

      end

      L21_1 = false

      L18_1(L19_1, L20_1, L21_1)

    end

  end

end

L12_1 = RegisterNUICallback

L13_1 = "finishedSetup"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = phoneData

  if L2_2 then

    L2_2 = phoneData

    L2_2.isSetup = true

  end

  L2_2 = SendReactMessage

  L3_2 = "setName"

  L4_2 = A0_2.name

  L2_2(L3_2, L4_2)

  L2_2 = TriggerServerEvent

  L3_2 = "phone:setName"

  L4_2 = A0_2.name

  L2_2(L3_2, L4_2)

  L2_2 = TriggerServerEvent

  L3_2 = "phone:togglePhone"

  L4_2 = phoneOpen

  L2_2(L3_2, L4_2)

  L2_2 = TriggerServerEvent

  L3_2 = "phone:finishedSetup"

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

  L2_2 = Config

  L2_2 = L2_2.AutoBackup

  if L2_2 then

    L2_2 = TriggerCallback

    L3_2 = "backup:createBackup"

    L2_2(L3_2)

  end

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNUICallback

L13_1 = "isAdmin"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = TriggerCallback

  L3_2 = "isAdmin"

  L4_2 = A1_2

  L2_2(L3_2, L4_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNUICallback

L13_1 = "setPhoneName"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = phoneData

  if L2_2 then

    L2_2 = L2_2.isSetup

  end

  if L2_2 then

    L2_2 = settings

    if L2_2 then

      L2_2 = settings

      L2_2.name = A0_2

    end

    L2_2 = TriggerServerEvent

    L3_2 = "phone:setName"

    L4_2 = A0_2

    L2_2(L3_2, L4_2)

  end

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNUICallback

L13_1 = "setSettings"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = debugprint

  L3_2 = "setSettings triggered"

  L2_2(L3_2)

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

  L2_2 = phoneData

  if not L2_2 then

    L2_2 = print

    L3_2 = "setSettings triggered, but phoneData is nil"

    L2_2(L3_2)

    return

  end

  if A0_2 and type(A0_2) == "table" and A0_2.apps and type(A0_2.apps) == "table" then
    for i, group in pairs(A0_2.apps) do
      if type(group) == "table" then
        for j, val in pairs(group) do
          if val == "Music" or val == "music" then
            group[j] = "spotify"
          end
        end
      end
    end
  end

  settings = A0_2

  L2_2 = phoneData

  L3_2 = settings

  L2_2.settings = L3_2

  L2_2 = AwaitCallback

  L3_2 = "setSettings"

  L4_2 = settings

  L2_2(L3_2, L4_2)

  L2_2 = SetCallVolume

  L3_2 = settings

  if L3_2 then

    L3_2 = L3_2.sound

    if L3_2 then

      L3_2 = L3_2.callVolume

    end

  end

  L2_2(L3_2)

  L2_2 = TriggerEvent

  L3_2 = "lb-phone:settingsUpdated"

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

  L2_2 = SendReactMessage

  L3_2 = "customApp:sendMessage"

  L4_2 = {}

  L4_2.identifier = "any"

  L5_2 = {}

  L5_2.type = "settingsUpdated"

  L6_2 = settings

  L5_2.settings = L6_2

  L5_2.action = "settingsUpdated"

  L5_2.data = A0_2

  L4_2.message = L5_2

  L2_2(L3_2, L4_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNUICallback

L13_1 = "setCursorLocation"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L2_2 = A0_2.x

  L3_2 = A0_2.y

  L4_2 = GetActiveScreenResolution

  L4_2, L5_2 = L4_2()

  L6_2 = SetCursorLocation

  L7_2 = L2_2 / L4_2

  L8_2 = L3_2 / L5_2

  L6_2(L7_2, L8_2)

  L6_2 = A1_2

  L7_2 = "ok"

  L6_2(L7_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNUICallback

L13_1 = "exitFocus"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = debugprint

  L3_2 = "exitFocus triggered"

  L2_2(L3_2)

  L2_2 = SetNuiFocus

  L3_2 = false

  L4_2 = false

  L2_2(L3_2, L4_2)

  L2_2 = ToggleOpen

  L3_2 = false

  L2_2(L3_2)

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNUICallback

L13_1 = "getLocales"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = A1_2

  L3_2 = Config

  L3_2 = L3_2.Locales

  if not L3_2 then

    L3_2 = {}

    L3_2.en = "English"

  end

  L2_2(L3_2)

end

L12_1(L13_1, L14_1)

L12_1 = RegisterNUICallback

L13_1 = "setOnScreen"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  A0_2 = true == A0_2

  L2_2 = PhoneOnScreen

  if A0_2 ~= L2_2 then

    L2_2 = TriggerEvent

    L3_2 = "lb-phone:setOnScreen"

    L4_2 = A0_2

    L2_2(L3_2, L4_2)

    PhoneOnScreen = A0_2

  end

  L2_2 = A1_2

  L3_2 = "ok"

  L2_2(L3_2)

end

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "IsPhoneOnScreen"

function L14_1()

  local L0_2, L1_2

  L0_2 = PhoneOnScreen

  return L0_2

end

L12_1(L13_1, L14_1)

function L12_1(A0_2, A1_2)

  local L2_2, L3_2

  L2_2 = SendNUIMessage

  L3_2 = {}

  L3_2.action = A0_2

  L3_2.data = A1_2

  L2_2(L3_2)

end

SendReactMessage = L12_1

L12_1 = CreateThread

function L13_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2

  L0_2 = {}

  L1_2 = debugprint

  L2_2 = "Waiting for currentPhone to be set before updating time & service"

  L1_2(L2_2)

  while true do

    L1_2 = currentPhone

    if L1_2 then

      break

    end

    L1_2 = Wait

    L2_2 = 500

    L1_2(L2_2)

  end

  L1_2 = SendReactMessage

  L2_2 = "updateService"

  L3_2 = GetServiceBars

  L3_2, L4_2 = L3_2()

  L1_2(L2_2, L3_2, L4_2)

  L1_2 = debugprint

  L2_2 = "currentPhone is set, updating time & service"

  L1_2(L2_2)

  while true do

    L1_2 = Config

    L1_2 = L1_2.RealTime

    if L1_2 then

      break

    end

    L1_2 = Config

    L1_2 = L1_2.CustomTime

    if L1_2 then

      L1_2 = Config

      L1_2 = L1_2.CustomTime

      L1_2 = L1_2()

      if L1_2 then

        goto lbl_42

      end

    end

    L1_2 = {}

    L2_2 = GetClockHours

    L2_2 = L2_2()

    L1_2.hour = L2_2

    L2_2 = GetClockMinutes

    L2_2 = L2_2()

    L1_2.minute = L2_2

    ::lbl_42::

    L2_2 = L1_2.hour

    L3_2 = L0_2.hour

    if L2_2 == L3_2 then

      L2_2 = L1_2.minute

      L3_2 = L0_2.minute

      if L2_2 == L3_2 then

        goto lbl_58

      end

    end

    L2_2 = L1_2.hour

    L0_2.hour = L2_2

    L2_2 = L1_2.minute

    L0_2.minute = L2_2

    L2_2 = SendReactMessage

    L3_2 = "updateTime"

    L4_2 = L1_2

    L2_2(L3_2, L4_2)

    ::lbl_58::

    L2_2 = Wait

    L3_2 = 1000

    L2_2(L3_2)

  end

end

L12_1(L13_1)

function L12_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = LoadResourceFile

  L2_2 = GetCurrentResourceName

  L2_2 = L2_2()

  L3_2 = "config/"

  L4_2 = A0_2

  L3_2 = L3_2 .. L4_2

  return L1_2(L2_2, L3_2)

end

GetConfigFile = L12_1

L12_1 = RegisterNUICallback

L13_1 = "getConfigFile"

function L14_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = GetConfigFile

  L3_2 = A0_2

  L4_2 = ".json"

  L3_2 = L3_2 .. L4_2

  L2_2 = L2_2(L3_2)

  L3_2 = json

  L3_2 = L3_2.decode

  L4_2 = L2_2

  L3_2 = L3_2(L4_2)

  L4_2 = A1_2

  L5_2 = L3_2

  L4_2(L5_2)

end

L12_1(L13_1, L14_1)

L12_1 = {}

L13_1 = vector3

L14_1 = 0.0

L15_1 = 0.0

L16_1 = 0.0

L13_1 = L13_1(L14_1, L15_1, L16_1)

L14_1 = 0

function L15_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2

  L0_2 = GetEntityCoords

  L1_2 = PlayerPedId

  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L1_2()

  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)

  L1_2 = GetActivePlayers

  L1_2 = L1_2()

  L2_2 = {}

  L3_2 = 1

  L4_2 = #L1_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = L1_2[L6_2]

    L8_2 = PlayerId

    L8_2 = L8_2()

    if L7_2 == L8_2 then

    else

      L8_2 = GetPlayerPed

      L9_2 = L7_2

      L8_2 = L8_2(L9_2)

      L9_2 = GetEntityCoords

      L10_2 = L8_2

      L9_2 = L9_2(L10_2)

      L10_2 = L0_2 - L9_2

      L10_2 = #L10_2

      if L10_2 > 50.0 then

      else

        L10_2 = #L2_2

        L10_2 = L10_2 + 1

        L11_2 = {}

        L11_2.player = L7_2

        L12_2 = GetPlayerServerId

        L13_2 = L7_2

        L12_2 = L12_2(L13_2)

        L11_2.source = L12_2

        L11_2.ped = L8_2

        L11_2.coords = L9_2

        L2_2[L10_2] = L11_2

      end

    end

  end

  L12_1 = L2_2

end

function L16_1()

  local L0_2, L1_2

  L0_2 = GetGameTimer

  L0_2 = L0_2()

  L1_2 = L14_1

  L0_2 = L0_2 - L1_2

  L1_2 = 5000

  if not (L0_2 > L1_2) then

    L0_2 = GetEntityCoords

    L1_2 = PlayerPedId

    L1_2 = L1_2()

    L0_2 = L0_2(L1_2)

    L1_2 = L13_1

    L0_2 = L0_2 - L1_2

    L0_2 = #L0_2

    if not (L0_2 > 25.0) then

      goto lbl_29

    end

  end

  L0_2 = GetGameTimer

  L0_2 = L0_2()

  L14_1 = L0_2

  L0_2 = GetEntityCoords

  L1_2 = PlayerPedId

  L1_2 = L1_2()

  L0_2 = L0_2(L1_2)

  L13_1 = L0_2

  L0_2 = L15_1

  L0_2()

  ::lbl_29::

  L0_2 = L12_1

  return L0_2

end

GetNearbyPlayers = L16_1

function L16_1()

  local L0_2, L1_2, L2_2

  L0_2 = debugprint

  L1_2 = "LogOut triggered"

  L0_2(L1_2)

  while true do

    L0_2 = L5_1

    if not L0_2 then

      break

    end

    L0_2 = debugprint

    L1_2 = "LogOut triggered, waiting for fetchingPhone to finish..."

    L0_2(L1_2)

    L0_2 = Wait

    L1_2 = 500

    L0_2(L1_2)

  end

  L0_2 = ResetSecurity

  L0_2()

  L0_2 = OnDeath

  L0_2()

  phoneData = nil

  currentPhone = nil

  settings = nil

  L0_2 = TriggerEvent

  L1_2 = "lb-phone:numberChanged"

  L2_2 = nil

  L0_2(L1_2, L2_2)

  L0_2 = TriggerCallback

  L1_2 = "setLastPhone"

  L0_2(L1_2)

end

LogOut = L16_1

function L16_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = debugprint

  L3_2 = "SetPhone triggered"

  L4_2 = A0_2

  L5_2 = A1_2

  L2_2(L3_2, L4_2, L5_2)

  while true do

    L2_2 = L5_1

    if not L2_2 then

      break

    end

    L2_2 = debugprint

    L3_2 = "SetPhone triggered, waiting for fetchingPhone to finish..."

    L2_2(L3_2)

    L2_2 = Wait

    L3_2 = 500

    L2_2(L3_2)

  end

  L2_2 = OnDeath

  L2_2()

  L2_2 = AwaitCallback

  L3_2 = "setLastPhone"

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

  L2_2 = ResetSecurity

  L3_2 = true

  L2_2(L3_2)

  L2_2 = ToggleCharging

  L3_2 = false

  L2_2(L3_2)

  phoneData = nil

  currentPhone = nil

  settings = nil

  L2_2 = TriggerEvent

  L3_2 = "lb-phone:numberChanged"

  L4_2 = nil

  L2_2(L3_2, L4_2)

  if A0_2 or A1_2 then

    L2_2 = FetchPhone

    L2_2()

  end

  if nil == A0_2 and not A1_2 then

    L2_2 = GetFirstNumber

    L2_2 = L2_2()

    if L2_2 then

      L3_2 = SetPhone

      L4_2 = L2_2

      L3_2(L4_2)

    end

  end

end

SetPhone = L16_1

function L16_1()

  local L0_2, L1_2, L2_2, L3_2

  L0_2 = debugprint

  L1_2 = "OnDeath triggered"

  L0_2(L1_2)

  L0_2 = IsWatchingLive

  L0_2 = L0_2()

  L1_2 = EndLive

  L1_2()

  if L0_2 then

    L1_2 = SendReactMessage

    L2_2 = "instagram:liveEnded"

    L3_2 = L0_2

    L1_2(L2_2, L3_2)

  end

  L1_2 = flashlightEnabled

  if L1_2 then

    flashlightEnabled = false

    L1_2 = TriggerServerEvent

    L2_2 = "phone:toggleFlashlight"

    L3_2 = false

    L1_2(L2_2, L3_2)

  end

  L1_2 = EndCall

  L1_2()

  L1_2 = ToggleOpen

  L2_2 = false

  L1_2(L2_2)

end

OnDeath = L16_1

L16_1 = RegisterNetEvent

L17_1 = "phone:toggleOpen"

L18_1 = ToggleOpen

L16_1(L17_1, L18_1)

L16_1 = exports

L17_1 = "ToggleOpen"

L18_1 = ToggleOpen

L16_1(L17_1, L18_1)

L16_1 = exports

L17_1 = "IsOpen"

function L18_1()

  local L0_2, L1_2

  L0_2 = phoneOpen

  return L0_2

end

L16_1(L17_1, L18_1)

L16_1 = exports

L17_1 = "IsDisabled"

function L18_1()

  local L0_2, L1_2

  L0_2 = phoneDisabled

  return L0_2

end

L16_1(L17_1, L18_1)

L16_1 = exports

L17_1 = "ToggleDisabled"

function L18_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = true == A0_2

  phoneDisabled = L1_2

  L1_2 = debugprint

  L2_2 = "ToggleDisabled triggered"

  L3_2 = phoneDisabled

  L1_2(L2_2, L3_2)

  L1_2 = phoneDisabled

  if L1_2 then

    L1_2 = phoneOpen

    if L1_2 then

      L1_2 = ToggleOpen

      L2_2 = false

      L1_2(L2_2)

    end

  end

end

L16_1(L17_1, L18_1)

L16_1 = exports

L17_1 = "GetSettings"

function L18_1()

  local L0_2, L1_2

  L0_2 = settings

  return L0_2

end

L16_1(L17_1, L18_1)

L16_1 = exports

L17_1 = "GetAirplaneMode"

function L18_1()

  local L0_2, L1_2

  L0_2 = settings

  if L0_2 then

    L0_2 = L0_2.airplaneMode

  end

  return L0_2

end

L16_1(L17_1, L18_1)

L16_1 = exports

L17_1 = "GetStreamerMode"

function L18_1()

  local L0_2, L1_2

  L0_2 = settings

  if L0_2 then

    L0_2 = L0_2.streamerMode

  end

  return L0_2

end

L16_1(L17_1, L18_1)

L16_1 = exports

L17_1 = "GetEquippedPhoneNumber"

function L18_1()

  local L0_2, L1_2

  L0_2 = currentPhone

  return L0_2

end

L16_1(L17_1, L18_1)