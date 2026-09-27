local L0_1, L1_1, L2_1, L3_1

L0_1 = {}

L0_1.Twitter = true

L0_1.Instagram = true

L0_1.TikTok = true

L0_1.Mail = true

L0_1.DarkChat = true

L1_1 = RegisterNUICallback

L2_1 = "AccountSwitcher"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = debugprint

  L3_2 = "AccountSwitcher:"

  L4_2 = A0_2.action

  if not L4_2 then

    L4_2 = ""

  end

  L3_2 = L3_2 .. L4_2

  L2_2(L3_2)

  L2_2 = currentPhone

  if L2_2 then

    L3_2 = A0_2.app

    L2_2 = L0_1

    L2_2 = L2_2[L3_2]

    if L2_2 then

      goto lbl_25

    end

  end

  L2_2 = debugprint

  L3_2 = "AccountSwitcher: Invalid app / no currentPhone"

  L4_2 = A0_2.app

  L2_2(L3_2, L4_2)

  L2_2 = A1_2

  L3_2 = false

  do return L2_2(L3_2) end

  ::lbl_25::

  L2_2 = A0_2.action

  if "switch" == L2_2 then

    L2_2 = TriggerCallback

    L3_2 = "accountSwitcher:switchAccount"

    L4_2 = A1_2

    L5_2 = A0_2.app

    L6_2 = A0_2.account

    L2_2(L3_2, L4_2, L5_2, L6_2)

  else

    L2_2 = A0_2.action

    if "getAccounts" == L2_2 then

      L2_2 = TriggerCallback

      L3_2 = "accountSwitcher:getAccounts"

      function L4_2(A0_3)

        local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3

        if not A0_3 then

          L1_3 = A1_2

          L2_3 = false

          L1_3(L2_3)

        end

        L1_3 = {}

        L2_3 = 1

        L3_3 = #A0_3

        L4_3 = 1

        for L5_3 = L2_3, L3_3, L4_3 do

          L6_3 = A0_3[L5_3]

          L6_3 = L6_3.username

          L1_3[L5_3] = L6_3

        end

        L2_3 = A1_2

        L3_3 = L1_3

        L2_3(L3_3)

      end

      L5_2 = A0_2.app

      L2_2(L3_2, L4_2, L5_2)

    end

  end

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:logoutFromApp"

function L3_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = debugprint

  L2_2 = "logoutFromApp:"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = A0_2.number

  if L1_2 then

    L1_2 = A0_2.number

    L2_2 = currentPhone

    if L1_2 == L2_2 then

      L1_2 = debugprint

      L2_2 = "Ignoring logoutFromApp event since number matches"

      return L1_2(L2_2)

    end

  end

  L1_2 = debugprint

  L2_2 = A0_2.app

  L3_2 = ":logout"

  L2_2 = L2_2 .. L3_2

  L3_2 = A0_2.username

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = A0_2.app

  L3_2 = ":logout"

  L2_2 = L2_2 .. L3_2

  L3_2 = A0_2.username

  L1_2(L2_2, L3_2)

end

L1_1(L2_1, L3_1)