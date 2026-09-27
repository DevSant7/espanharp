local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1

L0_1 = {}

L1_1 = Config

L1_1 = L1_1.DisabledNotifications

if L1_1 then

  L1_1 = 1

  L2_1 = Config

  L2_1 = L2_1.DisabledNotifications

  L2_1 = #L2_1

  L3_1 = 1

  for L4_1 = L1_1, L2_1, L3_1 do

    L5_1 = Config

    L5_1 = L5_1.DisabledNotifications

    L5_1 = L5_1[L4_1]

    L0_1[L5_1] = true

  end

end

function L1_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L4_2 = A1_2.app

  L3_2 = L0_1

  L3_2 = L3_2[L4_2]

  if L3_2 then

    if A2_2 then

      L3_2 = A2_2

      L4_2 = false

      L3_2(L4_2)

    end

    L3_2 = debugprint

    L4_2 = "SendNotification: Notification are disabled for app"

    L5_2 = A1_2.app

    return L3_2(L4_2, L5_2)

  end

  L3_2 = nil

  L4_2 = table

  L4_2 = L4_2.clone

  L5_2 = A1_2

  L4_2 = L4_2(L5_2)

  A1_2 = L4_2

  L4_2 = type

  L5_2 = A1_2

  L4_2 = L4_2(L5_2)

  if "table" == L4_2 then

    L4_2 = A1_2.app

    if L4_2 then

      goto lbl_45

    end

    L4_2 = type

    L5_2 = A0_2

    L4_2 = L4_2(L5_2)

    if "string" ~= L4_2 then

      goto lbl_45

    end

  end

  if A2_2 then

    L4_2 = A2_2

    L5_2 = false

    L4_2(L5_2)

  end

  L4_2 = debugprint

  L5_2 = "SendNotification: Invalid data or no app"

  L6_2 = A1_2

  do return L4_2(L5_2, L6_2) end

  ::lbl_45::

  L4_2 = A1_2.content

  if L4_2 then

    L4_2 = A1_2.content

    L4_2 = #L4_2

    L5_2 = 500

    if L4_2 > L5_2 then

      if A2_2 then

        L4_2 = A2_2

        L5_2 = false

        L4_2(L5_2)

      end

      L4_2 = A1_2.content

      L5_2 = L4_2

      L4_2 = L4_2.sub

      L6_2 = 1

      L7_2 = 500

      L4_2 = L4_2(L5_2, L6_2, L7_2)

      A1_2.content = L4_2

    end

  end

  L4_2 = type

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  if "number" == L4_2 then

    A1_2.source = A0_2

  else

    L4_2 = type

    L5_2 = A0_2

    L4_2 = L4_2(L5_2)

    if "string" == L4_2 then

      L3_2 = A0_2

    end

  end

  L4_2 = A1_2.app

  if L4_2 then

    L4_2 = A1_2.source

    if not L4_2 then

      L4_2 = type

      L5_2 = A0_2

      L4_2 = L4_2(L5_2)

      if "string" == L4_2 then

        L4_2 = GetSourceFromNumber

        L5_2 = A0_2

        L4_2 = L4_2(L5_2)

        if L4_2 then

          A1_2.source = L4_2

        end

      end

    end

  end

  L4_2 = A1_2.app

  if not L4_2 or not L3_2 then

    if A2_2 then

      L4_2 = A2_2

      L5_2 = true

      L4_2(L5_2)

    end

    L4_2 = A1_2.source

    if L4_2 then

      L4_2 = TriggerClientEvent

      L5_2 = "phone:sendNotification"

      L6_2 = A1_2.source

      L7_2 = A1_2

      L4_2(L5_2, L6_2, L7_2)

      L4_2 = debugprint

      L5_2 = "SendNotification: Sending notification to source: "

      L6_2 = A1_2.source

      L5_2 = L5_2 .. L6_2

      L4_2(L5_2)

    end

    L4_2 = debugprint

    L5_2 = "SendNotification: No app or no phone number provided (target is not a string)"

    L6_2 = L3_2

    L7_2 = A1_2

    L4_2(L5_2, L6_2, L7_2)

    return

  end

  L4_2 = Config

  L4_2 = L4_2.MaxNotifications

  if L4_2 then

    L4_2 = MySQL

    L4_2 = L4_2.scalar

    L4_2 = L4_2.await

    L5_2 = "SELECT id FROM phone_notifications WHERE phone_number = ? ORDER BY id DESC LIMIT ?, 1"

    L6_2 = {}

    L7_2 = L3_2

    L8_2 = Config

    L8_2 = L8_2.MaxNotifications

    L8_2 = L8_2 - 1

    L6_2[1] = L7_2

    L6_2[2] = L8_2

    L4_2 = L4_2(L5_2, L6_2)

    if L4_2 then

      L5_2 = debugprint

      L6_2 = "SendNotification: "

      L7_2 = L3_2

      L8_2 = " has reached max notifications, deleting old notifications. id:"

      L6_2 = L6_2 .. L7_2 .. L8_2

      L7_2 = L4_2

      L5_2(L6_2, L7_2)

      L5_2 = MySQL

      L5_2 = L5_2.update

      L5_2 = L5_2.await

      L6_2 = "DELETE FROM phone_notifications WHERE phone_number = ? AND id <= ?"

      L7_2 = {}

      L8_2 = L3_2

      L9_2 = L4_2

      L7_2[1] = L8_2

      L7_2[2] = L9_2

      L5_2(L6_2, L7_2)

    end

  end

  L4_2 = MySQL

  L4_2 = L4_2.insert

  L4_2 = L4_2.await

  L5_2 = "INSERT IGNORE INTO phone_notifications (phone_number, app, title, content, thumbnail, avatar, show_avatar, custom_data) VALUES (@phoneNumber, @app, @title, @content, @thumbnail, @avatar, @showAvatar, @data)"

  L6_2 = {}

  L6_2["@phoneNumber"] = L3_2

  L7_2 = A1_2.app

  L6_2["@app"] = L7_2

  L7_2 = A1_2.title

  L6_2["@title"] = L7_2

  L7_2 = A1_2.content

  L6_2["@content"] = L7_2

  L7_2 = A1_2.thumbnail

  L6_2["@thumbnail"] = L7_2

  L7_2 = A1_2.avatar

  L6_2["@avatar"] = L7_2

  L7_2 = A1_2.showAvatar

  L6_2["@showAvatar"] = L7_2

  L7_2 = A1_2.customData

  if L7_2 then

    L7_2 = json

    L7_2 = L7_2.encode

    L8_2 = A1_2.customData

    L7_2 = L7_2(L8_2)

    if L7_2 then

      goto lbl_188

    end

  end

  L7_2 = nil

  ::lbl_188::

  L6_2["@data"] = L7_2

  L4_2 = L4_2(L5_2, L6_2)

  A1_2.id = L4_2

  L5_2 = A1_2.source

  if L5_2 then

    L5_2 = TriggerClientEvent

    L6_2 = "phone:sendNotification"

    L7_2 = A1_2.source

    L8_2 = A1_2

    L5_2(L6_2, L7_2, L8_2)

    L5_2 = debugprint

    L6_2 = "SendNotification: Sending notification to source: "

    L7_2 = A1_2.source

    L6_2 = L6_2 .. L7_2

    L5_2(L6_2)

  else

    L5_2 = debugprint

    L6_2 = "SendNotification: couldn't find source, not triggering event"

    L5_2(L6_2)

  end

  if A2_2 then

    L5_2 = A2_2

    L6_2 = L4_2

    L5_2(L6_2)

  end

  return L4_2

