local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1

L0_1 = {}

L1_1 = {}

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

function L3_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L3_2 = {}

  L4_2 = A1_2

  L5_2 = A0_2

  L6_2 = A1_2

  L3_2[1] = L4_2

  L3_2[2] = L5_2

  L3_2[3] = L6_2

  L4_2 = [[

        SELECT

            CONCAT(firstname, ' ', lastname) AS `name`, profile_image AS avatar, firstname, lastname, email, address, contact_phone_number AS `number`, favourite,

            (IF((SELECT TRUE FROM phone_phone_blocked_numbers b WHERE b.phone_number=? AND b.blocked_number=`number`), TRUE, FALSE)) AS blocked

        FROM

            phone_phone_contacts

        WHERE

            contact_phone_number=? AND phone_number=?

    ]]

  if A2_2 then

    L5_2 = MySQL

    L5_2 = L5_2.single

    L6_2 = L4_2

    L7_2 = L3_2

    L8_2 = A2_2

    return L5_2(L6_2, L7_2, L8_2)

  else

    L5_2 = MySQL

    L5_2 = L5_2.single

    L5_2 = L5_2.await

    L6_2 = L4_2

    L7_2 = L3_2

    return L5_2(L6_2, L7_2)

  end

end

GetContact = L3_1

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  if not A1_2 then

    L2_2 = debugprint

    L3_2 = "CreateContact: contact is required"

    L4_2 = A0_2

    L5_2 = A1_2

    L2_2(L3_2, L4_2, L5_2)

    L2_2 = false

    return L2_2

  else

    L2_2 = A1_2.number

    if not L2_2 then

      L2_2 = debugprint

      L3_2 = "CreateContact: contact.number is required"

      L4_2 = A0_2

      L5_2 = A1_2

      L2_2(L3_2, L4_2, L5_2)

      L2_2 = false

      return L2_2

    end

  end

  L2_2 = MySQL

  L2_2 = L2_2.Sync

  L2_2 = L2_2.execute

  L3_2 = [[

        INSERT INTO phone_phone_contacts (contact_phone_number, firstname, lastname, profile_image, email, address, phone_number)

        VALUES (@contactNumber, @firstname, @lastname, @avatar, @email, @address, @phoneNumber)

        ON DUPLICATE KEY UPDATE firstname=@firstname, lastname=@lastname, profile_image=@avatar, email=@email, address=@address

    ]]

  L4_2 = {}

  L5_2 = A1_2.number

  L4_2["@contactNumber"] = L5_2

  L5_2 = A1_2.firstname

  if not L5_2 then

    L5_2 = A1_2.number

  end

  L4_2["@firstname"] = L5_2

  L5_2 = A1_2.lastname

  if not L5_2 then

    L5_2 = ""

  end

  L4_2["@lastname"] = L5_2

  L5_2 = A1_2.avatar

  L4_2["@avatar"] = L5_2

  L5_2 = A1_2.email

  L4_2["@email"] = L5_2

  L5_2 = A1_2.address

  L4_2["@address"] = L5_2

  L4_2["@phoneNumber"] = A0_2

  L2_2 = L2_2(L3_2, L4_2)

  L2_2 = L2_2 > 0

  return L2_2

end

CreateContact = L3_1

L3_1 = BaseCallback

L4_1 = "saveContact"

function L5_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2

  L3_2 = CreateContact

  L4_2 = A1_2

  L5_2 = A2_2

  return L3_2(L4_2, L5_2)

end

L6_1 = false

L3_1(L4_1, L5_1, L6_1)

L3_1 = BaseCallback

L4_1 = "getContacts"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = MySQL

  L2_2 = L2_2.query

  L2_2 = L2_2.await

  L3_2 = [[

        SELECT

            contact_phone_number AS number,

            firstname,

            lastname,

            profile_image AS avatar,

            favourite,

            IF(b.blocked_number IS NOT NULL, TRUE, FALSE) AS blocked

        FROM

            phone_phone_contacts c

        LEFT JOIN

            phone_phone_blocked_numbers b

            ON c.phone_number = b.phone_number AND c.contact_phone_number = b.blocked_number

        WHERE

            c.phone_number = ?

    ]]

  L4_2 = {}

  L5_2 = A1_2

  L4_2[1] = L5_2

  return L2_2(L3_2, L4_2)

end

L6_1 = {}

L3_1(L4_1, L5_1, L6_1)

L3_1 = BaseCallback

L4_1 = "toggleBlock"

function L5_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2

  L4_2 = "INSERT INTO phone_phone_blocked_numbers (phone_number, blocked_number) VALUES (@phoneNumber, @number) ON DUPLICATE KEY UPDATE phone_number=@phoneNumber"

  if not A3_2 then

    L4_2 = "DELETE FROM phone_phone_blocked_numbers WHERE phone_number=@phoneNumber AND blocked_number=@number"

  end

  L5_2 = MySQL

  L5_2 = L5_2.update

  L5_2 = L5_2.await

  L6_2 = L4_2

  L7_2 = {}

  L7_2["@phoneNumber"] = A1_2

  L7_2["@number"] = A2_2

  L5_2(L6_2, L7_2)

  return A3_2

end

L6_1 = false

L3_1(L4_1, L5_1, L6_1)

L3_1 = BaseCallback

L4_1 = "toggleFavourite"

function L5_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2

  L4_2 = MySQL

  L4_2 = L4_2.update

  L4_2 = L4_2.await

  L5_2 = "UPDATE phone_phone_contacts SET favourite=@favourite WHERE contact_phone_number=@number AND phone_number=@phoneNumber"

  L6_2 = {}

  L6_2["@phoneNumber"] = A1_2

  L6_2["@number"] = A2_2

  L7_2 = true == A3_2

  L6_2["@favourite"] = L7_2

  L4_2(L5_2, L6_2)

  L4_2 = true

  return L4_2

end

L6_1 = false

L3_1(L4_1, L5_1, L6_1)

L3_1 = BaseCallback

L4_1 = "removeContact"

function L5_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = MySQL

  L3_2 = L3_2.update

  L3_2 = L3_2.await

  L4_2 = "DELETE FROM phone_phone_contacts WHERE contact_phone_number=? AND phone_number=?"

  L5_2 = {}

  L6_2 = A2_2

  L7_2 = A1_2

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L3_2(L4_2, L5_2)

  L3_2 = true

  return L3_2

end

L6_1 = false

L3_1(L4_1, L5_1, L6_1)

L3_1 = BaseCallback

L4_1 = "updateContact"

