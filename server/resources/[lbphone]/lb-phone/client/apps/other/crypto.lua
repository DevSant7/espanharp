local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1

L0_1 = Config

L0_1 = L0_1.Crypto

if L0_1 then

  L0_1 = Config

  L0_1 = L0_1.Crypto

  L0_1 = L0_1.Enabled

  if L0_1 then

    goto lbl_12

  end

end

do return end

::lbl_12::

L0_1 = {}

L1_1 = false

function L2_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L1_2 = 1

  L2_2 = L0_1

  L2_2 = #L2_2

  L3_2 = 1

  for L4_2 = L1_2, L2_2, L3_2 do

    L5_2 = L0_1

    L5_2 = L5_2[L4_2]

    L6_2 = L5_2.id

    if L6_2 == A0_2 then

      L6_2 = L4_2

      L7_2 = L5_2

      return L6_2, L7_2

    end

  end

  L1_2 = false

  return L1_2

end

function L3_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L0_2 = Config

  L0_2 = L0_2.Crypto

  L0_2 = L0_2.QBit

  if L0_2 then

    L0_2 = Config

    L0_2 = L0_2.Framework

    if "qb" == L0_2 then

      goto lbl_11

    end

  end

  do return end

  ::lbl_11::

  L0_2 = L2_1

  L1_2 = "qbit"

  L0_2 = L0_2(L1_2)

  if not L0_2 then

    L1_2 = L0_1

    L1_2 = #L1_2

    L0_2 = L1_2 + 1

  end

  L1_2 = GetQBit

  L1_2 = L1_2()

  L2_2 = {}

  L3_2 = 1

  L4_2 = L1_2.History

  L4_2 = #L4_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = #L2_2

    L7_2 = L7_2 + 1

    L8_2 = L1_2.History

    L8_2 = L8_2[L6_2]

    L8_2 = L8_2.PreviousWorth

    L2_2[L7_2] = L8_2

    L7_2 = #L2_2

    L7_2 = L7_2 + 1

    L8_2 = L1_2.History

    L8_2 = L8_2[L6_2]

    L8_2 = L8_2.NewWorth

    L2_2[L7_2] = L8_2

  end

  L3_2 = L1_2.History

  L3_2 = #L3_2

  if 0 == L3_2 then

    L3_2 = 1

    L4_2 = 10

    L5_2 = 1

    for L6_2 = L3_2, L4_2, L5_2 do

      L7_2 = L1_2.Worth

      L8_2 = math

      L8_2 = L8_2.random

      L9_2 = -10

      L10_2 = 10

      L8_2 = L8_2(L9_2, L10_2)

      L7_2 = L7_2 + L8_2

      L2_2[L6_2] = L7_2

    end

  end

  L3_2 = L0_1

  L4_2 = {}

  L5_2 = L1_2.History

  L5_2 = #L5_2

  if L5_2 > 0 then

    L5_2 = L1_2.History

    L6_2 = L1_2.History

    L6_2 = #L6_2

    L5_2 = L5_2[L6_2]

    L5_2 = L5_2.NewWorth

    L6_2 = L1_2.History

    L6_2 = L6_2[1]

    L6_2 = L6_2.PreviousWorth

    L5_2 = L5_2 - L6_2

    if L5_2 then

      goto lbl_82

    end

  end

  L5_2 = 0

  ::lbl_82::

  L4_2.change_24h = L5_2

  L5_2 = L1_2.Worth

  L4_2.current_price = L5_2

  L4_2.id = "qbit"

  L4_2.image = "https://avatars.githubusercontent.com/u/81791099?s=200&v=4"

  L4_2.name = "QBit"

  L4_2.prices = L2_2

  L4_2.symbol = "qbit"

  L5_2 = L1_2.Portfolio

  L4_2.owned = L5_2

  L3_2[L0_2] = L4_2

end

function L4_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2

  L2_2 = nil

  if "qbit" == A0_2 then

    L3_2 = BuyQBit

    if L3_2 then

      L3_2 = BuyQBit

      L4_2 = A1_2

      L3_2 = L3_2(L4_2)

      L2_2 = L3_2

  end

  else

    L3_2 = AwaitCallback

    L4_2 = "crypto:buy"

    L5_2 = A0_2

    L6_2 = A1_2

    L3_2 = L3_2(L4_2, L5_2, L6_2)

    L2_2 = L3_2

  end

  L3_2 = false

  L1_1 = L3_2

  L3_2 = L2_2.success

  if not L3_2 then

    return L2_2

  end

  L3_2 = L2_1

  L4_2 = A0_2

  L3_2, L4_2 = L3_2(L4_2)

  if not L4_2 then

    return L2_2

  end

  L5_2 = L4_2.owned

  if not L5_2 then

    L5_2 = 0

  end

  L4_2.owned = L5_2

  L5_2 = L4_2.owned

  L6_2 = L4_2.current_price

  L6_2 = A1_2 / L6_2

  L5_2 = L5_2 + L6_2

  L4_2.owned = L5_2

  L5_2 = L4_2.invested

  if not L5_2 then

    L5_2 = 0

  end

  L4_2.invested = L5_2

  L5_2 = L4_2.invested

  L5_2 = L5_2 + A1_2

  L4_2.invested = L5_2

  return L2_2

