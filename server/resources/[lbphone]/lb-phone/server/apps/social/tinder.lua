local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1

L0_1 = {}

function L1_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2

  L3_2 = BaseCallback

  L4_2 = "spark:"

  L5_2 = A0_2

  L4_2 = L4_2 .. L5_2

  function L5_2(A0_3, A1_3, ...)

    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3

    L2_3 = L0_1

    L2_3 = L2_3[A0_3]

    if L2_3 then

      L3_3 = L2_3.phoneNumber

      if L3_3 == A1_3 then

        goto lbl_11

      end

    end

    L3_3 = A2_2

    do return L3_3 end

    ::lbl_11::

    L3_3 = A1_2

    L4_3 = A0_3

    L5_3 = A1_3

    L6_3 = L2_3

    L7_3 = ...

    return L3_3(L4_3, L5_3, L6_3, L7_3)

  end

  L6_2 = A2_2

  L3_2(L4_2, L5_2, L6_2)

end

L2_1 = BaseCallback

L3_1 = "spark:createAccount"

function L4_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = MySQL

  L3_2 = L3_2.scalar

  L3_2 = L3_2.await

  L4_2 = "SELECT TRUE FROM phone_tinder_accounts WHERE phone_number = ?"

  L5_2 = {}

  L6_2 = A1_2

  L5_2[1] = L6_2

  L3_2 = L3_2(L4_2, L5_2)

  if L3_2 then

    L3_2 = false

    return L3_2

  end

  L3_2 = MySQL

  L3_2 = L3_2.update

  L3_2 = L3_2.await

  L4_2 = [[

        INSERT INTO phone_tinder_accounts

            (`name`, phone_number, photos, bio, dob, is_male, interested_men, interested_women)

        VALUES

            (@name, @phoneNumber, @photos, @bio, @dob, @isMale, @showMen, @showWomen)

    ]]

  L5_2 = {}

  L6_2 = A2_2.name

  L5_2.name = L6_2

  L5_2.phoneNumber = A1_2

  L6_2 = json

  L6_2 = L6_2.encode

  L7_2 = A2_2.photos

  L6_2 = L6_2(L7_2)

  L5_2.photos = L6_2

  L6_2 = A2_2.bio

  L5_2.bio = L6_2

  L6_2 = A2_2.dob

  L5_2.dob = L6_2

  L6_2 = A2_2.isMale

  L5_2.isMale = L6_2

  L6_2 = A2_2.showMen

  L5_2.showMen = L6_2

  L6_2 = A2_2.showWomen

  L5_2.showWomen = L6_2

  L3_2 = L3_2(L4_2, L5_2)

  L3_2 = L3_2 > 0

  return L3_2

end

L5_1 = false

L2_1(L3_1, L4_1, L5_1)

L2_1 = BaseCallback

L3_1 = "spark:deleteAccount"

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = Config

  L2_2 = L2_2.DeleteAccount

  L2_2 = L2_2.Spark

  if not L2_2 then

    L2_2 = infoprint

    L3_2 = "warning"

    L4_2 = "%s tried to delete their spark account, but it's not enabled in the config."

    L5_2 = L4_2

    L4_2 = L4_2.format

    L6_2 = A0_2

    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2)

    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)

    L2_2 = false

    return L2_2

  end

  L2_2 = MySQL

  L2_2 = L2_2.update

  L2_2 = L2_2.await

  L3_2 = "DELETE FROM phone_tinder_accounts WHERE phone_number = ?"

  L4_2 = {}

  L5_2 = A1_2

  L4_2[1] = L5_2

  L2_2 = L2_2(L3_2, L4_2)

  L2_2 = L2_2 > 0

  if not L2_2 then

    L3_2 = false

    return L3_2

  end

  L3_2 = MySQL

  L3_2 = L3_2.update

  L4_2 = "DELETE FROM phone_tinder_swipes WHERE swiper = ? OR swipee = ?"

  L5_2 = {}

  L6_2 = A1_2

  L7_2 = A1_2

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L3_2(L4_2, L5_2)

  L3_2 = MySQL

  L3_2 = L3_2.update

  L4_2 = "DELETE FROM phone_tinder_matches WHERE phone_number_1 = ? OR phone_number_2 = ?"

  L5_2 = {}

  L6_2 = A1_2

  L7_2 = A1_2

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L3_2(L4_2, L5_2)

  L3_2 = MySQL

  L3_2 = L3_2.update

  L4_2 = "DELETE FROM phone_tinder_messages WHERE sender = ? OR recipient = ?"

  L5_2 = {}

  L6_2 = A1_2

  L7_2 = A1_2

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L3_2(L4_2, L5_2)

  L3_2 = true

  return L3_2