function L5_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2

  L3_2 = MySQL

  L3_2 = L3_2.update

  L3_2 = L3_2.await

  L4_2 = "UPDATE phone_phone_contacts SET firstname=@firstname, lastname=@lastname, profile_image=@avatar, email=@email, address=@address, contact_phone_number=@newNumber WHERE contact_phone_number=@number AND phone_number=@phoneNumber"

  L5_2 = {}

  L5_2["@phoneNumber"] = A1_2

  L6_2 = A2_2.oldNumber

  L5_2["@number"] = L6_2

  L6_2 = A2_2.number

  L5_2["@newNumber"] = L6_2

  L6_2 = A2_2.firstname

  L5_2["@firstname"] = L6_2

  L6_2 = A2_2.lastname

  if not L6_2 then

    L6_2 = ""

  end

  L5_2["@lastname"] = L6_2

  L6_2 = A2_2.avatar

  L5_2["@avatar"] = L6_2

  L6_2 = A2_2.email

  L5_2["@email"] = L6_2

  L6_2 = A2_2.address

  L5_2["@address"] = L6_2

  L3_2(L4_2, L5_2)

  L3_2 = true

  return L3_2

end

L6_1 = false

L3_1(L4_1, L5_1, L6_1)

L3_1 = BaseCallback

L4_1 = "getRecentCalls"

function L5_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2

  A2_2 = true == A2_2

  L4_2 = {}

  L5_2 = A1_2

  L6_2 = A1_2

  L7_2 = A1_2

  L8_2 = A1_2

  L9_2 = A1_2

  L4_2[1] = L5_2

  L4_2[2] = L6_2

  L4_2[3] = L7_2

  L4_2[4] = L8_2

  L4_2[5] = L9_2

  L5_2 = [[

        SELECT

            c.id,

            c.duration,

            c.answered,

            c.caller = ? AS called,

            IF(c.callee = ?, c.caller, c.callee) AS `number`,

            IF(c.callee = ?, c.hide_caller_id, FALSE) AS hideCallerId,

            (EXISTS (SELECT 1 FROM phone_phone_blocked_numbers b WHERE b.phone_number=? AND b.blocked_number=`number`)) AS blocked,

            c.`timestamp`

        FROM

            phone_phone_calls c

        WHERE

            (c.callee = ? {MISSED_CALLS_CONDITION}) {PAGINATION}

        ORDER BY

            c.id DESC

        LIMIT 25

    ]]

  if A2_2 then

    L7_2 = L5_2

    L6_2 = L5_2.gsub

    L8_2 = "{MISSED_CALLS_CONDITION}"

    L9_2 = "AND c.answered = 0"

    L6_2 = L6_2(L7_2, L8_2, L9_2)

    L5_2 = L6_2

  else

    L7_2 = L5_2

    L6_2 = L5_2.gsub

    L8_2 = "{MISSED_CALLS_CONDITION}"

    L9_2 = "OR c.caller = ?"

    L6_2 = L6_2(L7_2, L8_2, L9_2)

    L5_2 = L6_2

    L6_2 = #L4_2

    L6_2 = L6_2 + 1

    L4_2[L6_2] = A1_2

  end

  if A3_2 then

    L7_2 = L5_2

    L6_2 = L5_2.gsub

    L8_2 = "{PAGINATION}"

    L9_2 = "AND c.id < ?"

    L6_2 = L6_2(L7_2, L8_2, L9_2)

    L5_2 = L6_2

    L6_2 = #L4_2

    L6_2 = L6_2 + 1

    L4_2[L6_2] = A3_2

  else

    L7_2 = L5_2

    L6_2 = L5_2.gsub

    L8_2 = "{PAGINATION}"

    L9_2 = ""

    L6_2 = L6_2(L7_2, L8_2, L9_2)

    L5_2 = L6_2

  end

  L6_2 = MySQL

  L6_2 = L6_2.query

  L6_2 = L6_2.await

  L7_2 = L5_2

  L8_2 = L4_2

  L6_2 = L6_2(L7_2, L8_2)

  L7_2 = 1

  L8_2 = #L6_2

  L9_2 = 1

  for L10_2 = L7_2, L8_2, L9_2 do

    L11_2 = L6_2[L10_2]

    L12_2 = L11_2.hideCallerId

    L12_2 = true == L12_2

    L11_2.hideCallerId = L12_2

    L12_2 = L11_2.blocked

    L12_2 = true == L12_2

    L11_2.blocked = L12_2

    L12_2 = L11_2.called

    L12_2 = true == L12_2

    L11_2.called = L12_2

    L12_2 = L11_2.hideCallerId

    if L12_2 then

      L12_2 = L

      L13_2 = "BACKEND.CALLS.NO_CALLER_ID"

      L12_2 = L12_2(L13_2)

      L11_2.number = L12_2

    end

  end

  return L6_2

end

L6_1 = {}

L3_1(L4_1, L5_1, L6_1)

L3_1 = BaseCallback

L4_1 = "getBlockedNumbers"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = MySQL

  L2_2 = L2_2.query

  L2_2 = L2_2.await

  L3_2 = "SELECT blocked_number AS `number` FROM phone_phone_blocked_numbers WHERE phone_number=?"

  L4_2 = {}

  L5_2 = A1_2

  L4_2[1] = L5_2

  return L2_2(L3_2, L4_2)

end

L6_1 = {}

L3_1(L4_1, L5_1, L6_1)

function L3_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)

  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L6_2 = MySQL

  L6_2 = L6_2.insert

  L7_2 = "INSERT INTO phone_phone_calls (caller, callee, duration, answered, hide_caller_id) VALUES (@caller, @callee, @duration, @answered, @hideCallerId)"

  L8_2 = {}

  L8_2["@caller"] = A0_2

  L8_2["@callee"] = A1_2

  L8_2["@duration"] = A2_2

  L8_2["@answered"] = A3_2

  L8_2["@hideCallerId"] = A4_2

  L6_2(L7_2, L8_2)

  if A3_2 or A5_2 == A1_2 then

    return

  end

  L6_2 = MySQL

  L6_2 = L6_2.scalar

  L6_2 = L6_2.await

  L7_2 = "SELECT TRUE FROM phone_phones WHERE phone_number = ?"

  L8_2 = {}

  L9_2 = A1_2

  L8_2[1] = L9_2

  L6_2 = L6_2(L7_2, L8_2)

  if not L6_2 then

    return

  end

  if A4_2 then

    L7_2 = SendNotification

    L8_2 = A1_2

    L9_2 = {}

    L9_2.app = "Phone"

    L10_2 = L

    L11_2 = "BACKEND.CALLS.NO_CALLER_ID"

    L10_2 = L10_2(L11_2)

    L9_2.title = L10_2

    L10_2 = L

    L11_2 = "BACKEND.CALLS.MISSED_CALL"

    L10_2 = L10_2(L11_2)

    L9_2.content = L10_2

    L9_2.showAvatar = false

    L7_2(L8_2, L9_2)

    return

  end

  L7_2 = GetContact

  L8_2 = A0_2

  L9_2 = A1_2

  function L10_2(A0_3)

    local L1_3, L2_3, L3_3, L4_3, L5_3

    L1_3 = SendNotification

    L2_3 = A1_2

    L3_3 = {}

    L3_3.app = "Phone"

    L4_3 = A0_3 or L4_3

    if A0_3 then

      L4_3 = A0_3.name

    end

    if not L4_3 then

      L4_3 = A0_2

    end

    L3_3.title = L4_3

    L4_3 = L

    L5_3 = "BACKEND.CALLS.MISSED_CALL"

    L4_3 = L4_3(L5_3)

    L3_3.content = L4_3

    L4_3 = A0_3 or L4_3

    if A0_3 then

      L4_3 = A0_3.avatar

    end

    L3_3.avatar = L4_3

    L3_3.showAvatar = true

    L1_3(L2_3, L3_3)

  end

  L7_2(L8_2, L9_2, L10_2)

  L7_2 = SendMessage

  L8_2 = A0_2

  L9_2 = A1_2

  L10_2 = "<!CALL-NO-ANSWER!>"

  L7_2(L8_2, L9_2, L10_2)