end

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = nil

  if "qbit" == A0_2 then

    L3_2 = SellQBit

    if L3_2 then

      L3_2 = SellQBit

      L4_2 = A1_2

      L3_2 = L3_2(L4_2)

      L2_2 = L3_2

  end

  else

    L3_2 = AwaitCallback

    L4_2 = "crypto:sell"

    L5_2 = A0_2

    L6_2 = A1_2

    L3_2 = L3_2(L4_2, L5_2, L6_2)

    L2_2 = L3_2

  end

  L3_2 = false

  L1_1 = L3_2

  L3_2 = L2_2.success

  if not L3_2 then

    return L2_2

  end

  L3_2 = L2_1

  L4_2 = A0_2

  L3_2, L4_2 = L3_2(L4_2)

  if not L4_2 then

    return L2_2

  end

  L5_2 = L4_2.invested

  L6_2 = L4_2.owned

  if not L5_2 or not L6_2 then

    return L2_2

  end

  L7_2 = L4_2.current_price

  L7_2 = A1_2 * L7_2

  L7_2 = L5_2 - L7_2

  L4_2.invested = L7_2

  L7_2 = L6_2 - A1_2

  L4_2.owned = L7_2

  return L2_2

end

function L6_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L3_2 = nil

  if "qbit" == A0_2 then

    L4_2 = TransferQBit

    if L4_2 then

      L4_2 = TransferQBit

      L5_2 = A1_2

      L4_2 = L4_2(L5_2)

      L3_2 = L4_2

  end

  else

    L4_2 = AwaitCallback

    L5_2 = "crypto:transfer"

    L6_2 = A0_2

    L7_2 = A1_2

    L8_2 = A2_2

    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)

    L3_2 = L4_2

  end

  L4_2 = false

  L1_1 = L4_2

  L4_2 = L3_2.success

  if not L4_2 then

    return L3_2

  end

  L4_2 = L2_1

  L5_2 = A0_2

  L4_2, L5_2 = L4_2(L5_2)

  if not L5_2 then

    return L3_2

  end

  L6_2 = L5_2.invested

  L7_2 = L5_2.owned

  if not L6_2 or not L7_2 then

    return L3_2

  end

  L8_2 = L5_2.current_price

  L8_2 = A1_2 * L8_2

  L8_2 = L6_2 - L8_2

  L5_2.invested = L8_2

  L8_2 = L7_2 - A1_2

  L5_2.owned = L8_2

  return L3_2

end

L7_1 = RegisterNUICallback

L8_1 = "Crypto"

function L9_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Crypto:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "buy" == L2_2 or "sell" == L2_2 or "transfer" == L2_2 then

    L3_2 = L1_1

    if L3_2 then

      L3_2 = A1_2

      L4_2 = {}

      L4_2.success = false

      L4_2.msg = "BUSY"

      return L3_2(L4_2)

    end

    L3_2 = true

    L1_1 = L3_2

  end

  if "buy" == L2_2 then

    L3_2 = A1_2

    L4_2 = L4_1

    L5_2 = A0_2.coin

    L6_2 = A0_2.amount

    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2)

    return L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "sell" == L2_2 then

    L3_2 = A1_2

    L4_2 = L5_1

    L5_2 = A0_2.coin

    L6_2 = A0_2.amount

    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2)

    return L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "transfer" == L2_2 then

    L3_2 = A1_2

    L4_2 = L6_1

    L5_2 = A0_2.coin

    L6_2 = A0_2.amount

    L7_2 = A0_2.number

    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2)

    return L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "get" == L2_2 then

    L3_2 = L3_1

    L3_2()

    L3_2 = TriggerServerEvent

    L4_2 = "phone:crypto:fetchCoins"

    L3_2(L4_2)

    L3_2 = A1_2

    L4_2 = L0_1

    return L3_2(L4_2)

  elseif "openedApp" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:crypto:setAppOpen"

    L5_2 = true

    L3_2(L4_2, L5_2)

  elseif "closedApp" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:crypto:setAppOpen"

    L5_2 = false

    L3_2(L4_2, L5_2)

  end

  L3_2 = A1_2

  L4_2 = "ok"

  L3_2(L4_2)