end

L2_1(L3_1, L4_1)

L2_1 = L1_1

L3_1 = "updateAccount"

function L4_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L4_2 = pairs

  L5_2 = A2_2

  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)

  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do

    L10_2 = A3_2[L8_2]

    if nil ~= L10_2 then

      L10_2 = A3_2[L8_2]

      A2_2[L8_2] = L10_2

    end

  end

  L4_2 = MySQL

  L4_2 = L4_2.update

  L4_2 = L4_2.await

  L5_2 = [[

        UPDATE phone_tinder_accounts

        SET

            `name`=@name,

            photos=@photos,

            bio=@bio,

            is_male=@isMale,

            interested_men=@showMen,

            interested_women=@showWomen,

            `active`=@active

        WHERE phone_number=@phoneNumber

    ]]

  L6_2 = {}

  L7_2 = A3_2.name

  L6_2.name = L7_2

  L7_2 = json

  L7_2 = L7_2.encode

  L8_2 = A3_2.photos

  L7_2 = L7_2(L8_2)

  L6_2.photos = L7_2

  L7_2 = A3_2.bio

  L6_2.bio = L7_2

  L7_2 = A3_2.isMale

  L6_2.isMale = L7_2

  L7_2 = A3_2.showMen

  L6_2.showMen = L7_2

  L7_2 = A3_2.showWomen

  L6_2.showWomen = L7_2

  L7_2 = A3_2.active

  L6_2.active = L7_2

  L6_2.phoneNumber = A1_2

  L4_2 = L4_2(L5_2, L6_2)

  L4_2 = L4_2 > 0

  return L4_2

end

L5_1 = false

L2_1(L3_1, L4_1, L5_1)

L2_1 = BaseCallback

L3_1 = "spark:isLoggedIn"

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  if L2_2 then

    L3_2 = L2_2.phoneNumber

    if L3_2 == A1_2 then

      return L2_2

    end

  end

  L3_2 = MySQL

  L3_2 = L3_2.single

  L3_2 = L3_2.await

  L4_2 = "SELECT `name`, photos, bio, dob, is_male, interested_men, interested_women, `active` FROM phone_tinder_accounts WHERE phone_number = ?"

  L5_2 = {}

  L6_2 = A1_2

  L5_2[1] = L6_2

  L3_2 = L3_2(L4_2, L5_2)

  if not L3_2 then

    return

  end

  L4_2 = MySQL

  L4_2 = L4_2.update

  L4_2 = L4_2.await

  L5_2 = "UPDATE phone_tinder_accounts SET last_seen = NOW() WHERE phone_number = ?"

  L6_2 = {}

  L7_2 = A1_2

  L6_2[1] = L7_2

  L4_2(L5_2, L6_2)

  L4_2 = L0_1

  L5_2 = {}

  L5_2.phoneNumber = A1_2

  L6_2 = L3_2.name

  L5_2.name = L6_2

  L6_2 = json

  L6_2 = L6_2.decode

  L7_2 = L3_2.photos

  L6_2 = L6_2(L7_2)

  L5_2.photos = L6_2

  L6_2 = L3_2.bio

  L5_2.bio = L6_2

  L6_2 = L3_2.dob

  L5_2.dob = L6_2

  L6_2 = L3_2.is_male

  L5_2.isMale = L6_2

  L6_2 = L3_2.interested_men

  L5_2.showMen = L6_2

  L6_2 = L3_2.interested_women

  L5_2.showWomen = L6_2

  L6_2 = L3_2.active

  L5_2.active = L6_2

  L4_2[A0_2] = L5_2

  L4_2 = L0_1

  L4_2 = L4_2[A0_2]

  return L4_2