end

L4_1 = RegisterNetEvent

L5_1 = "phone:logCall"

function L6_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L3_2 = source

  L4_2 = GetEquippedPhoneNumber

  L5_2 = L3_2

  L4_2 = L4_2(L5_2)

  if not (L4_2 and A0_2) or not A1_2 then

    return

  end

  L5_2 = L3_1

  L6_2 = L4_2

  L7_2 = A0_2

  L8_2 = A1_2

  L9_2 = A2_2

  L10_2 = false

  L11_2 = L4_2

  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)

end

L4_1(L5_1, L6_1)

function L4_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L1_2 = pairs

  L2_2 = L0_1

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = L6_2.caller

    if L7_2 then

      L7_2 = L7_2.source

    end

    if L7_2 ~= A0_2 then

      L7_2 = L6_2.callee

      if L7_2 then

        L7_2 = L7_2.source

      end

      if L7_2 ~= A0_2 then

        goto lbl_21

      end

    end

    L7_2 = true

    L8_2 = L5_2

    L9_2 = L6_2

    do return L7_2, L8_2, L9_2 end

    ::lbl_21::

  end

  L1_2 = false

  return L1_2

end

IsInCall = L4_1

L4_1 = exports

L5_1 = "IsInCall"

L6_1 = IsInCall

L4_1(L5_1, L6_1)

function L4_1(A0_2)

  local L1_2

  L1_2 = L0_1

  L1_2 = L1_2[A0_2]

  return L1_2

end

GetCall = L4_1

L4_1 = exports

L5_1 = "GetCall"

L6_1 = GetCall

L4_1(L5_1, L6_1)

L4_1 = RegisterNetEvent

L5_1 = "phone:phone:disableCompanyCalls"

function L6_1(A0_2)

  local L1_2, L2_2

  L1_2 = source

  if A0_2 then

    L2_2 = L1_1

    L2_2[L1_2] = true

  else

    L2_2 = L1_1

    L2_2[L1_2] = nil

  end

end

L4_1(L5_1, L6_1)

L4_1 = BaseCallback

L5_1 = "call"

