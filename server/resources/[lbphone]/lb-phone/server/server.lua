local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1

function L0_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L1_2 = ""

  L2_2 = 1

  L3_2 = A0_2 or L3_2

  if not A0_2 then

    L3_2 = 15

  end

  L4_2 = 1

  for L5_2 = L2_2, L3_2, L4_2 do

    L6_2 = math

    L6_2 = L6_2.random

    L7_2 = 1

    L8_2 = 2

    L6_2 = L6_2(L7_2, L8_2)

    if 1 == L6_2 then

      L6_2 = string

      L6_2 = L6_2.char

      L7_2 = math

      L7_2 = L7_2.random

      L8_2 = 97

      L9_2 = 122

      L7_2 = L7_2(L8_2, L9_2)

      L6_2 = L6_2(L7_2)

      L7_2 = math

      L7_2 = L7_2.random

      L8_2 = 1

      L9_2 = 2

      L7_2 = L7_2(L8_2, L9_2)

      if 1 == L7_2 then

        L8_2 = L6_2

        L7_2 = L6_2.upper

        L7_2 = L7_2(L8_2)

        L6_2 = L7_2

      end

      L7_2 = L1_2

      L8_2 = L6_2

      L7_2 = L7_2 .. L8_2

      L1_2 = L7_2

    else

      L6_2 = L1_2

      L7_2 = math

      L7_2 = L7_2.random

      L8_2 = 1

      L9_2 = 9

      L7_2 = L7_2(L8_2, L9_2)

      L6_2 = L6_2 .. L7_2

      L1_2 = L6_2

    end

  end

  return L1_2

end

GenerateString = L0_1

function L0_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L2_2 = nil

  L3_2 = nil

  while not L2_2 do

    L4_2 = GenerateString

    L5_2 = 5

    L4_2 = L4_2(L5_2)

    L3_2 = L4_2

    L4_2 = MySQL

    L4_2 = L4_2.Sync

    L4_2 = L4_2.fetchScalar

    L5_2 = "SELECT `"

    L6_2 = A1_2

    L7_2 = "` FROM `"

    L8_2 = A0_2

    L9_2 = "` WHERE `"

    L10_2 = A1_2

    L11_2 = "` = @id"

    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2

    L6_2 = {}

    L6_2["@id"] = L3_2

    L4_2 = L4_2(L5_2, L6_2)

    L2_2 = nil == L4_2

    if not L2_2 then

      L4_2 = Wait

      L5_2 = 50

      L4_2(L5_2)

    end

  end

  return L3_2

end

GenerateId = L0_1

function L0_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L0_2 = Config

  L0_2 = L0_2.PhoneNumber

  L0_2 = L0_2.Prefixes

  L1_2 = nil

  L2_2 = nil

  while not L1_2 do

    L3_2 = ""

    L4_2 = 1

    L5_2 = Config

    L5_2 = L5_2.PhoneNumber

    L5_2 = L5_2.Length

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = L3_2

      L9_2 = math

      L9_2 = L9_2.random

      L10_2 = 0

      L11_2 = 9

      L9_2 = L9_2(L10_2, L11_2)

      L8_2 = L8_2 .. L9_2

      L3_2 = L8_2

    end

    L4_2 = #L0_2

    if 0 == L4_2 then

      L2_2 = L3_2

    else

      L4_2 = math

      L4_2 = L4_2.random

      L5_2 = 1

      L6_2 = #L0_2

      L4_2 = L4_2(L5_2, L6_2)

      L4_2 = L0_2[L4_2]

      L5_2 = L3_2

      L4_2 = L4_2 .. L5_2

      L2_2 = L4_2

    end

    L4_2 = MySQL

    L4_2 = L4_2.Sync

    L4_2 = L4_2.fetchScalar

    L5_2 = "SELECT phone_number FROM phone_phones WHERE phone_number = @number"

    L6_2 = {}

    L6_2["@number"] = L2_2

    L4_2 = L4_2(L5_2, L6_2)

    L1_2 = nil == L4_2

    if not L1_2 then

      L4_2 = Wait

      L5_2 = 0

      L4_2(L5_2)

    end

  end

  return L2_2

end

GeneratePhoneNumber = L0_1

L0_1 = {}

L1_1 = {}

L2_1 = {}

L3_1 = {}

function L4_1(A0_2)

  local L1_2

  L1_2 = L2_1

  L1_2 = L1_2[A0_2]

  return L1_2

end

GetSettings = L4_1

L4_1 = exports

L5_1 = "GetSettings"

L6_1 = GetSettings