end

SendNotification = L1_1

L1_1 = exports

L2_1 = "SendNotification"

L3_1 = SendNotification

L1_1(L2_1, L3_1)

function L1_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = assert

  L3_2 = "all" == A0_2 or "online" == A0_2

  L4_2 = "Invalid notify"

  L2_2(L3_2, L4_2)

  L2_2 = assert

  L3_2 = type

  L4_2 = A1_2 or L4_2

  if A1_2 then

    L4_2 = A1_2.app

  end

  L3_2 = L3_2(L4_2)

  L3_2 = "string" == L3_2

  L4_2 = "Invalid app"

  L2_2(L3_2, L4_2)

  L2_2 = assert

  L3_2 = type

  L4_2 = A1_2 or L4_2

  if A1_2 then

    L4_2 = A1_2.title

  end

  L3_2 = L3_2(L4_2)

  L3_2 = "string" == L3_2

  L4_2 = "Invalid title"

  L2_2(L3_2, L4_2)

  L3_2 = A1_2.app

  L2_2 = L0_1

  L2_2 = L2_2[L3_2]

  if L2_2 then

    L2_2 = debugprint

    L3_2 = "NotifyEveryone: Notification are disabled for app"

    L4_2 = A1_2.app

    L2_2(L3_2, L4_2)

    return

  end

  if "all" == A0_2 then

    L2_2 = MySQL

    L2_2 = L2_2.insert

    L3_2 = [[

            INSERT INTO phone_notifications

                (phone_number, app, title, content, thumbnail, avatar, show_avatar)

            SELECT

                phone_number, @app, @title, @content, @thumbnail, @avatar, @showAvatar

            FROM

                phone_phones

            WHERE

                last_seen > DATE_SUB(NOW(), INTERVAL 7 DAY)

        ]]

    L4_2 = {}

    L5_2 = A1_2.app

    L4_2["@app"] = L5_2

    L5_2 = A1_2.title

    L4_2["@title"] = L5_2

    L5_2 = A1_2.content

    L4_2["@content"] = L5_2

    L5_2 = A1_2.thumbnail

    L4_2["@thumbnail"] = L5_2

    L5_2 = A1_2.avatar

    L4_2["@avatar"] = L5_2

    L5_2 = A1_2.showAvatar

    L4_2["@showAvatar"] = L5_2

    L2_2(L3_2, L4_2)

  end

  L2_2 = TriggerClientEvent

  L3_2 = "phone:sendNotification"

  L4_2 = -1

  L5_2 = A1_2

  L2_2(L3_2, L4_2, L5_2)