end

L5_1 = false

L2_1(L3_1, L4_1, L5_1)

L2_1 = BaseCallback

L3_1 = "spark:getFeed"

function L4_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2

  L3_2 = MySQL

  L3_2 = L3_2.query

  L3_2 = L3_2.await

  L4_2 = [[

        SELECT

            a.`name`, a.phone_number, a.photos, a.bio, a.dob

        FROM

            phone_tinder_accounts a

        JOIN

            phone_tinder_accounts b

        ON

            b.phone_number = @phoneNumber

        WHERE

            a.phone_number != @phoneNumber

            AND a.`active` = 1

            AND (a.is_male = b.interested_men OR a.is_male=(NOT b.interested_women))

            AND (a.interested_men=b.is_male OR a.interested_women=(NOT b.is_male))

            AND NOT EXISTS (SELECT TRUE FROM phone_tinder_swipes WHERE swiper = @phoneNumber AND swipee = a.phone_number)

        ORDER BY a.phone_number

        LIMIT @page, @perPage

    ]]

  L5_2 = {}

  L5_2.phoneNumber = A1_2

  L6_2 = A2_2 or L6_2

  if not A2_2 then

    L6_2 = 0

  end

  L6_2 = L6_2 * 10

  L5_2.page = L6_2

  L5_2.perPage = 10

  return L3_2(L4_2, L5_2)

end

L5_1 = {}

L2_1(L3_1, L4_1, L5_1)

L2_1 = L1_1

L3_1 = "swipe"

function L4_1(A0_2, A1_2, A2_2, A3_2, A4_2)

  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2

  L5_2 = MySQL

  L5_2 = L5_2.query

  L5_2 = L5_2.await

  L6_2 = "INSERT INTO phone_tinder_swipes (swiper, swipee, liked) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE liked = ?"

  L7_2 = {}

  L8_2 = A1_2

  L9_2 = A3_2

  L10_2 = A4_2

  L11_2 = A4_2

  L7_2[1] = L8_2

  L7_2[2] = L9_2

  L7_2[3] = L10_2

  L7_2[4] = L11_2

  L5_2 = L5_2(L6_2, L7_2)

  if 0 == L5_2 or not A4_2 then

    L5_2 = false

    return L5_2

  end

  L5_2 = MySQL

  L5_2 = L5_2.scalar

  L5_2 = L5_2.await

  L6_2 = "SELECT liked FROM phone_tinder_swipes WHERE swiper = ? AND swipee = ?"

  L7_2 = {}

  L8_2 = A3_2

  L9_2 = A1_2

  L7_2[1] = L8_2

  L7_2[2] = L9_2

  L5_2 = L5_2(L6_2, L7_2)

  L5_2 = true == L5_2

  if not L5_2 then

    L6_2 = false

    return L6_2

  end

  L6_2 = MySQL

  L6_2 = L6_2.update

  L6_2 = L6_2.await

  L7_2 = "INSERT INTO phone_tinder_matches (phone_number_1, phone_number_2) VALUES (?, ?)"

  L8_2 = {}

  L9_2 = A1_2

  L10_2 = A3_2

  L8_2[1] = L9_2

  L8_2[2] = L10_2

  L6_2(L7_2, L8_2)

  L6_2 = SendNotification

  L7_2 = A3_2

  L8_2 = {}

  L8_2.app = "Tinder"

  L9_2 = L

  L10_2 = "BACKEND.TINDER.NEW_MATCH"

  L9_2 = L9_2(L10_2)

  L8_2.title = L9_2

  L9_2 = L

  L10_2 = "BACKEND.TINDER.MATCHED_WITH"

  L11_2 = {}

  L12_2 = A2_2.name

  L11_2.name = L12_2

  L9_2 = L9_2(L10_2, L11_2)

  L8_2.content = L9_2

  L9_2 = A2_2.photos

  L9_2 = L9_2[1]

  L8_2.thumbnail = L9_2

  L6_2(L7_2, L8_2)

  L6_2 = true

  return L6_2