L4_1(L5_1, L6_1)

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  if not A1_2 then

    L2_2 = L3_1

    L2_2 = L2_2[A0_2]

    if L2_2 then

      L2_2 = L3_1

      L2_2[A0_2] = nil

      L2_2 = Config

      L2_2 = L2_2.CacheSettings

      if false ~= L2_2 then

        L2_2 = debugprint

        L3_2 = "Updating settings in database for"

        L4_2 = A0_2

        L2_2(L3_2, L4_2)

        L2_2 = MySQL

        L2_2 = L2_2.update

        L3_2 = "UPDATE phone_phones SET settings = ? WHERE phone_number = ?"

        L4_2 = {}

        L5_2 = json

        L5_2 = L5_2.encode

        L6_2 = L2_1

        L6_2 = L6_2[A0_2]

        L5_2 = L5_2(L6_2)

        L6_2 = A0_2

        L4_2[1] = L5_2

        L4_2[2] = L6_2

        L2_2(L3_2, L4_2)

      end

    end

  end

  L2_2 = L2_1

  L2_2[A0_2] = A1_2

end

SetSettings = L4_1

function L4_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L0_2 = Config

  L0_2 = L0_2.CacheSettings

  if false == L0_2 then

    return

  end

  L0_2 = infoprint

  L1_2 = "info"

  L2_2 = "Saving all settings"

  L0_2(L1_2, L2_2)

  L0_2 = pairs

  L1_2 = L2_1

  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)

  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do

    L6_2 = L3_1

    L6_2 = L6_2[L4_2]

    if L6_2 then

      L6_2 = MySQL

      L6_2 = L6_2.update

      L7_2 = "UPDATE phone_phones SET settings = ? WHERE phone_number = ?"

      L8_2 = {}

      L9_2 = json

      L9_2 = L9_2.encode

      L10_2 = L5_2

      L9_2 = L9_2(L10_2)

      L10_2 = L4_2

      L8_2[1] = L9_2

      L8_2[2] = L10_2

      L6_2(L7_2, L8_2)

    else

      L6_2 = debugprint

      L7_2 = "Not saving settings for"

      L8_2 = L4_2

      L9_2 = "because no changes were made"

      L6_2(L7_2, L8_2, L9_2)

    end

  end

end

SaveAllSettings = L4_1

L4_1 = RegisterLegacyCallback

L5_1 = "playerLoaded"