end

NotifyEveryone = L1_1

L1_1 = exports

L2_1 = "NotifyEveryone"

L3_1 = NotifyEveryone

L1_1(L2_1, L3_1)

function L1_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2, L8_2

  L5_2 = A1_2.app

  L4_2 = L0_1

  L4_2 = L4_2[L5_2]

  if L4_2 then

    L4_2 = debugprint

    L5_2 = "NotifyPhonesWithQuery: Notification are disabled for app"

    L6_2 = A1_2.app

    L4_2(L5_2, L6_2)

    return

  end

  if not A3_2 then

    L4_2 = {}

    A3_2 = L4_2

  end

  if not A2_2 then

    A2_2 = ""

  end

  L4_2 = A1_2.app

  A3_2["@app"] = L4_2

  L4_2 = A1_2.title

  A3_2["@title"] = L4_2

  L4_2 = A1_2.content

  A3_2["@content"] = L4_2

  L4_2 = A1_2.thumbnail

  A3_2["@thumbnail"] = L4_2

  L4_2 = A1_2.avatar

  A3_2["@avatar"] = L4_2

  L4_2 = A1_2.showAvatar

  A3_2["@showAvatar"] = L4_2

  L4_2 = [[

        INSERT INTO phone_notifications

            (phone_number, app, title, content, thumbnail, avatar, show_avatar)

        SELECT

            %sphone_number, @app, @title, @content, @thumbnail, @avatar, @showAvatar

        FROM

            %s

        RETURNING

            id, phone_number

    ]]

  L5_2 = L4_2

  L4_2 = L4_2.format

  L6_2 = A2_2

  L7_2 = A0_2

  L4_2 = L4_2(L5_2, L6_2, L7_2)

  L5_2 = MySQL

  L5_2 = L5_2.query

  L6_2 = L4_2

  L7_2 = A3_2

  function L8_2(A0_3)

    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3

    L1_3 = 1

    L2_3 = #A0_3

    L3_3 = 1

    for L4_3 = L1_3, L2_3, L3_3 do

      L5_3 = A0_3[L4_3]

      L5_3 = L5_3.phone_number

      L6_3 = GetSourceFromNumber

      L7_3 = L5_3

      L6_3 = L6_3(L7_3)

      if L6_3 then

        L7_3 = A0_3[L4_3]

        L7_3 = L7_3.id

        A1_2.id = L7_3

        L7_3 = TriggerClientEvent

        L8_3 = "phone:sendNotification"

        L9_3 = L6_3

        L10_3 = A1_2

        L7_3(L8_3, L9_3, L10_3)

      end

    end

  end

  L5_2(L6_2, L7_2, L8_2)