end

L2_1(L3_1, L4_1)

L2_1 = BaseCallback

L3_1 = "spark:getNewMatchesCount"

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = MySQL

  L2_2 = L2_2.scalar

  L2_2 = L2_2.await

  L3_2 = [[

        SELECT COUNT(*) FROM phone_tinder_matches

        WHERE

            (

                (phone_number_1 = @phoneNumber)

                OR (phone_number_2 = @phoneNumber)

            )

            AND latest_message IS NULL

    ]]

  L4_2 = {}

  L4_2.phoneNumber = A1_2

  L2_2 = L2_2(L3_2, L4_2)

  if not L2_2 then

    L2_2 = 0

  end

  return L2_2

end

L2_1(L3_1, L4_1)

L2_1 = BaseCallback

L3_1 = "spark:getMatches"

function L4_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2, L8_2

  L4_2 = [[

        SELECT

            `account`.`name`,

            `account`.phone_number,

            `account`.photos,

            `account`.dob,

            `account`.bio,

            `account`.is_male,

            `match`.latest_sender,

            `match`.latest_message,

            `match`.latest_message_timestamp,

            CASE

                WHEN `match`.phone_number_1 = @phoneNumber THEN `match`.phone_number_1_has_unread

                ELSE `match`.phone_number_2_has_unread

            END as unread

        FROM

            phone_tinder_accounts `account`

        JOIN

            phone_tinder_matches `match`

        ON

            (

                `match`.phone_number_1 = @phoneNumber

                AND `match`.phone_number_2 = `account`.phone_number

            )

            OR

            (

                `match`.phone_number_2 = @phoneNumber

                AND `match`.phone_number_1 = `account`.phone_number

            )

        WHERE latest_message {MESSAGES}

        ORDER BY `match`.latest_message_timestamp DESC

        LIMIT @page, @perPage

    ]]

  L6_2 = L4_2

  L5_2 = L4_2.gsub

  L7_2 = "{MESSAGES}"

  if A2_2 then

    L8_2 = "IS NOT NULL"

    if L8_2 then

      goto lbl_10

    end

  end

  L8_2 = "IS NULL"

  ::lbl_10::

  L5_2 = L5_2(L6_2, L7_2, L8_2)

  L4_2 = L5_2

  L5_2 = MySQL

  L5_2 = L5_2.query

  L5_2 = L5_2.await

  L6_2 = L4_2

  L7_2 = {}

  L7_2.phoneNumber = A1_2

  L8_2 = A3_2 or L8_2

  if not A3_2 then

    L8_2 = 0

  end

  L8_2 = L8_2 * 25

  L7_2.page = L8_2

  L7_2.perPage = 25

  return L5_2(L6_2, L7_2)

end

L2_1(L3_1, L4_1)

L2_1 = L1_1

L3_1 = "sendMessage"