function L6_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L2_2 = GetIdentifier

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  if not L2_2 then

    L3_2 = debugprint

    L4_2 = "playerLoaded: no identifier for source"

    L5_2 = A0_2

    L3_2(L4_2, L5_2)

    L3_2 = A1_2

    return L3_2()

  end

  L3_2 = debugprint

  L4_2 = GetPlayerName

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L5_2 = A0_2

  L6_2 = L2_2

  L7_2 = "triggered phone:playerLoaded"

  L3_2(L4_2, L5_2, L6_2, L7_2)

  L3_2 = Config

  L3_2 = L3_2.Item

  L3_2 = L3_2.Unique

  if not L3_2 then

    L3_2 = MySQL

    L3_2 = L3_2.scalar

    L3_2 = L3_2.await

    L4_2 = "SELECT phone_number FROM phone_phones WHERE id = ?"

    L5_2 = {}

    L6_2 = L2_2

    L5_2[1] = L6_2

    L3_2 = L3_2(L4_2, L5_2)

    if L3_2 then

      L4_2 = HasPhoneItem

      L5_2 = A0_2

      L6_2 = L3_2

      L4_2 = L4_2(L5_2, L6_2)

      if L4_2 then

        L4_2 = L0_1

        L4_2[L3_2] = A0_2

        L4_2 = L1_1

        L4_2[A0_2] = L3_2

        L4_2 = TriggerEvent

        L5_2 = "lb-phone:numberChanged"

        L6_2 = A0_2

        L7_2 = L3_2

        L4_2(L5_2, L6_2, L7_2)

        L4_2 = MySQL

        L4_2 = L4_2.update

        L5_2 = "UPDATE phone_phones SET last_seen = CURRENT_TIMESTAMP WHERE phone_number = ?"

        L6_2 = {}

        L7_2 = L3_2

        L6_2[1] = L7_2

        L4_2(L5_2, L6_2)

      end

    end

    L4_2 = A1_2

    L5_2 = L3_2

    return L4_2(L5_2)

  end

  L3_2 = MySQL

  L3_2 = L3_2.scalar

  L3_2 = L3_2.await

  L4_2 = "SELECT phone_number FROM phone_last_phone WHERE id = ?"

  L5_2 = {}

  L6_2 = L2_2

  L5_2[1] = L6_2

  L3_2 = L3_2(L4_2, L5_2)

  L4_2 = debugprint

  L5_2 = "result from phone_last_phone: "

  L6_2 = L3_2

  L4_2(L5_2, L6_2)

  if L3_2 then

    L4_2 = debugprint

    L5_2 = "checking if "

    L6_2 = A0_2

    L7_2 = " has phone with metadata for last phone number equipped"

    L5_2 = L5_2 .. L6_2 .. L7_2

    L4_2(L5_2)

    L4_2 = HasPhoneItem

    L5_2 = A0_2

    L6_2 = L3_2

    L4_2 = L4_2(L5_2, L6_2)

    if L4_2 then

      L4_2 = debugprint

      L5_2 = A0_2

      L6_2 = "has phone with metadata"

      L5_2 = L5_2 .. L6_2

      L4_2(L5_2)

      L4_2 = L0_1

      L4_2[L3_2] = A0_2

      L4_2 = L1_1

      L4_2[A0_2] = L3_2

      L4_2 = TriggerEvent

      L5_2 = "lb-phone:numberChanged"

      L6_2 = A0_2

      L7_2 = L3_2

      L4_2(L5_2, L6_2, L7_2)

      L4_2 = MySQL

      L4_2 = L4_2.update

      L5_2 = "UPDATE phone_phones SET last_seen = CURRENT_TIMESTAMP WHERE phone_number = ?"

      L6_2 = {}

      L7_2 = L3_2

      L6_2[1] = L7_2

      L4_2(L5_2, L6_2)

      L4_2 = A1_2

      L5_2 = L3_2

      return L4_2(L5_2)

    end

    L4_2 = debugprint

    L5_2 = A0_2

    L6_2 = " doesn't have phone with metadata for last phone number equipped"

    L5_2 = L5_2 .. L6_2

    L4_2(L5_2)

    L4_2 = A1_2

    return L4_2()

  end

  L4_2 = debugprint

  L5_2 = "checking if "

  L6_2 = A0_2

  L7_2 = " has an empty phone"

  L5_2 = L5_2 .. L6_2 .. L7_2

  L4_2(L5_2)

  L4_2 = HasPhoneItem

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  if not L4_2 then

    L4_2 = debugprint

    L5_2 = A0_2

    L6_2 = " does not have an empty phone"

    L5_2 = L5_2 .. L6_2

    L4_2(L5_2)

    L4_2 = A1_2

    return L4_2()

  end

  L4_2 = debugprint

  L5_2 = A0_2

  L6_2 = " does have an empty phone, checking if they have an existing phone from pre-unique phone"

  L5_2 = L5_2 .. L6_2

  L4_2(L5_2)

  L4_2 = MySQL

  L4_2 = L4_2.scalar

  L4_2 = L4_2.await

  L5_2 = "SELECT phone_number FROM phone_phones WHERE id = ? AND assigned = FALSE"

  L6_2 = {}

  L7_2 = L2_2

  L6_2[1] = L7_2

  L4_2 = L4_2(L5_2, L6_2)

  if L4_2 then

    L5_2 = SetPhoneNumber

    L6_2 = A0_2

    L7_2 = L4_2

    L5_2 = L5_2(L6_2, L7_2)

    if L5_2 then

      goto lbl_174

    end

  end

  L5_2 = debugprint

  L6_2 = A0_2

  L7_2 = " does not have an existing phone from pre-unique phone, or failed to set number to item metadata"

  L6_2 = L6_2 .. L7_2

  L5_2(L6_2)

  L5_2 = A1_2

  do return L5_2() end

  ::lbl_174::

  L5_2 = debugprint

  L6_2 = A0_2

  L7_2 = " does have an existing phone from pre-unique phone"

  L6_2 = L6_2 .. L7_2

  L5_2(L6_2)

  L5_2 = MySQL

  L5_2 = L5_2.update

  L6_2 = "UPDATE phone_phones SET assigned = TRUE, last_seen = CURRENT_TIMESTAMP WHERE phone_number = ?"

  L7_2 = {}

  L8_2 = L4_2

  L7_2[1] = L8_2

  L5_2(L6_2, L7_2)

  L5_2 = MySQL

  L5_2 = L5_2.update

  L6_2 = "INSERT INTO phone_last_phone (id, phone_number) VALUES (?, ?)"

  L7_2 = {}

  L8_2 = L2_2

  L9_2 = L4_2

  L7_2[1] = L8_2

  L7_2[2] = L9_2

  L5_2(L6_2, L7_2)

  L5_2 = L0_1

  L5_2[L4_2] = A0_2

  L5_2 = L1_1

  L5_2[A0_2] = L4_2

  L5_2 = TriggerEvent

  L6_2 = "lb-phone:numberChanged"

  L7_2 = A0_2

  L8_2 = L4_2

  L5_2(L6_2, L7_2, L8_2)

  L5_2 = A1_2

  L6_2 = L4_2

  L5_2(L6_2)

end

L4_1(L5_1, L6_1)

L4_1 = RegisterLegacyCallback

L5_1 = "setLastPhone"