function L6_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2

  L3_2 = debugprint

  L4_2 = "phone:phone:call"

  L5_2 = A0_2

  L6_2 = A1_2

  L7_2 = A2_2

  L3_2(L4_2, L5_2, L6_2, L7_2)

  L3_2 = IsInCall

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  if L3_2 then

    L3_2 = debugprint

    L4_2 = A0_2

    L5_2 = "is in call, returning"

    L3_2(L4_2, L5_2)

    L3_2 = false

    return L3_2

  end

  L3_2 = L2_1

  L3_2 = L3_2()

  L4_2 = {}

  L5_2 = os

  L5_2 = L5_2.time

  L5_2 = L5_2()

  L4_2.started = L5_2

  L4_2.answered = false

  L5_2 = A2_2.videoCall

  L5_2 = true == L5_2

  L4_2.videoCall = L5_2

  L5_2 = A2_2.hideCallerId

  L5_2 = true == L5_2

  L4_2.hideCallerId = L5_2

  L4_2.callId = L3_2

  L5_2 = {}

  L5_2.source = A0_2

  L5_2.number = A1_2

  L6_2 = {}

  L5_2.nearby = L6_2

  L4_2.caller = L5_2

  L5_2 = A2_2.company

  if L5_2 then

    L5_2 = Config

    L5_2 = L5_2.Companies

    L5_2 = L5_2.Enabled

    if L5_2 then

      L5_2 = A2_2.videoCall

      if not L5_2 then

        goto lbl_68

      end

    end

    L5_2 = debugprint

    L6_2 = "company calls are disabled in config or trying to call with video"

    L5_2(L6_2)

    L5_2 = TriggerClientEvent

    L6_2 = "phone:phone:userBusy"

    L7_2 = A0_2

    L5_2(L6_2, L7_2)

    L5_2 = false

    do return L5_2 end

    ::lbl_68::

    L5_2 = Config

    L5_2 = L5_2.Companies

    L5_2 = L5_2.Contacts

    L6_2 = A2_2.company

    L5_2 = L5_2[L6_2]

    if not L5_2 then

      L5_2 = false

      L6_2 = 1

      L7_2 = Config

      L7_2 = L7_2.Companies

      L7_2 = L7_2.Services

      L7_2 = #L7_2

      L8_2 = 1

      for L9_2 = L6_2, L7_2, L8_2 do

        L10_2 = Config

        L10_2 = L10_2.Companies

        L10_2 = L10_2.Services

        L10_2 = L10_2[L9_2]

        L10_2 = L10_2.job

        L11_2 = A2_2.company

        if L10_2 == L11_2 then

          L5_2 = true

          break

        end

      end

      if not L5_2 then

        L6_2 = debugprint

        L7_2 = "invalid company (does not exist in Config.Companies.Contacts or Config.Companies.Services)"

        L6_2(L7_2)

        L6_2 = false

        return L6_2

      end

    end

    L5_2 = Config

    L5_2 = L5_2.Companies

    L5_2 = L5_2.AllowAnonymous

    if not L5_2 then

      L4_2.hideCallerId = false

    end

    L4_2.videoCall = false

    L5_2 = A2_2.company

    L4_2.company = L5_2

    L5_2 = {}

    L6_2 = {}

    L5_2.nearby = L6_2

    L4_2.callee = L5_2

    L5_2 = GetEmployees

    L6_2 = A2_2.company

    L5_2 = L5_2(L6_2)

    L6_2 = debugprint

    L7_2 = "GetEmployees result:"

    L8_2 = L5_2

    L6_2(L7_2, L8_2)

    L6_2 = 1

    L7_2 = #L5_2

    L8_2 = 1

    for L9_2 = L6_2, L7_2, L8_2 do

      L10_2 = IsInCall

      L11_2 = L5_2[L9_2]

      L10_2 = L10_2(L11_2)

      if not L10_2 then

        L10_2 = L5_2[L9_2]

        if L10_2 ~= A0_2 then

          L11_2 = L5_2[L9_2]

          L10_2 = L1_1

          L10_2 = L10_2[L11_2]

          if not L10_2 then

            L10_2 = TriggerClientEvent

            L11_2 = "phone:phone:setCall"

            L12_2 = L5_2[L9_2]

            L13_2 = {}

            L13_2.callId = L3_2

            L13_2.number = A1_2

            L14_2 = A2_2.company

            L13_2.company = L14_2

            L14_2 = A2_2.companylabel

            L13_2.companylabel = L14_2

            L14_2 = L4_2.hideCallerId

            L13_2.hideCallerId = L14_2

            L10_2(L11_2, L12_2, L13_2)

        end

      end

      else

        L10_2 = debugprint

        L11_2 = "employee"

        L12_2 = L5_2[L9_2]

        L13_2 = "is in call or have disabled company calls"

        L10_2(L11_2, L12_2, L13_2)

      end

    end

  else

    L5_2 = MySQL

    L5_2 = L5_2.Sync

    L5_2 = L5_2.fetchScalar

    L6_2 = [[

            SELECT TRUE FROM phone_phone_blocked_numbers WHERE

                (phone_number = @number1 AND blocked_number = @number2)

                OR (phone_number = @number2 AND blocked_number = @number1)

        ]]

    L7_2 = {}

    L7_2["@number1"] = A1_2

    L8_2 = A2_2.number

    L7_2["@number2"] = L8_2

    L5_2 = L5_2(L6_2, L7_2)

    if L5_2 then

      L6_2 = debugprint

      L7_2 = A0_2

      L8_2 = "tried to call"

      L9_2 = A2_2.number

      L10_2 = "but they are blocked"

      L6_2(L7_2, L8_2, L9_2, L10_2)

      L6_2 = TriggerClientEvent

      L7_2 = "phone:phone:userBusy"

      L8_2 = A0_2

      L6_2(L7_2, L8_2)

      L6_2 = false

      return L6_2

    end

    L6_2 = A2_2.number

    if L6_2 == A1_2 then

      L6_2 = debugprint

      L7_2 = A0_2

      L8_2 = "tried to call themselves"

      L6_2(L7_2, L8_2)

      L6_2 = TriggerClientEvent

      L7_2 = "phone:phone:userBusy"

      L8_2 = A0_2

      L6_2(L7_2, L8_2)

      L6_2 = false

      return L6_2

    end

    L6_2 = GetSourceFromNumber

    L7_2 = A2_2.number

    L6_2 = L6_2(L7_2)

    L7_2 = L6_2 or L7_2

    if L6_2 then

      L7_2 = IsInCall

      L8_2 = L6_2

      L7_2 = L7_2(L8_2)

    end

    if L6_2 and not L7_2 then

      L8_2 = IsPhoneDead

      L9_2 = A2_2.number

      L8_2 = L8_2(L9_2)

      if not L8_2 then

        L8_2 = HasAirplaneMode

        L9_2 = A2_2.number

        L8_2 = L8_2(L9_2)

        if not L8_2 then

          goto lbl_277

        end

      end

    end

    L8_2 = L3_1

    L9_2 = A1_2

    L10_2 = A2_2.number

    L11_2 = 0

    L12_2 = false

    L13_2 = A2_2.hideCallerId

    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)

    if L7_2 then

      L8_2 = debugprint

      L9_2 = A0_2

      L10_2 = "tried to call"

      L11_2 = A2_2.number

      L12_2 = "but they are in call"

      L8_2(L9_2, L10_2, L11_2, L12_2)

      L8_2 = TriggerClientEvent

      L9_2 = "phone:phone:userBusy"

      L10_2 = A0_2

      L8_2(L9_2, L10_2)

    else

      L8_2 = MySQL

      L8_2 = L8_2.scalar

      L8_2 = L8_2.await

      L9_2 = "SELECT TRUE FROM phone_phones WHERE phone_number = ?"

      L10_2 = {}

      L11_2 = A2_2.number

      L10_2[1] = L11_2

      L8_2 = L8_2(L9_2, L10_2)

      L8_2 = nil ~= L8_2

      if L8_2 then

        L9_2 = debugprint

        L10_2 = A0_2

        L11_2 = "tried to call"

        L12_2 = A2_2.number

        L13_2 = "but they are not online, or their phone is dead"

        L9_2(L10_2, L11_2, L12_2, L13_2)

        L9_2 = TriggerClientEvent

        L10_2 = "phone:phone:userUnavailable"

        L11_2 = A0_2

        L9_2(L10_2, L11_2)

      else

        L9_2 = debugprint

        L10_2 = A0_2

        L11_2 = "tried to call"

        L12_2 = A2_2.number

        L13_2 = "but that number doesn't exist"

        L9_2(L10_2, L11_2, L12_2, L13_2)

        L9_2 = "unknown_number"

        return L9_2

      end

    end

    L8_2 = false

    do return L8_2 end

    ::lbl_277::

    L8_2 = {}

    L8_2.source = L6_2

    L9_2 = A2_2.number

    L8_2.number = L9_2

    L9_2 = {}

    L8_2.nearby = L9_2

    L4_2.callee = L8_2

    L8_2 = debugprint

    L9_2 = A0_2

    L10_2 = "is calling"

    L11_2 = A2_2.number

    L12_2 = "with callId"

    L13_2 = L3_2

    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)

    L8_2 = TriggerClientEvent

    L9_2 = "phone:phone:setCall"

    L10_2 = L6_2

    L11_2 = {}

    L11_2.callId = L3_2

    L11_2.number = A1_2

    L12_2 = A2_2.videoCall

    L11_2.videoCall = L12_2

    L12_2 = A2_2.webRTC

    L11_2.webRTC = L12_2

    L12_2 = A2_2.hideCallerId

    L11_2.hideCallerId = L12_2

    L8_2(L9_2, L10_2, L11_2)

  end

  L5_2 = L0_1

  L5_2[L3_2] = L4_2

  L5_2 = TriggerEvent

  L6_2 = "lb-phone:newCall"

  L7_2 = L4_2

  L5_2(L6_2, L7_2)

  return L3_2

end

L4_1(L5_1, L6_1)

L4_1 = RegisterCallback

L5_1 = "answerCall"