function L4_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)

  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2

  L6_2 = ContainsBlacklistedWord

  L7_2 = A0_2

  L8_2 = "Spark"

  L9_2 = A4_2

  L6_2 = L6_2(L7_2, L8_2, L9_2)

  if L6_2 then

    L6_2 = false

    return L6_2

  end

  L6_2 = MySQL

  L6_2 = L6_2.insert

  L6_2 = L6_2.await

  L7_2 = "INSERT INTO phone_tinder_messages (sender, recipient, content, attachments) VALUES (?, ?, ?, ?)"

  L8_2 = {}

  L9_2 = A1_2

  L10_2 = A3_2

  L11_2 = A4_2

  L12_2 = json

  L12_2 = L12_2.encode

  L13_2 = A5_2

  L12_2, L13_2 = L12_2(L13_2)

  L8_2[1] = L9_2

  L8_2[2] = L10_2

  L8_2[3] = L11_2

  L8_2[4] = L12_2

  L8_2[5] = L13_2

  L6_2 = L6_2(L7_2, L8_2)

  if not L6_2 then

    L7_2 = false

    return L7_2

  end

  L7_2 = MySQL

  L7_2 = L7_2.update

  L8_2 = [[

            UPDATE

                phone_tinder_matches

            SET

                latest_message = @content,

                latest_sender = @sender,

                latest_message_timestamp = CURRENT_TIMESTAMP,

                phone_number_1_has_unread = CASE WHEN phone_number_1 = @recipient THEN 1 ELSE 0 END,

                phone_number_2_has_unread = CASE WHEN phone_number_2 = @recipient THEN 1 ELSE 0 END

            WHERE

                (phone_number_1 = @sender AND phone_number_2 = @recipient)

                OR (phone_number_2 = @sender AND phone_number_1 = @recipient)

        ]]

  L9_2 = {}

  L9_2.content = A4_2

  L9_2.sender = A1_2

  L9_2.recipient = A3_2

  L7_2(L8_2, L9_2)

  L7_2 = GetSourceFromNumber

  L8_2 = A3_2

  L7_2 = L7_2(L8_2)

  if L7_2 then

    L8_2 = TriggerClientEvent

    L9_2 = "phone:spark:newMessage"

    L10_2 = L7_2

    L11_2 = {}

    L11_2.sender = A1_2

    L11_2.recipient = A3_2

    L11_2.content = A4_2

    L11_2.attachments = A5_2

    L12_2 = os

    L12_2 = L12_2.time

    L12_2 = L12_2()

    L12_2 = L12_2 * 1000

    L11_2.timestamp = L12_2

    L8_2(L9_2, L10_2, L11_2)

  end

  L8_2 = SendNotification

  L9_2 = A3_2

  L10_2 = {}

  L10_2.app = "Tinder"

  L11_2 = A2_2.name

  L10_2.title = L11_2

  L10_2.content = A4_2

  L11_2 = A5_2 or L11_2

  if A5_2 then

    L11_2 = A5_2[1]

  end

  L10_2.thumbnail = L11_2

  L11_2 = A2_2.photos

  L11_2 = L11_2[1]

  L10_2.avatar = L11_2

  L10_2.showAvatar = true

  L8_2(L9_2, L10_2)

  return L6_2

end

L2_1(L3_1, L4_1)

L2_1 = BaseCallback

L3_1 = "spark:getMessages"