function L6_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L3_2 = GetIdentifier

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  L4_2 = GetEquippedPhoneNumber

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L5_2 = debugprint

  L6_2 = DebugPlayerName

  L7_2 = A0_2

  L6_2 = L6_2(L7_2)

  L7_2 = L3_2

  L8_2 = "triggered phone:setLastPhone. old number:"

  L9_2 = L4_2

  L10_2 = "new number:"

  L11_2 = A2_2

  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)

  L5_2 = SaveBattery

  L6_2 = A0_2

  L5_2(L6_2)

  if not A2_2 then

    if L3_2 then

      L5_2 = MySQL

      L5_2 = L5_2.update

      L6_2 = "DELETE FROM phone_last_phone WHERE id = ?"

      L7_2 = {}

      L8_2 = L3_2

      L7_2[1] = L8_2

      L5_2(L6_2, L7_2)

    end

    if L4_2 then

      L5_2 = L0_1

      L5_2[L4_2] = nil

      L5_2 = L1_1

      L5_2[A0_2] = nil

      L5_2 = TriggerEvent

      L6_2 = "lb-phone:numberChanged"

      L7_2 = A0_2

      L5_2(L6_2, L7_2)

      L5_2 = Player

      L6_2 = A0_2

      L5_2 = L5_2(L6_2)

      L5_2 = L5_2.state

      L5_2.phoneOpen = false

      L5_2.phoneName = nil

      L5_2.phoneNumber = nil

      L6_2 = GetSettings

      L7_2 = L4_2

      L6_2 = L6_2(L7_2)

      if L6_2 then

        L7_2 = SetSettings

        L8_2 = L4_2

        L9_2 = nil

        L7_2(L8_2, L9_2)

      end

    end

    L5_2 = A1_2

    return L5_2()

  end

  if not L3_2 then

    L5_2 = debugprint

    L6_2 = "setLastPhone: no identifier for source"

    L7_2 = A0_2

    L5_2(L6_2, L7_2)

    L5_2 = A1_2

    return L5_2()

  end

  L5_2 = L0_1

  L5_2 = L5_2[A2_2]

  if L5_2 then

    L5_2 = L0_1

    L5_2 = L5_2[A2_2]

    if L5_2 ~= A0_2 then

      L5_2 = A1_2

      return L5_2()

    end

  end

  L5_2 = MySQL

  L5_2 = L5_2.scalar

  L5_2 = L5_2.await

  L6_2 = "SELECT 1 FROM phone_phones WHERE phone_number = ?"

  L7_2 = {}

  L8_2 = A2_2

  L7_2[1] = L8_2

  L5_2 = L5_2(L6_2, L7_2)

  if not L5_2 then

    L5_2 = infoprint

    L6_2 = "warning"

    L7_2 = GetPlayerName

    L8_2 = A0_2

    L7_2 = L7_2(L8_2)

    L8_2 = " | "

    L9_2 = A0_2

    L10_2 = " tried to use a phone with a number that doesn't exist. This usually happens when you delete the phone from phone_phones, without deleting the phone item from the player's inventory. Phone number: "

    L11_2 = A2_2

    L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2

    L5_2(L6_2, L7_2)

    L5_2 = A1_2

    return L5_2()

  end

  L5_2 = MySQL

  L5_2 = L5_2.update

  L5_2 = L5_2.await

  L6_2 = "INSERT INTO phone_last_phone (id, phone_number) VALUES (?, ?) ON DUPLICATE KEY UPDATE phone_number = ?"

  L7_2 = {}

  L8_2 = L3_2

  L9_2 = A2_2

  L10_2 = A2_2

  L7_2[1] = L8_2

  L7_2[2] = L9_2

  L7_2[3] = L10_2

  L5_2(L6_2, L7_2)

  if L4_2 then

    L5_2 = L0_1

    L5_2[L4_2] = nil

    L5_2 = L1_1

    L5_2[A0_2] = nil

    L5_2 = GetSettings

    L6_2 = L4_2

    L5_2 = L5_2(L6_2)

    if L5_2 then

      L6_2 = SetSettings

      L7_2 = L4_2

      L8_2 = nil

      L6_2(L7_2, L8_2)

    end

  end

  L5_2 = L0_1

  L5_2[A2_2] = A0_2

  L5_2 = L1_1

  L5_2[A0_2] = A2_2

  L5_2 = TriggerEvent

  L6_2 = "lb-phone:numberChanged"

  L7_2 = A0_2

  L8_2 = A2_2

  L5_2(L6_2, L7_2, L8_2)

  L5_2 = A1_2

  L5_2()

end

L4_1(L5_1, L6_1)

L4_1 = RegisterLegacyCallback

L5_1 = "generatePhoneNumber"