function L6_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2

  L2_2 = debugprint

  L3_2 = "answerCall"

  L4_2 = A0_2

  L5_2 = A1_2

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = L0_1

  L2_2 = L2_2[A1_2]

  if not L2_2 then

    L3_2 = debugprint

    L4_2 = "answerCall: invalid call id"

    L3_2(L4_2)

    L3_2 = false

    return L3_2

  end

  L3_2 = L2_2.company

  if L3_2 then

    L3_2 = L2_2.callee

    L3_2 = L3_2.source

    if L3_2 then

      L3_2 = debugprint

      L4_2 = "answerCall: someone else has already answered this company call"

      L3_2(L4_2)

      L3_2 = false

      return L3_2

    end

    L3_2 = GetEmployees

    L4_2 = L2_2.company

    L3_2 = L3_2(L4_2)

    L4_2 = 1

    L5_2 = #L3_2

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = L3_2[L7_2]

      L9_2 = IsInCall

      L10_2 = L8_2

      L9_2 = L9_2(L10_2)

      if not L9_2 and L8_2 ~= A0_2 then

        L9_2 = L1_1

        L9_2 = L9_2[L8_2]

        if not L9_2 then

          L9_2 = TriggerClientEvent

          L10_2 = "phone:phone:endCall"

          L11_2 = L8_2

          L12_2 = A1_2

          L9_2(L10_2, L11_2, L12_2)

        end

      end

    end

    L4_2 = L2_2.callee

    L4_2.source = A0_2

  else

    L3_2 = L2_2.callee

    L3_2 = L3_2.source

    if L3_2 ~= A0_2 then

      L3_2 = debugprint

      L4_2 = "answerCall: invalid callee source"

      L3_2(L4_2)

      L3_2 = false

      return L3_2

    end

  end

  L3_2 = L2_2.caller

  L3_2 = L3_2.source

  L4_2 = L2_2.callee

  L4_2 = L4_2.source

  if not L4_2 then

    L5_2 = debugprint

    L6_2 = "answerCall: no callee source"

    L5_2(L6_2)

    L5_2 = false

    return L5_2

  end

  L5_2 = L3_2 or L5_2

  if L3_2 then

    L5_2 = Player

    L6_2 = L3_2

    L5_2 = L5_2(L6_2)

    L5_2 = L5_2.state

  end

  L6_2 = Player

  L7_2 = L4_2

  L6_2 = L6_2(L7_2)

  L6_2 = L6_2.state

  if L3_2 then

    L5_2.speakerphone = false

    L5_2.mutedCall = false

    L5_2.onCallWith = L4_2

    L5_2.callAnswered = true

  end

  L6_2.speakerphone = false

  L5_2.mutedCall = false

  L7_2 = L3_2 or L7_2

  if not L3_2 then

    L7_2 = L2_2.caller

    L7_2 = L7_2.number

  end

  L6_2.onCallWith = L7_2

  L6_2.callAnswered = true

  L2_2.answered = true

  L7_2 = TriggerClientEvent

  L8_2 = "phone:phone:connectCall"

  L9_2 = A0_2

  L10_2 = A1_2

  L7_2(L8_2, L9_2, L10_2)

  L7_2 = L2_2.caller

  L7_2 = L7_2.source

  if L7_2 then

    L7_2 = TriggerClientEvent

    L8_2 = "phone:phone:connectCall"

    L9_2 = L2_2.caller

    L9_2 = L9_2.source

    L10_2 = A1_2

    L11_2 = L2_2.exportCall

    L11_2 = true == L11_2

    L7_2(L8_2, L9_2, L10_2, L11_2)

  end

  L7_2 = Config

  L7_2 = L7_2.Voice

  L7_2 = L7_2.CallEffects

  if L7_2 then

    L7_2 = L2_2.caller

    L7_2 = L7_2.source

    if L7_2 then

      L7_2 = TriggerClientEvent

      L8_2 = "phone:phone:setCallEffect"

      L9_2 = A0_2

      L10_2 = L2_2.caller

      L10_2 = L10_2.source

      L11_2 = true

      L7_2(L8_2, L9_2, L10_2, L11_2)

      L7_2 = TriggerClientEvent

      L8_2 = "phone:phone:setCallEffect"

      L9_2 = L2_2.caller

      L9_2 = L9_2.source

      L10_2 = A0_2

      L11_2 = true

      L7_2(L8_2, L9_2, L10_2, L11_2)

    end

  end

  L7_2 = TriggerEvent

  L8_2 = "lb-phone:callAnswered"

  L9_2 = L2_2

  L7_2(L8_2, L9_2)

  L7_2 = debugprint

  L8_2 = "answerCall: answered call"

  L9_2 = A1_2

  L7_2(L8_2, L9_2)

  L7_2 = true

  return L7_2

end

L4_1(L5_1, L6_1)

L4_1 = BaseCallback

L5_1 = "requestVideoCall"

function L6_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  if A2_2 then

    L4_2 = L0_1

    L4_2 = L4_2[A2_2]

    if L4_2 then

      goto lbl_20

    end

  end

  L4_2 = debugprint

  L5_2 = "requestVideoCall: invalid call id"

  L6_2 = A2_2

  L7_2 = json

  L7_2 = L7_2.encode

  L8_2 = L0_1

  L9_2 = {}

  L9_2.indent = true

  L7_2, L8_2, L9_2 = L7_2(L8_2, L9_2)

  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)

  L4_2 = false

  do return L4_2 end

  ::lbl_20::

  L4_2 = debugprint

  L5_2 = "requestVideoCall"

  L6_2 = A0_2

  L7_2 = A2_2

  L8_2 = A3_2

  L4_2(L5_2, L6_2, L7_2, L8_2)

  L4_2 = L0_1

  L4_2 = L4_2[A2_2]

  L5_2 = L4_2.videoCall

  if not L5_2 then

    L5_2 = L4_2.answered

    if L5_2 then

      goto lbl_36

    end

  end

  L5_2 = false

  do return L5_2 end

  ::lbl_36::

  L5_2 = L4_2.caller

  L5_2 = L5_2.source

  if L5_2 == A0_2 then

    L5_2 = L4_2.callee

    L5_2 = L5_2.source

    if L5_2 then

      goto lbl_46

    end

  end

  L5_2 = L4_2.caller

  L5_2 = L5_2.source

  ::lbl_46::

  L4_2.videoRequested = true

  if L5_2 then

    L6_2 = TriggerClientEvent

    L7_2 = "phone:phone:videoRequested"

    L8_2 = L5_2

    L9_2 = A3_2

    L6_2(L7_2, L8_2, L9_2)

  end

end

L4_1(L5_1, L6_1)

L4_1 = BaseCallback

L5_1 = "answerVideoRequest"

function L6_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  if A2_2 then

    L4_2 = L0_1

    L4_2 = L4_2[A2_2]

    if L4_2 then

      goto lbl_12

    end

  end

  L4_2 = debugprint

  L5_2 = "answerVideoRequest: invalid call id"

  L4_2(L5_2)

  L4_2 = false

  do return L4_2 end

  ::lbl_12::

  L4_2 = debugprint

  L5_2 = "answerVideoRequest"

  L6_2 = A0_2

  L7_2 = A2_2

  L8_2 = A3_2

  L4_2(L5_2, L6_2, L7_2, L8_2)

  L4_2 = L0_1

  L4_2 = L4_2[A2_2]

  L5_2 = L4_2.caller

  L5_2 = L5_2.source

  if L5_2 == A0_2 then

    L5_2 = L4_2.callee

    L5_2 = L5_2.source

    if L5_2 then

      goto lbl_30

    end

  end

  L5_2 = L4_2.caller

  L5_2 = L5_2.source

  ::lbl_30::

  L6_2 = L4_2.videoCall

  if not L6_2 then

    L6_2 = L4_2.answered

    if L6_2 then

      L6_2 = L4_2.videoRequested

      if L6_2 then

        goto lbl_41

      end

    end

  end

  L6_2 = false

  do return L6_2 end

  ::lbl_41::

  L4_2.videoRequested = false

  L6_2 = true == A3_2

  L4_2.videoCall = L6_2

  if L5_2 then

    L6_2 = TriggerClientEvent

    L7_2 = "phone:phone:videoRequestAnswered"

    L8_2 = L5_2

    L9_2 = A3_2

    L6_2(L7_2, L8_2, L9_2)

  end

  L6_2 = true

  return L6_2