function L4_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2, L8_2

  if not A3_2 then

    L4_2 = MySQL

    L4_2 = L4_2.update

    L5_2 = [[

            UPDATE

                phone_tinder_matches

            SET

                phone_number_1_has_unread = CASE WHEN phone_number_1 = @phoneNumber THEN 0 ELSE phone_number_1_has_unread END,

                phone_number_2_has_unread = CASE WHEN phone_number_2 = @phoneNumber THEN 0 ELSE phone_number_2_has_unread END

            WHERE

                (phone_number_1 = @phoneNumber AND phone_number_2 = @number)

                OR (phone_number_2 = @phoneNumber AND phone_number_1 = @number)

        ]]

    L6_2 = {}

    L6_2.phoneNumber = A1_2

    L6_2.number = A2_2

    L4_2(L5_2, L6_2)

  end

  L4_2 = [[

        SELECT

            id,

            sender,

            recipient,

            content,

            attachments,

            timestamp

        FROM

            phone_tinder_messages

        WHERE

            (

                (sender = @phoneNumber AND recipient = @number)

                OR (recipient = @phoneNumber AND sender = @number)

            ) {PAGINATION}

        ORDER BY id DESC

        LIMIT 25

    ]]

  if A3_2 then

    L6_2 = L4_2

    L5_2 = L4_2.gsub

    L7_2 = "{PAGINATION}"

    L8_2 = "AND id < @lastId"

    L5_2 = L5_2(L6_2, L7_2, L8_2)

    L4_2 = L5_2

  else

    L6_2 = L4_2

    L5_2 = L4_2.gsub

    L7_2 = "{PAGINATION}"

    L8_2 = ""

    L5_2 = L5_2(L6_2, L7_2, L8_2)

    L4_2 = L5_2

  end

  L5_2 = MySQL

  L5_2 = L5_2.query

  L5_2 = L5_2.await

  L6_2 = L4_2

  L7_2 = {}

  L7_2.phoneNumber = A1_2

  L7_2.number = A2_2

  L7_2.lastId = A3_2

  return L5_2(L6_2, L7_2)

end

L2_1(L3_1, L4_1)

L2_1 = BaseCallback

L3_1 = "spark:markAsRead"

function L4_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2

  L3_2 = MySQL

  L3_2 = L3_2.update

  L4_2 = [[

        UPDATE

            phone_tinder_matches

        SET

            phone_number_1_has_unread = CASE WHEN phone_number_1 = @phoneNumber THEN 0 ELSE phone_number_1_has_unread END,

            phone_number_2_has_unread = CASE WHEN phone_number_2 = @phoneNumber THEN 0 ELSE phone_number_2_has_unread END

        WHERE

            (phone_number_1 = @phoneNumber AND phone_number_2 = @number)

            OR (phone_number_2 = @phoneNumber AND phone_number_1 = @number)

    ]]

  L5_2 = {}

  L5_2.phoneNumber = A1_2

  L5_2.number = A2_2

  L3_2(L4_2, L5_2)

end

L2_1(L3_1, L4_1)

L2_1 = CreateThread

function L3_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2

  L0_2 = Config

  L0_2 = L0_2.AutoDisableSparkAccounts

  if not L0_2 then

    return

  end

  L0_2 = 3600000

  L1_2 = 7

  L2_2 = type

  L3_2 = Config

  L3_2 = L3_2.AutoDisableSparkAccounts

  L2_2 = L2_2(L3_2)

  if "number" == L2_2 then

    L2_2 = math

    L2_2 = L2_2.max

    L3_2 = Config

    L3_2 = L3_2.AutoDisableSparkAccounts

    L4_2 = 1

    L2_2 = L2_2(L3_2, L4_2)

    L1_2 = L2_2

  end

  while true do

    L2_2 = DatabaseCheckerFinished

    if L2_2 then

      break

    end

    L2_2 = Wait

    L3_2 = 500

    L2_2(L3_2)

  end

  while true do

    L2_2 = MySQL

    L2_2 = L2_2.update

    L3_2 = "UPDATE phone_tinder_accounts SET active = 0 WHERE active = 1 AND last_seen < NOW() - INTERVAL ? DAY"

    L4_2 = {}

    L5_2 = L1_2

    L4_2[1] = L5_2

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3

      L1_3 = debugprint

      L2_3 = "Disabled "

      L3_3 = A0_3

      L4_3 = " inactive Spark accounts."

      L2_3 = L2_3 .. L3_3 .. L4_3

      L1_3(L2_3)

    end

    L2_2(L3_2, L4_2, L5_2)

    L2_2 = Wait

    L3_2 = L0_2

    L2_2(L3_2)

  end

end

L2_1(L3_1)

L2_1 = AddEventHandler

L3_1 = "playerDropped"

function L4_1()

  local L0_2, L1_2

  L1_2 = source

  L0_2 = L0_1

  L0_2[L1_2] = nil

end

L2_1(L3_1, L4_1)