function L6_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L2_2 = GetIdentifier

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  L3_2 = L2_2

  L4_2 = debugprint

  L5_2 = GetPlayerName

  L6_2 = A0_2

  L5_2 = L5_2(L6_2)

  L6_2 = A0_2

  L7_2 = L2_2

  L8_2 = "wants to generate a phone number"

  L4_2(L5_2, L6_2, L7_2, L8_2)

  L4_2 = Config

  L4_2 = L4_2.Item

  L4_2 = L4_2.Unique

  if L4_2 then

    L4_2 = debugprint

    L5_2 = "unique phones enabled, checking if "

    L6_2 = GetPlayerName

    L7_2 = A0_2

    L6_2 = L6_2(L7_2)

    L7_2 = " has a phone item without a number assigned"

    L5_2 = L5_2 .. L6_2 .. L7_2

    L4_2(L5_2)

    L4_2 = HasPhoneItem

    L5_2 = A0_2

    L4_2 = L4_2(L5_2)

    if not L4_2 then

      L4_2 = debugprint

      L5_2 = GetPlayerName

      L6_2 = A0_2

      L5_2 = L5_2(L6_2)

      L6_2 = " does not have a phone item without a number assigned"

      L5_2 = L5_2 .. L6_2

      L4_2(L5_2)

      L4_2 = A1_2

      return L4_2()

    end

    L4_2 = GenerateId

    L5_2 = "phone_phones"

    L6_2 = "id"

    L4_2 = L4_2(L5_2, L6_2)

    L3_2 = L4_2

  else

    L4_2 = MySQL

    L4_2 = L4_2.scalar

    L4_2 = L4_2.await

    L5_2 = "SELECT phone_number FROM phone_phones WHERE id = ?"

    L6_2 = {}

    L7_2 = L2_2

    L6_2[1] = L7_2

    L4_2 = L4_2(L5_2, L6_2)

    if L4_2 then

      L5_2 = infoprint

      L6_2 = "warning"

      L7_2 = GetPlayerName

      L8_2 = A0_2

      L7_2 = L7_2(L8_2)

      L8_2 = " wants to generate a phone number, but they already have one. Please set Config.Debug to true, and send the full log in customer-support if this happens again."

      L7_2 = L7_2 .. L8_2

      L5_2(L6_2, L7_2)

      L5_2 = L0_1

      L5_2[L4_2] = A0_2

      L5_2 = L1_1

      L5_2[A0_2] = L4_2

      L5_2 = TriggerEvent

      L6_2 = "lb-phone:numberChanged"

      L7_2 = A0_2

      L8_2 = L4_2

      L5_2(L6_2, L7_2, L8_2)

      L5_2 = A1_2

      L6_2 = L4_2

      return L5_2(L6_2)

    end

  end

  L4_2 = GeneratePhoneNumber

  L4_2 = L4_2()

  L5_2 = MySQL

  L5_2 = L5_2.update

  L5_2 = L5_2.await

  L6_2 = "INSERT INTO phone_phones (id, owner_id, phone_number) VALUES (?, ?, ?)"

  L7_2 = {}

  L8_2 = L3_2

  L9_2 = L2_2

  L10_2 = L4_2

  L7_2[1] = L8_2

  L7_2[2] = L9_2

  L7_2[3] = L10_2

  L5_2(L6_2, L7_2)

  L5_2 = TriggerEvent

  L6_2 = "lb-phone:phoneNumberGenerated"

  L7_2 = A0_2

  L8_2 = L4_2

  L5_2(L6_2, L7_2, L8_2)

  L5_2 = Config

  L5_2 = L5_2.Item

  L5_2 = L5_2.Unique

  if L5_2 then

    L5_2 = SetPhoneNumber

    L6_2 = A0_2

    L7_2 = L4_2

    L5_2(L6_2, L7_2)

    L5_2 = MySQL

    L5_2 = L5_2.update

    L5_2 = L5_2.await

    L6_2 = "UPDATE phone_phones SET assigned = TRUE WHERE phone_number = ?"

    L7_2 = {}

    L8_2 = L4_2

    L7_2[1] = L8_2

    L5_2(L6_2, L7_2)

    L5_2 = MySQL

    L5_2 = L5_2.update

    L5_2 = L5_2.await

    L6_2 = "INSERT INTO phone_last_phone (id, phone_number) VALUES (?, ?) ON DUPLICATE KEY UPDATE phone_number = ?"

    L7_2 = {}

    L8_2 = GetIdentifier

    L9_2 = A0_2

    L8_2 = L8_2(L9_2)

    L9_2 = L4_2

    L10_2 = L4_2

    L7_2[1] = L8_2

    L7_2[2] = L9_2

    L7_2[3] = L10_2

    L5_2(L6_2, L7_2)

  end

  L5_2 = L0_1

  L5_2[L4_2] = A0_2

  L5_2 = L1_1

  L5_2[A0_2] = L4_2

  L5_2 = TriggerEvent

  L6_2 = "lb-phone:numberChanged"

  L7_2 = A0_2

  L8_2 = L4_2

  L5_2(L6_2, L7_2, L8_2)

  L5_2 = A1_2

  L6_2 = L4_2

  L5_2(L6_2)

end

L4_1(L5_1, L6_1)

L4_1 = RegisterLegacyCallback

L5_1 = "getPhone"