end

NotifyPhonesWithQuery = L1_1

function L1_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2

  L2_2 = table

  L2_2 = L2_2.clone

  L3_2 = A1_2

  L2_2 = L2_2(L3_2)

  L4_2 = L2_2.app

  L3_2 = L0_1

  L3_2 = L3_2[L4_2]

  if L3_2 then

    L3_2 = debugprint

    L4_2 = "NotifyPhones: Notification are disabled for app"

    L5_2 = L2_2.app

    L3_2(L4_2, L5_2)

    return

  else

    L3_2 = #A0_2

    if 0 == L3_2 then

      L3_2 = debugprint

      L4_2 = "NotifyPhones: No phone numbers provided"

      L3_2(L4_2)

      return

    end

  end

  L3_2 = {}

  L4_2 = L2_2.app

  L5_2 = L2_2.title

  L3_2[1] = L4_2

  L3_2[2] = L5_2

  L4_2 = {}

  L5_2 = "phone_number"

  L6_2 = "app"

  L7_2 = "title"

  L4_2[1] = L5_2

  L4_2[2] = L6_2

  L4_2[3] = L7_2

  L5_2 = L2_2.content

  if L5_2 then

    L5_2 = #L3_2

    L5_2 = L5_2 + 1

    L6_2 = L2_2.content

    L3_2[L5_2] = L6_2

    L5_2 = #L4_2

    L5_2 = L5_2 + 1

    L4_2[L5_2] = "content"

  end

  L5_2 = L2_2.thumbnail

  if L5_2 then

    L5_2 = #L3_2

    L5_2 = L5_2 + 1

    L6_2 = L2_2.thumbnail

    L3_2[L5_2] = L6_2

    L5_2 = #L4_2

    L5_2 = L5_2 + 1

    L4_2[L5_2] = "thumbnail"

  end

  L5_2 = L2_2.avatar

  if L5_2 then

    L5_2 = #L3_2

    L5_2 = L5_2 + 1

    L6_2 = L2_2.avatar

    L3_2[L5_2] = L6_2

    L5_2 = #L4_2

    L5_2 = L5_2 + 1

    L4_2[L5_2] = "avatar"

  end

  L5_2 = L2_2.showAvatar

  if L5_2 then

    L5_2 = #L3_2

    L5_2 = L5_2 + 1

    L3_2[L5_2] = 1

    L5_2 = #L4_2

    L5_2 = L5_2 + 1

    L4_2[L5_2] = "show_avatar"

  end

  L5_2 = L2_2.customData

  if L5_2 then

    L5_2 = #L3_2

    L5_2 = L5_2 + 1

    L6_2 = json

    L6_2 = L6_2.encode

    L7_2 = L2_2.customData

    L6_2 = L6_2(L7_2)

    L3_2[L5_2] = L6_2

    L5_2 = #L4_2

    L5_2 = L5_2 + 1

    L4_2[L5_2] = "custom_data"

  end

  L5_2 = {}

  L6_2 = "INSERT INTO phone_notifications ({PARAMS}) VALUES ({VALUES})"

  L8_2 = L6_2

  L7_2 = L6_2.gsub

  L9_2 = "{PARAMS}"

  L10_2 = table

  L10_2 = L10_2.concat

  L11_2 = L4_2

  L12_2 = ", "

  L10_2, L11_2, L12_2, L13_2, L14_2 = L10_2(L11_2, L12_2)

  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)

  L6_2 = L7_2

  L8_2 = L6_2

  L7_2 = L6_2.gsub

  L9_2 = "{VALUES}"

  L10_2 = string

  L10_2 = L10_2.rep

  L11_2 = "?, "

  L12_2 = #L3_2

  L12_2 = L12_2 + 1

  L10_2 = L10_2(L11_2, L12_2)

  L11_2 = L10_2

  L10_2 = L10_2.sub

  L12_2 = 1

  L13_2 = -3

  L10_2, L11_2, L12_2, L13_2, L14_2 = L10_2(L11_2, L12_2, L13_2)

  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)

  L6_2 = L7_2

  L7_2 = 1

  L8_2 = #A0_2

  L9_2 = 1

  for L10_2 = L7_2, L8_2, L9_2 do

    L11_2 = {}

    L12_2 = A0_2[L10_2]

    L13_2 = table

    L13_2 = L13_2.unpack

    L14_2 = L3_2

    L13_2, L14_2 = L13_2(L14_2)

    L11_2[1] = L12_2

    L11_2[2] = L13_2

    L11_2[3] = L14_2

    L5_2[L10_2] = L11_2

  end

  L7_2 = MySQL

  L7_2 = L7_2.prepare

  L8_2 = L6_2

  L9_2 = L5_2

  function L10_2(A0_3)

    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3

    L1_3 = 1

    L2_3 = A0_2

    L2_3 = #L2_3

    L3_3 = 1

    for L4_3 = L1_3, L2_3, L3_3 do

      L5_3 = A0_2

      L5_3 = L5_3[L4_3]

      L6_3 = type

      L7_3 = A0_3

      L6_3 = L6_3(L7_3)

      if "table" == L6_3 then

        L6_3 = A0_3[L4_3]

        if L6_3 then

          goto lbl_17

        end

      end

      L6_3 = A0_3

      ::lbl_17::

      if not L5_3 or not L6_3 then

      else

        L7_3 = GetSourceFromNumber

        L8_3 = L5_3

        L7_3 = L7_3(L8_3)

        if not L7_3 then

        else

          L2_2.id = L6_3

          L8_3 = TriggerClientEvent

          L9_3 = "phone:sendNotification"

          L10_3 = L7_3

          L11_3 = L2_2

          L8_3(L9_3, L10_3, L11_3)

        end

      end

    end

  end

  L7_2(L8_2, L9_2, L10_2)