end

L7_1(L8_1, L9_1)

function L7_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L0_2 = AwaitCallback

  L1_2 = "crypto:get"

  L0_2 = L0_2(L1_2)

  if not L0_2 then

    return

  end

  L1_2 = table

  L1_2 = L1_2.wipe

  L2_2 = L0_1

  L1_2(L2_2)

  L1_2 = pairs

  L2_2 = L0_2

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = L0_1

    L7_2 = #L7_2

    L8_2 = L7_2 + 1

    L7_2 = L0_1

    L7_2[L8_2] = L6_2

  end

  L1_2 = SendReactMessage

  L2_2 = "crypto:updateCoins"

  L3_2 = L0_1

  L1_2(L2_2, L3_2)

end

FetchCryptoCoins = L7_1

L7_1 = CreateThread

function L8_1()

  local L0_2, L1_2

  while true do

    L0_2 = FrameworkLoaded

    if L0_2 then

      break

    end

    L0_2 = Wait

    L1_2 = 500

    L0_2(L1_2)

  end

  L0_2 = FetchCryptoCoins

  L0_2()

end

L7_1(L8_1)

L7_1 = RegisterNetEvent

L8_1 = "phone:crypto:updateCoins"

function L9_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L1_2 = 1

  L2_2 = L0_1

  L2_2 = #L2_2

  L3_2 = 1

  for L4_2 = L1_2, L2_2, L3_2 do

    L5_2 = L0_1

    L5_2 = L5_2[L4_2]

    L6_2 = L5_2.id

    L6_2 = A0_2[L6_2]

    if L6_2 then

      L7_2 = L6_2.current_price

      L5_2.current_price = L7_2

      L7_2 = L6_2.change_24h

      L5_2.change_24h = L7_2

      L7_2 = L6_2.prices

      L5_2.prices = L7_2

    end

  end

  L1_2 = pairs

  L2_2 = A0_2

  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)

  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do

    L7_2 = L2_1

    L8_2 = L5_2

    L7_2 = L7_2(L8_2)

    if not L7_2 then

      L7_2 = L0_1

      L7_2 = #L7_2

      L8_2 = L7_2 + 1

      L7_2 = L0_1

      L7_2[L8_2] = L6_2

    end

  end

  L1_2 = debugprint

  L2_2 = "updated crypto cache"

  L1_2(L2_2)

  L1_2 = SendReactMessage

  L2_2 = "crypto:updateCoins"

  L3_2 = L0_1

  L1_2(L2_2, L3_2)

end

L7_1(L8_1, L9_1)

L7_1 = RegisterNetEvent

L8_1 = "phone:crypto:changeOwnedAmount"

function L9_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L2_2 = L2_1

  L3_2 = A0_2

  L2_2, L3_2 = L2_2(L3_2)

  if not L3_2 then

    return

  end

  L4_2 = L3_2.owned

  if not L4_2 then

    L4_2 = 0

  end

  L4_2 = L4_2 + A1_2

  L3_2.owned = L4_2

  L4_2 = debugprint

  L5_2 = "updated crypto cache"

  L6_2 = A0_2

  L7_2 = A1_2

  L8_2 = L3_2.owned

  L4_2(L5_2, L6_2, L7_2, L8_2)

  L4_2 = SendReactMessage

  L5_2 = "crypto:updateCoins"

  L6_2 = L0_1

  L4_2(L5_2, L6_2)

end

L7_1(L8_1, L9_1)

L7_1 = exports

L8_1 = "GetCoinValue"

function L9_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = L2_1

  L2_2 = A0_2

  L1_2, L2_2 = L1_2(L2_2)

  L3_2 = L2_2 or L3_2

  if L2_2 then

    L3_2 = L2_2.current_price

  end

  return L3_2

end

L7_1(L8_1, L9_1)

L7_1 = exports

L8_1 = "GetCryptoWallet"

function L9_1()

  local L0_2, L1_2

  L0_2 = L0_1

  return L0_2

end

L7_1(L8_1, L9_1)

L7_1 = exports

L8_1 = "GetOwnedCoin"

function L9_1(A0_2)

  local L1_2, L2_2

  L1_2 = L2_1

  L2_2 = A0_2

  L1_2, L2_2 = L1_2(L2_2)

  return L2_2

end

L7_1(L8_1, L9_1)