end

L4_1(L5_1, L6_1)

L4_1 = BaseCallback

L5_1 = "stopVideoCall"

function L6_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  if A2_2 then

    L3_2 = L0_1

    L3_2 = L3_2[A2_2]

    if L3_2 then

      goto lbl_12

    end

  end

  L3_2 = debugprint

  L4_2 = "stopVideoCall: invalid call id"

  L3_2(L4_2)

  L3_2 = false

  do return L3_2 end

  ::lbl_12::

  L3_2 = L0_1

  L3_2 = L3_2[A2_2]

  L4_2 = L3_2.caller

  L4_2 = L4_2.source

  if L4_2 == A0_2 then

    L4_2 = L3_2.callee

    L4_2 = L4_2.source

    if L4_2 then

      goto lbl_24

    end

  end

  L4_2 = L3_2.caller

  L4_2 = L4_2.source

  ::lbl_24::

  L5_2 = L3_2.videoCall

  if L5_2 then

    L5_2 = L3_2.answered

    if L5_2 then

      goto lbl_32

    end

  end

  L5_2 = false

  do return L5_2 end

  ::lbl_32::

  L3_2.videoCall = false

  L5_2 = TriggerClientEvent

  L6_2 = "phone:phone:stopVideoCall"

  L7_2 = A0_2

  L5_2(L6_2, L7_2)

  if L4_2 then

    L5_2 = TriggerClientEvent

    L6_2 = "phone:phone:stopVideoCall"

    L7_2 = L4_2

    L5_2(L6_2, L7_2)

  end

  L5_2 = true

  return L5_2

end

L4_1(L5_1, L6_1)

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2

  L2_2 = IsInCall

  L3_2 = A0_2

  L2_2, L3_2 = L2_2(L3_2)

  L4_2 = debugprint

  L5_2 = "^5EndCall^7:"

  L6_2 = A0_2

  L7_2 = L2_2

  L8_2 = L3_2

  L4_2(L5_2, L6_2, L7_2, L8_2)

  if L2_2 and L3_2 then

    L4_2 = L0_1

    L4_2 = L4_2[L3_2]

    if L4_2 then

      goto lbl_28

    end

  end

  if A1_2 then

    L4_2 = A1_2

    L5_2 = false

    L4_2(L5_2)

  end

  L4_2 = debugprint

  L5_2 = "^5EndCall^7: not in call/invalid callId"

  L4_2(L5_2)

  L4_2 = false

  do return L4_2 end

  ::lbl_28::

  L4_2 = L0_1

  L4_2 = L4_2[L3_2]

  L5_2 = L4_2.caller

  L5_2 = L5_2.source

  L6_2 = L4_2.callee

  L6_2 = L6_2.source

  if L6_2 then

    L7_2 = debugprint

    L8_2 = "^5EndCall^7: ending call for callee"

    L9_2 = L3_2

    L10_2 = L6_2

    L7_2(L8_2, L9_2, L10_2)

    L7_2 = TriggerClientEvent

    L8_2 = "phone:phone:endCall"

    L9_2 = L6_2

    L7_2(L8_2, L9_2)

    L7_2 = Config

    L7_2 = L7_2.Voice

    L7_2 = L7_2.CallEffects

    if L7_2 and L5_2 then

      L7_2 = TriggerClientEvent

      L8_2 = "phone:phone:setCallEffect"

      L9_2 = L6_2

      L10_2 = L5_2

      L11_2 = false

      L7_2(L8_2, L9_2, L10_2, L11_2)

      L7_2 = TriggerClientEvent

      L8_2 = "phone:phone:setCallEffect"

      L9_2 = L5_2

      L10_2 = L6_2

      L11_2 = false

      L7_2(L8_2, L9_2, L10_2, L11_2)

    end

  else

    L7_2 = L4_2.company

    if L7_2 then

      L7_2 = GetEmployees

      L8_2 = L4_2.company

      L7_2 = L7_2(L8_2)

      L8_2 = 1

      L9_2 = #L7_2

      L10_2 = 1

      for L11_2 = L8_2, L9_2, L10_2 do

        L12_2 = IsInCall

        L13_2 = L7_2[L11_2]

        L12_2 = L12_2(L13_2)

        if not L12_2 then

          L13_2 = L7_2[L11_2]

          L12_2 = L1_1

          L12_2 = L12_2[L13_2]

          if not L12_2 then

            L12_2 = TriggerClientEvent

            L13_2 = "phone:phone:endCall"

            L14_2 = L7_2[L11_2]

            L15_2 = L3_2

            L12_2(L13_2, L14_2, L15_2)

          end

        end

      end

    end

  end

  if L5_2 then

    L7_2 = debugprint

    L8_2 = "^5EndCall^7: ending call for caller"

    L9_2 = L3_2

    L10_2 = L5_2

    L7_2(L8_2, L9_2, L10_2)

    L7_2 = TriggerClientEvent

    L8_2 = "phone:phone:endCall"

    L9_2 = L5_2

    L7_2(L8_2, L9_2)

  end

  if L5_2 then

    L7_2 = Player

    L8_2 = L5_2

    L7_2 = L7_2(L8_2)

    if L7_2 then

      L7_2 = Player

      L8_2 = L5_2

      L7_2 = L7_2(L8_2)

      L7_2 = L7_2.state

      L7_2.onCallWith = nil

      L7_2.speakerphone = false

      L7_2.mutedCall = false

      L7_2.callAnswered = false

    end

  end

  if L6_2 then

    L7_2 = Player

    L8_2 = L6_2

    L7_2 = L7_2(L8_2)

    if L7_2 then

      L7_2 = Player

      L8_2 = L6_2

      L7_2 = L7_2(L8_2)

      L7_2 = L7_2.state

      L7_2.onCallWith = nil

      L7_2.speakerphone = false

      L7_2.mutedCall = false

      L7_2.callAnswered = false

    end

  end

  L7_2 = TriggerEvent

  L8_2 = "lb-phone:callEnded"

  L9_2 = L4_2

  L10_2 = A0_2

  L7_2(L8_2, L9_2, L10_2)

  L7_2 = Log

  L8_2 = "Calls"

  L9_2 = L4_2.caller

  L9_2 = L9_2.source

  L10_2 = "info"

  L11_2 = L

  L12_2 = "BACKEND.LOGS.CALL_ENDED"

  L11_2 = L11_2(L12_2)

  L12_2 = L

  L13_2 = "BACKEND.LOGS.CALL_DESCRIPTION"

  L14_2 = {}

  L15_2 = os

  L15_2 = L15_2.time

  L15_2 = L15_2()

  L16_2 = L4_2.started

  L15_2 = L15_2 - L16_2

  L14_2.duration = L15_2

  L15_2 = FormatNumber

  L16_2 = L4_2.caller

  L16_2 = L16_2.number

  L15_2 = L15_2(L16_2)

  L14_2.caller = L15_2

  L15_2 = L4_2.callee

  L15_2 = L15_2.number

  if L15_2 then

    L15_2 = FormatNumber

    L16_2 = L4_2.callee

    L16_2 = L16_2.number

    L15_2 = L15_2(L16_2)

    if L15_2 then

      goto lbl_172

    end

  end

  L15_2 = L4_2.company

  ::lbl_172::

  L14_2.callee = L15_2

  L15_2 = L4_2.answered

  L14_2.answered = L15_2

  L12_2, L13_2, L14_2, L15_2, L16_2 = L12_2(L13_2, L14_2)

  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)

  L7_2 = L4_2.company

  if not L7_2 then

    L7_2 = L3_1

    L8_2 = L4_2.caller

    L8_2 = L8_2.number

    L9_2 = L4_2.callee

    L9_2 = L9_2.number

    L10_2 = os

    L10_2 = L10_2.time

    L10_2 = L10_2()

    L11_2 = L4_2.started

    L10_2 = L10_2 - L11_2

    L11_2 = L4_2.answered

    L12_2 = L4_2.hideCallerId

    L13_2 = GetEquippedPhoneNumber

    L14_2 = A0_2

    L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)

    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)

  end

  L7_2 = L0_1

  L7_2[L3_2] = nil

  if A1_2 then

    L7_2 = A1_2

    L8_2 = true

    L7_2(L8_2)

  end

  L7_2 = true

  return L7_2