function L6_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L3_2 = debugprint

  L4_2 = GetPlayerName

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L5_2 = "triggered phone:getPhone. checking if they have an item"

  L3_2(L4_2, L5_2)

  L3_2 = HasPhoneItem

  L4_2 = A0_2

  L5_2 = A2_2

  L3_2 = L3_2(L4_2, L5_2)

  if not L3_2 then

    L3_2 = debugprint

    L4_2 = GetPlayerName

    L5_2 = A0_2

    L4_2 = L4_2(L5_2)

    L5_2 = "does not have an item"

    L3_2(L4_2, L5_2)

    L3_2 = A1_2

    return L3_2()

  end

  L3_2 = debugprint

  L4_2 = GetPlayerName

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L5_2 = "has an item, getting phone data"

  L3_2(L4_2, L5_2)

  L3_2 = MySQL

  L3_2 = L3_2.single

  L3_2 = L3_2.await

  L4_2 = "SELECT owner_id, is_setup, settings, `name`, battery FROM phone_phones WHERE phone_number = ?"

  L5_2 = {}

  L6_2 = A2_2

  L5_2[1] = L6_2

  L3_2 = L3_2(L4_2, L5_2)

  if not L3_2 then

    L4_2 = debugprint

    L5_2 = GetPlayerName

    L6_2 = A0_2

    L5_2 = L5_2(L6_2)

    L6_2 = "does not have any phone data"

    L4_2(L5_2, L6_2)

    L4_2 = A1_2

    return L4_2()

  end

  L4_2 = L3_2.settings

  if L4_2 then

    L4_2 = GetSettings

    L5_2 = A2_2

    L4_2 = L4_2(L5_2)

    L5_2 = L4_2 or L5_2

    if not L4_2 then

      L5_2 = json

      L5_2 = L5_2.decode

      L6_2 = L3_2.settings

      L5_2 = L5_2(L6_2)

    end

    if L5_2 and type(L5_2) == "table" and L5_2.apps and type(L5_2.apps) == "table" then
      local changed = false
      for i, group in pairs(L5_2.apps) do
        if type(group) == "table" then
          for j, val in pairs(group) do
            if val == "Music" or val == "music" then
              group[j] = "spotify"
              changed = true
            end
          end
        end
      end
      if changed and L4_2 then
        SetSettings(A2_2, L5_2)
      end
    end

    L3_2.settings = L5_2

    if not L4_2 then

      L5_2 = SetSettings

      L6_2 = A2_2

      L7_2 = L3_2.settings

      L5_2(L6_2, L7_2)

    end

  end

  L4_2 = Player

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L4_2 = L4_2.state

  L5_2 = L3_2.name

  L4_2.phoneName = L5_2

  L4_2 = debugprint

  L5_2 = GetPlayerName

  L6_2 = A0_2

  L5_2 = L5_2(L6_2)

  L6_2 = "has phone data"

  L4_2(L5_2, L6_2)

  L4_2 = L3_2.owner_id

  if not L4_2 then

    L4_2 = debugprint

    L5_2 = GetPlayerName

    L6_2 = A0_2

    L5_2 = L5_2(L6_2)

    L6_2 = "'s phone does not have an owner, setting owner to "

    L7_2 = GetIdentifier

    L8_2 = A0_2

    L7_2 = L7_2(L8_2)

    L5_2 = L5_2 .. L6_2 .. L7_2

    L4_2(L5_2)

    L4_2 = MySQL

    L4_2 = L4_2.update

    L5_2 = "UPDATE phone_phones SET owner_id = ? WHERE phone_number = ?"

    L6_2 = {}

    L7_2 = GetIdentifier

    L8_2 = A0_2

    L7_2 = L7_2(L8_2)

    L8_2 = A2_2

    L6_2[1] = L7_2

    L6_2[2] = L8_2

    L4_2(L5_2, L6_2)

  end

  L4_2 = A1_2

  L5_2 = L3_2

  return L4_2(L5_2)

end

L4_1(L5_1, L6_1)

function L4_1(A0_2, A1_2)

  local L2_2

  L2_2 = L1_1

  L2_2 = L2_2[A0_2]

  return L2_2

end

GetEquippedPhoneNumber = L4_1

function L4_1(A0_2)

  local L1_2

  if not A0_2 then

    L1_2 = false

    return L1_2

  end

  L1_2 = L0_1

  L1_2 = L1_2[A0_2]

  if not L1_2 then

    L1_2 = false

  end

  return L1_2

end

GetSourceFromNumber = L4_1

L4_1 = exports

L5_1 = "GetSourceFromNumber"

L6_1 = GetSourceFromNumber

L4_1(L5_1, L6_1)

L4_1 = RegisterLegacyCallback

L5_1 = "isAdmin"

function L6_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = A1_2

  L3_2 = IsAdmin

  L4_2 = A0_2

  L3_2, L4_2 = L3_2(L4_2)

  L2_2(L3_2, L4_2)

end

L4_1(L5_1, L6_1)

L4_1 = RegisterLegacyCallback

L5_1 = "getCharacterName"

function L6_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = GetCharacterName

  L3_2 = A0_2

  L2_2, L3_2 = L2_2(L3_2)

  L4_2 = A1_2

  L5_2 = {}

  L5_2.firstname = L2_2

  L5_2.lastname = L3_2

  L4_2(L5_2)

end

L4_1(L5_1, L6_1)

L4_1 = nil

L5_1 = PerformHttpRequest

L6_1 = "https://loaf-scripts.com/versions/phone/version.json"

function L7_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2

  if 200 ~= A0_2 then

    L4_2 = debugprint

    L5_2 = "Failed to get latest script version"

    L4_2(L5_2)

    L4_2 = debugprint

    L5_2 = "Status:"

    L6_2 = A0_2

    L4_2(L5_2, L6_2)

    L4_2 = debugprint

    L5_2 = "Body:"

    L6_2 = A1_2

    L4_2(L5_2, L6_2)

    L4_2 = debugprint

    L5_2 = "Headers:"

    L6_2 = A2_2

    L4_2(L5_2, L6_2)

    L4_2 = debugprint

    L5_2 = "Error:"

    L6_2 = A3_2

    L4_2(L5_2, L6_2)

    return

  end

  L4_2 = json

  L4_2 = L4_2.decode

  L5_2 = A1_2

  L4_2 = L4_2(L5_2)

  L4_2 = L4_2.latest

  L4_1 = L4_2