end

NotifyPhones = L1_1

function L1_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2

  L4_2 = L0_1

  L4_2 = L4_2[A0_2]

  if L4_2 then

    L4_2 = debugprint

    L5_2 = "NotifyLoggedInAccounts: Notification are disabled for app"

    L6_2 = A0_2

    L4_2(L5_2, L6_2)

    return

  end

  L4_2 = GetLoggedInNumbers

  L5_2 = A0_2

  L6_2 = A1_2

  L4_2 = L4_2(L5_2, L6_2)

  if A3_2 then

    L5_2 = #L4_2

    L6_2 = 1

    L7_2 = -1

    for L8_2 = L5_2, L6_2, L7_2 do

      L9_2 = L4_2[L8_2]

      L10_2 = table

      L10_2 = L10_2.contains

      L11_2 = A3_2

      L12_2 = L9_2

      L10_2 = L10_2(L11_2, L12_2)

      if L10_2 then

        L10_2 = debugprint

        L11_2 = "NotifyLoggedInAccounts: Ignoring number"

        L12_2 = L9_2

        L10_2(L11_2, L12_2)

        L10_2 = table

        L10_2 = L10_2.remove

        L11_2 = L4_2

        L12_2 = L8_2

        L10_2(L11_2, L12_2)

      end

    end

  end

  L5_2 = #L4_2

  if 0 == L5_2 then

    L5_2 = debugprint

    L6_2 = "NotifyLoggedInAccounts: No logged in numbers for"

    L7_2 = A1_2

    L8_2 = "on"

    L9_2 = A0_2

    L5_2(L6_2, L7_2, L8_2, L9_2)

    return

  end

  L5_2 = table

  L5_2 = L5_2.clone

  L6_2 = A2_2

  L5_2 = L5_2(L6_2)

  L5_2.app = A0_2

  L6_2 = NotifyPhones

  L7_2 = L4_2

  L8_2 = L5_2

  L6_2(L7_2, L8_2)