end

L5_1 = exports

L6_1 = "EndCall"

L7_1 = L4_1

L5_1(L6_1, L7_1)

L5_1 = RegisterNetEvent

L6_1 = "phone:endCall"

function L7_1()

  local L0_2, L1_2, L2_2

  L0_2 = source

  L1_2 = L4_1

  L2_2 = L0_2

  L1_2(L2_2)

end

L5_1(L6_1, L7_1)

L5_1 = BaseCallback

L6_1 = "getRecentVoicemails"

function L7_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L3_2 = MySQL

  L3_2 = L3_2.query

  L3_2 = L3_2.await

  L4_2 = [[

        SELECT id, IF(hide_caller_id, null, caller) AS `number`, url, duration, hide_caller_id AS hideCallerId, `timestamp`

        FROM phone_phone_voicemail

        WHERE callee = ?

        ORDER BY `timestamp` DESC

        LIMIT ?, ?

    ]]

  L5_2 = {}

  L6_2 = A1_2

  L7_2 = A2_2 or L7_2

  if not A2_2 then

    L7_2 = 0

  end

  L7_2 = L7_2 * 25

  L8_2 = 25

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L5_2[3] = L8_2

  return L3_2(L4_2, L5_2)

end

L8_1 = {}

L5_1(L6_1, L7_1, L8_1)

L5_1 = BaseCallback

L6_1 = "deleteVoiceMail"

function L7_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = MySQL

  L3_2 = L3_2.update

  L3_2 = L3_2.await

  L4_2 = "DELETE FROM phone_phone_voicemail WHERE id = ? AND callee = ?"

  L5_2 = {}

  L6_2 = A2_2

  L7_2 = A1_2

  L5_2[1] = L6_2

  L5_2[2] = L7_2

  L3_2 = L3_2(L4_2, L5_2)

  L3_2 = L3_2 > 0

  return L3_2

end

L5_1(L6_1, L7_1)

L5_1 = BaseCallback

L6_1 = "sendVoicemail"

function L7_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = MySQL

  L3_2 = L3_2.insert

  L3_2 = L3_2.await

  L4_2 = "INSERT INTO phone_phone_voicemail (caller, callee, url, duration, hide_caller_id) VALUES (@caller, @callee, @url, @duration, @hideCallerId)"

  L5_2 = {}

  L5_2["@caller"] = A1_2

  L6_2 = A2_2.number

  L5_2["@callee"] = L6_2

  L6_2 = A2_2.src

  L5_2["@url"] = L6_2

  L6_2 = A2_2.duration

  L5_2["@duration"] = L6_2

  L6_2 = A2_2.hideCallerId

  L6_2 = true == L6_2

  L5_2["@hideCallerId"] = L6_2

  L3_2(L4_2, L5_2)

  L3_2 = SendNotification

  L4_2 = A2_2.number

  L5_2 = {}

  L5_2.app = "Phone"

  L6_2 = L

  L7_2 = "BACKEND.CALLS.NEW_VOICEMAIL"

  L6_2 = L6_2(L7_2)

  L5_2.title = L6_2

  L3_2(L4_2, L5_2)

  L3_2 = true

  return L3_2

end

L5_1(L6_1, L7_1)

function L5_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = debugprint

  L2_2 = "checking if"

  L3_2 = A0_2

  L4_2 = "has airplane mode enabled"

  L1_2(L2_2, L3_2, L4_2)

  L1_2 = GetSettings

  L2_2 = A0_2

  L1_2 = L1_2(L2_2)

  if not L1_2 then

    L2_2 = debugprint

    L3_2 = "no settings found for"

    L4_2 = A0_2

    L2_2(L3_2, L4_2)

    return

  end

  L2_2 = L1_2.airplaneMode

  return L2_2

end

HasAirplaneMode = L5_1

L5_1 = exports

L6_1 = "HasAirplaneMode"

L7_1 = HasAirplaneMode

L5_1(L6_1, L7_1)

L5_1 = exports

L6_1 = "CreateCall"