end

L8_1 = "GET"

L5_1(L6_1, L7_1, L8_1)

L5_1 = RegisterCallback

L6_1 = "getLatestVersion"

function L7_1(A0_2)

  local L1_2

  L1_2 = L4_1

  return L1_2

end

L5_1(L6_1, L7_1)

L5_1 = RegisterNetEvent

L6_1 = "phone:finishedSetup"

function L7_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L1_2 = source

  L2_2 = GetEquippedPhoneNumber

  L3_2 = L1_2

  L2_2 = L2_2(L3_2)

  if not L2_2 then

    return

  end

  L3_2 = SetSettings

  L4_2 = L2_2

  L5_2 = A0_2

  L3_2(L4_2, L5_2)

  L3_2 = MySQL

  L3_2 = L3_2.update

  L4_2 = "UPDATE phone_phones SET is_setup = true, settings = ? WHERE phone_number = ?"

  L5_2 = {}

  L6_2 = json

  L6_2 = L6_2.encode

  L7_2 = A0_2

  L6_2 = L6_2(L7_2)

  L7_2 = L2_2

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L3_2(L4_2, L5_2)

  L3_2 = Config

  L3_2 = L3_2.AutoCreateEmail

  if L3_2 then

    L3_2 = GenerateEmailAccount

    L4_2 = L1_2

    L5_2 = L2_2

    L3_2(L4_2, L5_2)

  end

end

L5_1(L6_1, L7_1)

L5_1 = RegisterNetEvent

L6_1 = "phone:setName"

function L7_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L1_2 = source

  L2_2 = GetEquippedPhoneNumber

  L3_2 = L1_2

  L2_2 = L2_2(L3_2)

  if not L2_2 then

    L3_2 = debugprint

    L4_2 = "phone:setName: no phone number for source"

    L5_2 = L1_2

    L3_2(L4_2, L5_2)

    return

  end

  L3_2 = Config

  L3_2 = L3_2.NameFilter

  if L3_2 then

    L4_2 = A0_2

    L3_2 = A0_2.match

    L5_2 = Config

    L5_2 = L5_2.NameFilter

    L3_2 = L3_2(L4_2, L5_2)

    if not L3_2 then

      L3_2 = infoprint

      L4_2 = "warning"

      L5_2 = "Player "

      L6_2 = GetPlayerName

      L7_2 = L1_2

      L6_2 = L6_2(L7_2)

      L7_2 = " tried to set an invalid phone name: "

      L8_2 = A0_2

      L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2

      L3_2(L4_2, L5_2)

      L3_2 = GetCharacterName

      L4_2 = L1_2

      L3_2, L4_2 = L3_2(L4_2)

      L5_2 = L

      L6_2 = "BACKEND.MISC.X_PHONE"

      L7_2 = {}

      L7_2.name = L3_2

      L7_2.lastname = L4_2

      L5_2 = L5_2(L6_2, L7_2)

      A0_2 = L5_2

    end

  end

  L3_2 = MySQL

  L3_2 = L3_2.Async

  L3_2 = L3_2.execute

  L4_2 = "UPDATE phone_phones SET `name`=@name WHERE phone_number=@phoneNumber"

  L5_2 = {}

  L5_2["@phoneNumber"] = L2_2

  L5_2["@name"] = A0_2

  L3_2(L4_2, L5_2)

  L3_2 = Config

  L3_2 = L3_2.Item

  L3_2 = L3_2.Unique

  if L3_2 then

    L3_2 = SetItemName

    if L3_2 then

      L3_2 = SetItemName

      L4_2 = L1_2

      L5_2 = L2_2

      L6_2 = A0_2

      L3_2(L4_2, L5_2, L6_2)

    end

  end

  L3_2 = GetSettings

  L4_2 = L2_2

  L3_2 = L3_2(L4_2)

  if L3_2 then

    L3_2.name = A0_2

  end

  L4_2 = Player

  L5_2 = L1_2

  L4_2 = L4_2(L5_2)

  L4_2 = L4_2.state

  L4_2.phoneName = A0_2

end

L5_1(L6_1, L7_1)

L5_1 = BaseCallback

L6_1 = "setSettings"

function L7_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = debugprint

  L4_2 = A0_2

  L5_2 = "saving settings for phone number"

  L6_2 = A1_2

  L3_2(L4_2, L5_2, L6_2)

  L3_2 = L3_1

  L3_2[A1_2] = true

  L3_2 = SetSettings

  L4_2 = A1_2

  L5_2 = A2_2

  L3_2(L4_2, L5_2)

  L3_2 = Config

  L3_2 = L3_2.CacheSettings

  if false == L3_2 then

    L3_2 = MySQL

    L3_2 = L3_2.update

    L4_2 = "UPDATE phone_phones SET settings = ? WHERE phone_number = ?"

    L5_2 = {}

    L6_2 = json

    L6_2 = L6_2.encode

    L7_2 = A2_2

    L6_2 = L6_2(L7_2)

    L7_2 = A1_2

    L5_2[1] = L6_2

    L5_2[2] = L7_2

    L3_2(L4_2, L5_2)

  end