end

NotifyLoggedInAccounts = L1_1

function L1_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = assert

  L3_2 = type

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  L3_2 = "number" == L3_2

  L4_2 = "Invalid source"

  L2_2(L3_2, L4_2)

  L2_2 = assert

  L3_2 = type

  L4_2 = A1_2

  L3_2 = L3_2(L4_2)

  L3_2 = "table" == L3_2

  L4_2 = "Invalid data"

  L2_2(L3_2, L4_2)

  L2_2 = SendNotification

  L3_2 = A0_2

  L4_2 = {}

  L5_2 = A1_2.title

  if not L5_2 then

    L5_2 = "Emergency Alert"

  end

  L4_2.title = L5_2

  L5_2 = A1_2.content

  if not L5_2 then

    L5_2 = "This is a test emergency alert."

  end

  L4_2.content = L5_2

  L5_2 = "./assets/img/icons/"

  L6_2 = A1_2.icon

  if not L6_2 then

    L6_2 = "warning"

  end

  L7_2 = ".png"

  L5_2 = L5_2 .. L6_2 .. L7_2

  L4_2.icon = L5_2

  return L2_2(L3_2, L4_2)

end

EmergencyNotification = L1_1

L1_1 = exports

L2_1 = "SendAmberAlert"

L3_1 = EmergencyNotification

L1_1(L2_1, L3_1)

L1_1 = exports

L2_1 = "EmergencyNotification"

L3_1 = EmergencyNotification

L1_1(L2_1, L3_1)

L1_1 = BaseCallback

L2_1 = "getNotifications"

function L3_1(A0_2, A1_2, ...)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = MySQL

  L2_2 = L2_2.query

  L2_2 = L2_2.await

  L3_2 = "SELECT id, app, title, content, thumbnail, avatar, show_avatar AS showAvatar, custom_data, `timestamp` FROM phone_notifications WHERE phone_number=?"

  L4_2 = {}

  L5_2 = A1_2

  L4_2[1] = L5_2

  return L2_2(L3_2, L4_2)

end

L4_1 = {}

L1_1(L2_1, L3_1, L4_1)

L1_1 = BaseCallback

L2_1 = "deleteNotification"

function L3_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = MySQL

  L3_2 = L3_2.update

  L3_2 = L3_2.await

  L4_2 = "DELETE FROM phone_notifications WHERE id=? AND phone_number=?"

  L5_2 = {}

  L6_2 = A2_2

  L7_2 = A1_2

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L3_2 = L3_2(L4_2, L5_2)

  L3_2 = L3_2 > 0

  return L3_2

end

L1_1(L2_1, L3_1)

L1_1 = BaseCallback

L2_1 = "clearNotifications"

function L3_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = MySQL

  L3_2 = L3_2.update

  L3_2 = L3_2.await

  L4_2 = "DELETE FROM phone_notifications WHERE phone_number=? AND app=?"

  L5_2 = {}

  L6_2 = A1_2

  L7_2 = A2_2

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L3_2(L4_2, L5_2)

  L3_2 = true

  return L3_2

end

L1_1(L2_1, L3_1)