function L7_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2

  if not A2_2 then

    L3_2 = {}

    A2_2 = L3_2

  end

  L3_2 = type

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  if "table" == L3_2 then

    L3_2 = A0_2.source

    if L3_2 then

      goto lbl_15

    end

  end

  L3_2 = nil

  ::lbl_15::

  L4_2 = type

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L4_2 = A0_2 or L4_2

  if "string" ~= L4_2 or not A0_2 then

    L4_2 = A0_2.phoneNumber

  end

  if L3_2 then

    L5_2 = GetPlayerName

    L6_2 = L3_2

    L5_2 = L5_2(L6_2)

    if not L5_2 then

      L5_2 = debugprint

      L6_2 = "CreateCall: callerSrc is not a valid player"

      return L5_2(L6_2)

    end

    L5_2 = A2_2.requirePhone

    if L5_2 then

      L5_2 = IsPhoneDead

      L6_2 = L4_2

      L5_2 = L5_2(L6_2)

      if not L5_2 then

        L5_2 = HasPhoneItem

        L6_2 = L3_2

        L7_2 = L4_2

        L5_2 = L5_2(L6_2, L7_2)

        if L5_2 then

          goto lbl_52

        end

      end

      L5_2 = debugprint

      L6_2 = "CreateCall: caller does not have a phone"

      return L5_2(L6_2)

    end

    ::lbl_52::

    L5_2 = IsInCall

    L6_2 = L3_2

    L5_2 = L5_2(L6_2)

    if L5_2 then

      L5_2 = debugprint

      L6_2 = "CreateCall: caller is already in a call"

      return L5_2(L6_2)

    end

  end

  L5_2 = A2_2.company

  if not L5_2 and not A1_2 then

    L5_2 = debugprint

    L6_2 = "CreateCall: no callee or company provided"

    return L5_2(L6_2)

  end

  L5_2 = L2_1

  L5_2 = L5_2()

  L6_2 = {}

  L7_2 = os

  L7_2 = L7_2.time

  L7_2 = L7_2()

  L6_2.started = L7_2

  L6_2.answered = false

  L6_2.videoCall = false

  L7_2 = A2_2.hideNumber

  L7_2 = true == L7_2

  L6_2.hideCallerId = L7_2

  L6_2.callId = L5_2

  L7_2 = {}

  L7_2.source = L3_2

  L7_2.number = L4_2

  L8_2 = {}

  L7_2.nearby = L8_2

  L6_2.caller = L7_2

  L6_2.exportCall = true

  L7_2 = A2_2.company

  if L7_2 then

    L7_2 = Config

    L7_2 = L7_2.Companies

    L7_2 = L7_2.Enabled

    if not L7_2 then

      L7_2 = debugprint

      L8_2 = "company calls are disabled in config"

      L7_2(L8_2)

      return

    end

    L7_2 = false

    L8_2 = A2_2.company

    L9_2 = Config

    L9_2 = L9_2.Companies

    L9_2 = L9_2.Contacts

    L10_2 = A2_2.company

    L9_2 = L9_2[L10_2]

    if L9_2 then

      L9_2 = Config

      L9_2 = L9_2.Companies

      L9_2 = L9_2.Contacts

      L10_2 = A2_2.company

      L9_2 = L9_2[L10_2]

      L8_2 = L9_2.name

      L7_2 = true

    else

      L9_2 = 1

      L10_2 = Config

      L10_2 = L10_2.Companies

      L10_2 = L10_2.Services

      L10_2 = #L10_2

      L11_2 = 1

      for L12_2 = L9_2, L10_2, L11_2 do

        L13_2 = Config

        L13_2 = L13_2.Companies

        L13_2 = L13_2.Services

        L13_2 = L13_2[L12_2]

        L14_2 = L13_2.job

        L15_2 = A2_2.company

        if L14_2 == L15_2 then

          L7_2 = true

          L8_2 = L13_2.name

          break

        end

      end

    end

    if not L7_2 then

      L9_2 = debugprint

      L10_2 = "invalid company"

      L9_2(L10_2)

      return

    end

    L9_2 = A2_2.company

    L6_2.company = L9_2

    L9_2 = {}

    L10_2 = {}

    L9_2.nearby = L10_2

    L6_2.callee = L9_2

    L9_2 = GetEmployees

    L10_2 = A2_2.company

    L9_2 = L9_2(L10_2)

    L10_2 = 1

    L11_2 = #L9_2

    L12_2 = 1

    for L13_2 = L10_2, L11_2, L12_2 do

      L14_2 = L9_2[L13_2]

      L15_2 = IsInCall

      L16_2 = L14_2

      L15_2 = L15_2(L16_2)

      if not L15_2 and L14_2 ~= L3_2 then

        L15_2 = L1_1

        L15_2 = L15_2[L14_2]

        if not L15_2 then

          L15_2 = TriggerClientEvent

          L16_2 = "phone:phone:setCall"

          L17_2 = L14_2

          L18_2 = {}

          L18_2.callId = L5_2

          L18_2.number = L4_2

          L19_2 = A2_2.company

          L18_2.company = L19_2

          L18_2.companylabel = L8_2

          L15_2(L16_2, L17_2, L18_2)

        end

      end

    end

  elseif A1_2 then

    L7_2 = GetSourceFromNumber

    L8_2 = A1_2

    L7_2 = L7_2(L8_2)

    if not L7_2 then

      L8_2 = debugprint

      L9_2 = "CreateCall: calleeSrc is not a valid player"

      return L8_2(L9_2)

    end

    L8_2 = IsInCall

    L9_2 = L7_2

    L8_2 = L8_2(L9_2)

    if L8_2 then

      L8_2 = debugprint

      L9_2 = "CreateCall: caller or callee is in call"

      return L8_2(L9_2)

    end

    L8_2 = {}

    L8_2.source = L7_2

    L8_2.number = A1_2

    L9_2 = {}

    L8_2.nearby = L9_2

    L6_2.callee = L8_2

    L8_2 = TriggerClientEvent

    L9_2 = "phone:phone:setCall"

    L10_2 = L7_2

    L11_2 = {}

    L11_2.callId = L5_2

    L11_2.number = L4_2

    L12_2 = A2_2.hideNumber

    L12_2 = true == L12_2

    L11_2.hideCallerId = L12_2

    L8_2(L9_2, L10_2, L11_2)

  end

  L7_2 = L0_1

  L7_2[L5_2] = L6_2

  L7_2 = TriggerEvent

  L8_2 = "lb-phone:newCall"

  L9_2 = L6_2

  L7_2(L8_2, L9_2)

  if L3_2 then

    L7_2 = TriggerClientEvent

    L8_2 = "phone:phone:enableExportCall"

    L9_2 = L3_2

    L7_2(L8_2, L9_2)

  end

  return L5_2

end

L5_1(L6_1, L7_1)

L5_1 = exports

L6_1 = "AddContact"

function L7_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = assert

  L3_2 = type

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  L3_2 = "string" == L3_2

  L4_2 = "phoneNumber must be a string"

  L2_2(L3_2, L4_2)

  L2_2 = assert

  L3_2 = type

  L4_2 = A1_2

  L3_2 = L3_2(L4_2)

  L3_2 = "table" == L3_2

  L4_2 = "data must be a table"

  L2_2(L3_2, L4_2)

  L2_2 = CreateContact

  L3_2 = A0_2

  L4_2 = A1_2

  L2_2 = L2_2(L3_2, L4_2)

  L3_2 = debugprint

  L4_2 = "AddContact: success"

  L5_2 = L2_2

  L3_2(L4_2, L5_2)

  L3_2 = GetSourceFromNumber

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  if L3_2 and L2_2 then

    L4_2 = TriggerClientEvent

    L5_2 = "phone:phone:contactAdded"

    L6_2 = L3_2

    L7_2 = A1_2

    L4_2(L5_2, L6_2, L7_2)

  end

end

L5_1(L6_1, L7_1)

L5_1 = AddEventHandler

L6_1 = "playerDropped"

function L7_1()

  local L0_2, L1_2, L2_2

  L0_2 = source

  L1_2 = L1_1

  L1_2[L0_2] = nil

  L1_2 = L4_1

  L2_2 = L0_2

  L1_2(L2_2)

end

L5_1(L6_1, L7_1)