end

L5_1(L6_1, L7_1)

L5_1 = RegisterNetEvent

L6_1 = "phone:togglePhone"

function L7_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = source

  L2_2 = Player

  L3_2 = L1_2

  L2_2 = L2_2(L3_2)

  L2_2 = L2_2.state

  L2_2.phoneOpen = A0_2

  L3_2 = GetEquippedPhoneNumber

  L4_2 = L1_2

  L3_2 = L3_2(L4_2)

  if not L3_2 then

    L4_2 = debugprint

    L5_2 = "phone:togglePhone: no phone number for source"

    L6_2 = L1_2

    L4_2(L5_2, L6_2)

    return

  end

  L2_2.phoneNumber = L3_2

end

L5_1(L6_1, L7_1)

L5_1 = RegisterNetEvent

L6_1 = "phone:toggleFlashlight"

function L7_1(A0_2)

  local L1_2, L2_2

  L1_2 = Player

  L2_2 = source

  L1_2 = L1_2(L2_2)

  L1_2 = L1_2.state

  L1_2.flashlight = A0_2

end

L5_1(L6_1, L7_1)

L5_1 = AddEventHandler

L6_1 = "playerDropped"

function L7_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2

  L0_2 = source

  L1_2 = GetEquippedPhoneNumber

  L2_2 = L0_2

  L1_2 = L1_2(L2_2)

  if L1_2 then

    L2_2 = Wait

    L3_2 = 1000

    L2_2(L3_2)

    L2_2 = SetSettings

    L3_2 = L1_2

    L4_2 = nil

    L2_2(L3_2, L4_2)

    L2_2 = L0_1

    L2_2[L1_2] = nil

    L2_2 = L1_1

    L2_2[L0_2] = nil

    L2_2 = TriggerEvent

    L3_2 = "lb-phone:numberChanged"

    L4_2 = L0_2

    L2_2(L3_2, L4_2)

  end

end

L5_1(L6_1, L7_1)

L5_1 = AddEventHandler

L6_1 = "onResourceStop"

function L7_1(A0_2)

  local L1_2

  L1_2 = GetCurrentResourceName

  L1_2 = L1_2()

  if A0_2 ~= L1_2 then

    return

  end

  L1_2 = SaveAllSettings

  L1_2()

end

L5_1(L6_1, L7_1)

L5_1 = AddEventHandler

L6_1 = "txAdmin:events:serverShuttingDown"

function L7_1()

  local L0_2, L1_2

  L0_2 = SaveAllSettings

  L0_2()

end

L5_1(L6_1, L7_1)

function L5_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = MySQL

  L1_2 = L1_2.update

  L1_2 = L1_2.await

  L2_2 = "DELETE FROM phone_logged_in_accounts WHERE phone_number = ?"

  L3_2 = {}

  L4_2 = A0_2

  L3_2[1] = L4_2

  L1_2(L2_2, L3_2)

  L1_2 = MySQL

  L1_2 = L1_2.update

  L1_2 = L1_2.await

  L2_2 = "UPDATE phone_phones SET is_setup = false, settings = NULL, pin = NULL, face_id = NULL WHERE phone_number = ?"

  L3_2 = {}

  L4_2 = A0_2

  L3_2[1] = L4_2

  L1_2 = L1_2(L2_2, L3_2)

  L1_2 = L1_2 > 0

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  if L1_2 and L2_2 then

    L3_2 = TriggerEvent

    L4_2 = "lb-phone:factoryReset"

    L5_2 = L2_2

    L6_2 = A0_2

    L3_2(L4_2, L5_2, L6_2)

    L3_2 = TriggerClientEvent

    L4_2 = "phone:factoryReset"

    L5_2 = L2_2

    L3_2(L4_2, L5_2)

    L3_2 = SetSettings

    L4_2 = A0_2

    L5_2 = nil

    L3_2(L4_2, L5_2)

    L3_2 = L0_1

    L3_2[A0_2] = nil

    L3_2 = L1_1

    L3_2[L2_2] = nil

    L3_2 = TriggerEvent

    L4_2 = "lb-phone:numberChanged"

    L5_2 = L2_2

    L3_2(L4_2, L5_2)

  end

end

L6_1 = RegisterNetEvent

L7_1 = "phone:factoryReset"

function L8_1()

  local L0_2, L1_2, L2_2

  L0_2 = GetEquippedPhoneNumber

  L1_2 = source

  L0_2 = L0_2(L1_2)

  if not L0_2 then

    return

  end

  L1_2 = L5_1

  L2_2 = L0_2

  L1_2(L2_2)

end

L6_1(L7_1, L8_1)

L6_1 = exports

L7_1 = "FactoryReset"

L8_1 = L5_1

L6_1(L7_1, L8_1)
