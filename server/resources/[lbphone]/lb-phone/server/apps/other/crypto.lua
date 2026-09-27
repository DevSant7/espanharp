local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1

L0_1 = Config

L0_1 = L0_1.Crypto

if L0_1 then

  L0_1 = Config

  L0_1 = L0_1.Crypto

  L0_1 = L0_1.Enabled

  if L0_1 then

    goto lbl_15

  end

end

L0_1 = debugprint

L1_1 = "crypto disabled"

L0_1(L1_1)

do return end

::lbl_15::

L0_1 = Config

L0_1 = L0_1.Crypto

if L0_1 then

  L0_1 = Config

  L0_1 = L0_1.Crypto

  L0_1 = L0_1.Limits

  if L0_1 then

    goto lbl_28

  end

end

L0_1 = {}

L0_1.Buy = 1000000

L0_1.Sell = 1000000

::lbl_28::

L1_1 = {}

L2_1 = {}

L3_1 = false

L4_1 = {}

L5_1 = {}

L6_1 = RegisterNetEvent

L7_1 = "phone:crypto:setAppOpen"

function L8_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = source

  L2_2 = table

  L2_2 = L2_2.contains

  L3_2 = L4_1

  L4_2 = L1_2

  L2_2, L3_2 = L2_2(L3_2, L4_2)

  if L2_2 and not A0_2 then

    L4_2 = table

    L4_2 = L4_2.remove

    L5_2 = L4_1

    L6_2 = L3_2

    L4_2(L5_2, L6_2)

  elseif not L2_2 and A0_2 then

    L4_2 = L4_1

    L4_2 = #L4_2

    L5_2 = L4_2 + 1

    L4_2 = L4_1

    L4_2[L5_2] = L1_2

  end

end

L6_1(L7_1, L8_1)

function L6_1(A0_2, ...)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2

  L1_2 = L4_1

  L1_2 = #L1_2

  if 0 == L1_2 then

    return

  end

  L1_2 = msgpack

  L1_2 = L1_2.pack_args

  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = ...

  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

  L2_2 = #L1_2

  L3_2 = 1

  L4_2 = L4_1

  L4_2 = #L4_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = TriggerLatentClientEventInternal

    L8_2 = A0_2

    L9_2 = L4_1

    L9_2 = L9_2[L6_2]

    L10_2 = L1_2

    L11_2 = L2_2

    L12_2 = 1000000.0

    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)

  end

end

function L7_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L1_2 = 0

  L2_2 = 1

  L3_2 = #A0_2

  L4_2 = 1

  for L5_2 = L2_2, L3_2, L4_2 do

    L6_2 = A0_2[L5_2]

    L1_2 = L1_2 + L6_2

  end

  L2_2 = math

  L2_2 = L2_2.random

  L2_2 = L2_2()

  L2_2 = L2_2 * L1_2

  L3_2 = 1

  L4_2 = #A0_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = A0_2[L6_2]

    L2_2 = L2_2 - L7_2

    if L2_2 <= 0 then

      return L6_2

    end

  end

  L3_2 = 1

  return L3_2

end

L8_1 = CreateThread

function L9_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2

  L0_2 = Config

  L0_2 = L0_2.Crypto

  L0_2 = L0_2.Coins

  if L0_2 then

    L0_2 = next

    L1_2 = Config

    L1_2 = L1_2.Crypto

    L1_2 = L1_2.Coins

    L0_2 = L0_2(L1_2)

    if L0_2 then

      goto lbl_16

    end

  end

  L0_2 = true

  L3_1 = L0_2

  do return end

  ::lbl_16::

  L0_2 = table

  L0_2 = L0_2.type

  L1_2 = Config

  L1_2 = L1_2.Crypto

  L1_2 = L1_2.Coins

  L0_2 = L0_2(L1_2)

  if "array" == L0_2 then

    L0_2 = infoprint

    L1_2 = "error"

    L2_2 = "Config.Crypto.Coins is an array, but it should be an object."

    L0_2(L1_2, L2_2)

  end

  L0_2 = GetResourceKvpInt

  L1_2 = "crypto:lastUpdated"

  L0_2 = L0_2(L1_2)

  if not L0_2 then

    L0_2 = 0

  end

  L1_2 = GetResourceKvpInt

  L2_2 = "crypto:lastTrackedPrice"

  L1_2 = L1_2(L2_2)

  if not L1_2 then

    L1_2 = 0

  end

  L2_2 = math

  L2_2 = L2_2.floor

  L3_2 = Config

  L3_2 = L3_2.Crypto

  L3_2 = L3_2.UpdateInterval

  if not L3_2 then

    L3_2 = 5

  end

  L3_2 = L3_2 * 60

  L3_2 = L3_2 * 1000

  L2_2 = L2_2(L3_2)

  L3_2 = os

  L3_2 = L3_2.time

  L3_2 = L3_2()

  L3_2 = L3_2 * 1000

  L4_2 = L0_2 * 1000

  L3_2 = L3_2 - L4_2

  L3_2 = L2_2 - L3_2

  L4_2 = math

  L4_2 = L4_2.max

  L5_2 = 900

  L6_2 = math

  L6_2 = L6_2.floor

  L7_2 = L2_2 / 1000

  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2 = L6_2(L7_2)

  L4_2 = L4_2(L5_2, L6_2)

  L5_2 = math

  L5_2 = L5_2.floor

  L6_2 = 86400

  L6_2 = L6_2 / L4_2

  L5_2 = L5_2(L6_2)

  L6_2 = pairs

  L7_2 = Config

  L7_2 = L7_2.Crypto

  L7_2 = L7_2.Coins

  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)

  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do

    L12_2 = L1_1

    L13_2 = {}

    L13_2.id = L10_2

    L14_2 = L11_2.name

    L13_2.name = L14_2

    L13_2.symbol = L10_2

    L14_2 = L11_2.permissions

    L13_2.permissions = L14_2

    L13_2.change_24h = 0

    L14_2 = math

    L14_2 = L14_2.clamp

    L15_2 = L11_2.initialValue

    L16_2 = 0.1

    L17_2 = math

    L17_2 = L17_2.huge

    L14_2 = L14_2(L15_2, L16_2, L17_2)

    L13_2.current_price = L14_2

    L14_2 = L11_2.icon

    L13_2.image = L14_2

    L14_2 = {}

    L13_2.prices = L14_2

    L12_2[L10_2] = L13_2

  end

  L6_2 = MySQL

  L6_2 = L6_2.query

  L6_2 = L6_2.await

  L7_2 = "SELECT coin, coin_value FROM phone_crypto_coins"

  L6_2 = L6_2(L7_2)

  L7_2 = 1

  L8_2 = #L6_2

  L9_2 = 1

  for L10_2 = L7_2, L8_2, L9_2 do

    L11_2 = L6_2[L10_2]

    L13_2 = L11_2.coin

    L12_2 = L1_1

    L12_2 = L12_2[L13_2]

    if not L12_2 then

      L13_2 = debugprint

      L14_2 = "Unknown coin in database:"

      L15_2 = L11_2.coin

      L13_2(L14_2, L15_2)

    else

      L13_2 = L11_2.coin_value

      L12_2.current_price = L13_2

      L13_2 = GetResourceKvpString

      L14_2 = "crypto:history:"

      L15_2 = L11_2.coin

      L14_2 = L14_2 .. L15_2

      L13_2 = L13_2(L14_2)

      if not L13_2 then

      else

        L14_2 = json

        L14_2 = L14_2.decode

        L15_2 = L13_2

        L14_2 = L14_2(L15_2)

        L15_2 = {}

        L12_2.prices = L15_2

        L15_2 = os

        L15_2 = L15_2.time

        L15_2 = L15_2()

        L15_2 = L15_2 - 86400

        L16_2 = #L14_2

        L17_2 = 1

        L18_2 = -1

        for L19_2 = L16_2, L17_2, L18_2 do

          L20_2 = L14_2[L19_2]

          L21_2 = L20_2.time

          if L15_2 <= L21_2 then

            L21_2 = L12_2.prices

            L22_2 = L12_2.prices

            L22_2 = #L22_2

            L22_2 = L22_2 + 1

            L23_2 = L20_2.value

            L21_2[L22_2] = L23_2

          else

            L21_2 = table

            L21_2 = L21_2.remove

            L22_2 = L14_2

            L23_2 = L19_2

            L21_2(L22_2, L23_2)

          end

        end

        L17_2 = L11_2.coin

        L16_2 = L2_1

        L16_2[L17_2] = L14_2

        L16_2 = #L14_2

        if L16_2 < 2 then

        else

          L16_2 = L14_2[1]

          L16_2 = L16_2.value

          L17_2 = #L14_2

          L17_2 = L14_2[L17_2]

          L17_2 = L17_2.value

          L18_2 = L17_2 - L16_2

          L18_2 = L18_2 / L16_2

          L18_2 = L18_2 * 100

          L12_2.change_24h = L18_2

        end

      end

    end

  end

  L7_2 = true

  L3_1 = L7_2

  if L3_2 > 0 and L2_2 > L3_2 then

    L7_2 = debugprint

    L8_2 = "waiting "

    L9_2 = math

    L9_2 = L9_2.floor

    L10_2 = L3_2 / 1000

    L9_2 = L9_2(L10_2)

    L10_2 = "s until next crypto update"

    L8_2 = L8_2 .. L9_2 .. L10_2

    L7_2(L8_2)

    L7_2 = Wait

    L8_2 = L3_2

    L7_2(L8_2)

  end

  L7_2 = {}

  L8_2 = pairs

  L9_2 = Config

  L9_2 = L9_2.Crypto

  L9_2 = L9_2.Coins

  L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)

  for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do

    L14_2 = {}

    L15_2 = 1

    L16_2 = L13_2.changes

    L16_2 = #L16_2

    L17_2 = 1

    for L18_2 = L15_2, L16_2, L17_2 do

      L19_2 = L13_2.changes

      L19_2 = L19_2[L18_2]

      L19_2 = L19_2.weight

      L14_2[L18_2] = L19_2

    end

    L7_2[L12_2] = L14_2

  end

  while true do

    L8_2 = os

    L8_2 = L8_2.nanotime

    L8_2 = L8_2()

    L9_2 = debugprint

    L10_2 = "Updating crypto coins"

    L9_2(L10_2)

    L9_2 = {}

    L10_2 = os

    L10_2 = L10_2.time

    L10_2 = L10_2()

    L11_2 = L10_2 - L1_2

    L11_2 = L4_2 <= L11_2

    if L11_2 then

      L1_2 = L10_2

      L12_2 = SetResourceKvpInt

      L13_2 = "crypto:lastTrackedPrice"

      L14_2 = L1_2

      L12_2(L13_2, L14_2)

    end

    L12_2 = pairs

    L13_2 = Config

    L13_2 = L13_2.Crypto

    L13_2 = L13_2.Coins

    L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)

    for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do

      L18_2 = L1_1

      L18_2 = L18_2[L16_2]

      L19_2 = L17_2.changes

      L20_2 = L7_1

      L21_2 = L7_2[L16_2]

      L20_2 = L20_2(L21_2)

      L19_2 = L19_2[L20_2]

      if L19_2 then

        L19_2 = L19_2.change

      end

      if not L19_2 then

        L19_2 = {}

        L20_2 = 0

        L21_2 = 0

        L19_2[1] = L20_2

        L19_2[2] = L21_2

      end

      L20_2 = L19_2[1]

      L21_2 = math

      L21_2 = L21_2.random

      L21_2 = L21_2()

      L22_2 = L19_2[2]

      L23_2 = L19_2[1]

      L22_2 = L22_2 - L23_2

      L21_2 = L21_2 * L22_2

      L20_2 = L20_2 + L21_2

      L21_2 = L18_2.current_price

      L22_2 = L18_2.current_price

      L23_2 = L20_2 / 100

      L22_2 = L22_2 * L23_2

      L21_2 = L21_2 + L22_2

      L22_2 = debugprint

      L23_2 = string

      L23_2 = L23_2.format

      L24_2 = "Coin ^4%s^7: %s%.2f%%^7 -> new price: %s%.2f^7, old price: %s%.2f^7"

      L25_2 = L16_2

      if L20_2 > 0 then

        L26_2 = "^2+"

        if L26_2 then

          goto lbl_317

        end

      end

      L26_2 = "^1"

      ::lbl_317::

      L27_2 = L20_2

      if L20_2 > 0 then

        L28_2 = "^2"

        if L28_2 then

          goto lbl_324

        end

      end

      L28_2 = "^1"

      ::lbl_324::

      L29_2 = L21_2

      if L20_2 > 0 then

        L30_2 = "^1"

        if L30_2 then

          goto lbl_331

        end

      end

      L30_2 = "^2"

      ::lbl_331::

      L31_2 = L18_2.current_price

      L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2 = L23_2(L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)

      L22_2(L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)

      L18_2.current_price = L21_2

      if L11_2 then

        L22_2 = L2_1

        L23_2 = L2_1

        L23_2 = L23_2[L16_2]

        if not L23_2 then

          L23_2 = {}

        end

        L22_2[L16_2] = L23_2

        L22_2 = L2_1

        L22_2 = L22_2[L16_2]

        while true do

          L23_2 = L18_2.prices

          L23_2 = #L23_2

          if not (L5_2 <= L23_2) then

            break

          end

          L23_2 = table

          L23_2 = L23_2.remove

          L24_2 = L18_2.prices

          L25_2 = 1

          L23_2(L24_2, L25_2)

        end

        while true do

          L23_2 = #L22_2

          if not (L5_2 <= L23_2) then

            break

          end

          L23_2 = table

          L23_2 = L23_2.remove

          L24_2 = L22_2

          L25_2 = 1

          L23_2(L24_2, L25_2)

        end

        L23_2 = L18_2.prices

        L24_2 = L18_2.prices

        L24_2 = #L24_2

        L24_2 = L24_2 + 1

        L25_2 = L18_2.current_price

        L23_2[L24_2] = L25_2

        L23_2 = #L22_2

        L23_2 = L23_2 + 1

        L24_2 = {}

        L24_2.time = L10_2

        L25_2 = L18_2.current_price

        L24_2.value = L25_2

        L22_2[L23_2] = L24_2

        L23_2 = SetResourceKvp

        L24_2 = "crypto:history:"

        L25_2 = L16_2

        L24_2 = L24_2 .. L25_2

        L25_2 = json

        L25_2 = L25_2.encode

        L26_2 = L22_2

        L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2 = L25_2(L26_2)

        L23_2(L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)

      end

      L22_2 = L18_2.prices

      L22_2 = #L22_2

      if L22_2 > 0 then

        L22_2 = L18_2.prices

        L22_2 = L22_2[1]

        L23_2 = L18_2.prices

        L24_2 = L18_2.prices

        L24_2 = #L24_2

        L23_2 = L23_2[L24_2]

        L24_2 = L23_2 - L22_2

        L24_2 = L24_2 / L22_2

        L24_2 = L24_2 * 100

        L18_2.change_24h = L24_2

      end

      L22_2 = #L9_2

      L22_2 = L22_2 + 1

      L23_2 = {}

      L24_2 = L16_2

      L25_2 = L18_2.current_price

      L23_2[1] = L24_2

      L23_2[2] = L25_2

      L9_2[L22_2] = L23_2

    end

    L12_2 = MySQL

    L12_2 = L12_2.prepare

    L12_2 = L12_2.await

    L13_2 = "INSERT INTO phone_crypto_coins (coin, coin_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE coin_value = VALUES(coin_value)"

    L14_2 = L9_2

    L12_2(L13_2, L14_2)

    L12_2 = SetResourceKvpInt

    L13_2 = "crypto:lastUpdated"

    L14_2 = os

    L14_2 = L14_2.time

    L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2 = L14_2()

    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)

    L12_2 = L6_1

    L13_2 = "phone:crypto:updateCoins"

    L14_2 = L1_1

    L12_2(L13_2, L14_2)

    L12_2 = os

    L12_2 = L12_2.nanotime

    L12_2 = L12_2()

    L12_2 = L12_2 - L8_2

    L12_2 = L12_2 / 1000000.0

    L13_2 = debugprint

    L14_2 = "Updated crypto coins in %.4fms."

    L15_2 = L14_2

    L14_2 = L14_2.format

    L16_2 = L12_2

    L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2 = L14_2(L15_2, L16_2)

    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)

    L13_2 = Wait

    L14_2 = L2_2

    L13_2(L14_2)

  end

end

L8_1(L9_1)

function L8_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L4_2 = MySQL

  L4_2 = L4_2.update

  L4_2 = L4_2.await

  L5_2 = "INSERT INTO phone_crypto (id, coin, amount, invested) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE amount = amount + VALUES(amount), invested = invested + VALUES(invested)"

  L6_2 = {}

  L7_2 = A0_2

  L8_2 = A1_2

  L9_2 = A2_2

  L10_2 = A3_2 or L10_2

  if not A3_2 then

    L10_2 = 0

  end

  L6_2[1] = L7_2

  L6_2[2] = L8_2

  L6_2[3] = L9_2

  L6_2[4] = L10_2

  L4_2(L5_2, L6_2)

end

L9_1 = GetResourceKvpString

L10_1 = "lb-phone:crypto:coins"

L9_1 = L9_1(L10_1)

if L9_1 then

  L10_1 = json

  L10_1 = L10_1.decode

  L11_1 = L9_1

  L10_1 = L10_1(L11_1)

  if L10_1 then

    goto lbl_60

  end

end

L10_1 = {}

::lbl_60::

function L11_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2

  L3_2 = L5_1

  L3_2[A1_2] = true

  L3_2 = GetResourceKvpInt

  L4_2 = "crypto:refund:"

  L5_2 = A1_2

  L4_2 = L4_2 .. L5_2

  L3_2 = L3_2(L4_2)

  if 1 == L3_2 then

    L3_2 = debugprint

    L4_2 = "refund already processed for identifier"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

    return

  end

  L3_2 = 0

  L4_2 = {}

  L5_2 = GetEquippedPhoneNumber

  L6_2 = A0_2

  L5_2 = L5_2(L6_2)

  L6_2 = 1

  L7_2 = #A2_2

  L8_2 = 1

  for L9_2 = L6_2, L7_2, L8_2 do

    L10_2 = A2_2[L9_2]

    L12_2 = L10_2.coin

    L11_2 = L1_1

    L11_2 = L11_2[L12_2]

    if not L11_2 then

      L11_2 = L10_2.amount

      if L11_2 > 0 then

        L11_2 = #L4_2

        L11_2 = L11_2 + 1

        L4_2[L11_2] = L10_2

      end

    end

  end

  L6_2 = Config

  L6_2 = L6_2.Crypto

  L6_2 = L6_2.Refund

  if "invested" == L6_2 then

    L6_2 = 1

    L7_2 = #L4_2

    L8_2 = 1

    for L9_2 = L6_2, L7_2, L8_2 do

      L10_2 = L4_2[L9_2]

      L11_2 = L10_2.invested

      L3_2 = L3_2 + L11_2

    end

  else

    L6_2 = Config

    L6_2 = L6_2.Crypto

    L6_2 = L6_2.Refund

    if "lastValue" == L6_2 then

      L6_2 = L10_1

      if not L6_2 then

        L6_2 = infoprint

        L7_2 = "warning"

        L8_2 = "Config.Crypto.Refund is set to 'lastValue', but no old coin data was found"

        L6_2(L7_2, L8_2)

      end

      L6_2 = 1

      L7_2 = #L4_2

      L8_2 = 1

      for L9_2 = L6_2, L7_2, L8_2 do

        L10_2 = L4_2[L9_2]

        L12_2 = L10_2.coin

        L11_2 = L10_1

        L11_2 = L11_2[L12_2]

        if not L11_2 then

          L12_2 = infoprint

          L13_2 = "warning"

          L14_2 = "no old coin data found for coin"

          L15_2 = L10_2.coin

          L16_2 = "- cannot refund last value. Consider changing refund method to 'invested'"

          L12_2(L13_2, L14_2, L15_2, L16_2)

          return

        end

        L12_2 = L10_2.amount

        L13_2 = L11_2.current_price

        L12_2 = L12_2 * L13_2

        L3_2 = L3_2 + L12_2

      end

    else

      L6_2 = Config

      L6_2 = L6_2.Crypto

      L6_2 = L6_2.Refund

      if "convert" == L6_2 then

        L6_2 = Config

        L6_2 = L6_2.Crypto

        L6_2 = L6_2.Coins

        L6_2 = L6_2.lbc

        if not L6_2 then

          L6_2 = infoprint

          L7_2 = "warning"

          L8_2 = "Config.Crypto.Refund is set to 'convert', but LB Coin is not configured as a crypto coin"

          L6_2(L7_2, L8_2)

          return

        end

        L6_2 = L1_1.lbc

        if not L6_2 then

          L7_2 = infoprint

          L8_2 = "warning"

          L9_2 = "LB Coin data not found - cannot convert old crypto to lbc"

          L7_2(L8_2, L9_2)

          return

        end

        L7_2 = 0

        L8_2 = 1

        L9_2 = #L4_2

        L10_2 = 1

        for L11_2 = L8_2, L9_2, L10_2 do

          L12_2 = L4_2[L11_2]

          L14_2 = L12_2.coin

          L13_2 = L10_1

          L13_2 = L13_2[L14_2]

          if not L13_2 then

            L14_2 = infoprint

            L15_2 = "warning"

            L16_2 = "no old coin data found for coin"

            L17_2 = L12_2.coin

            L18_2 = "- cannot convert to lbc. Consider changing refund method to 'invested'"

            L14_2(L15_2, L16_2, L17_2, L18_2)

            return

          end

          L14_2 = L12_2.amount

          L15_2 = L13_2.current_price

          L14_2 = L14_2 * L15_2

          L7_2 = L7_2 + L14_2

        end

        L8_2 = L6_2.current_price

        L8_2 = L7_2 / L8_2

        L9_2 = debugprint

        L10_2 = "Converting old crypto to LB Coin at rate"

        L11_2 = L6_2.current_price

        L12_2 = "-> refund amount in LBC:"

        L13_2 = L8_2

        L9_2(L10_2, L11_2, L12_2, L13_2)

        L9_2 = L8_1

        L10_2 = A1_2

        L11_2 = "lbc"

        L12_2 = L8_2

        L13_2 = L7_2

        L9_2(L10_2, L11_2, L12_2, L13_2)

        if L5_2 then

          L9_2 = SendNotification

          L10_2 = L5_2

          L11_2 = {}

          L11_2.app = "Crypto"

          L12_2 = L

          L13_2 = "APPS.CRYPTO.CONVERT_NOTIFICATION.TITLE"

          L12_2 = L12_2(L13_2)

          L11_2.title = L12_2

          L12_2 = L

          L13_2 = "APPS.CRYPTO.CONVERT_NOTIFICATION.DESCRIPTION"

          L14_2 = {}

          L15_2 = math

          L15_2 = L15_2.round

          L16_2 = L8_2

          L17_2 = 3

          L15_2 = L15_2(L16_2, L17_2)

          L14_2.amount = L15_2

          L15_2 = L6_2.name

          L14_2.coinName = L15_2

          L12_2 = L12_2(L13_2, L14_2)

          L11_2.content = L12_2

          L9_2(L10_2, L11_2)

        end

      end

    end

  end

  if L3_2 > 0 then

    L6_2 = math

    L6_2 = L6_2.floor

    L7_2 = L3_2 + 0.5

    L6_2 = L6_2(L7_2)

    L3_2 = L6_2

    L6_2 = debugprint

    L7_2 = "Refund"

    L8_2 = A0_2

    L9_2 = "with amount"

    L10_2 = L3_2

    L6_2(L7_2, L8_2, L9_2, L10_2)

    L6_2 = AddMoney

    L7_2 = A0_2

    L8_2 = L3_2

    L6_2(L7_2, L8_2)

    if L5_2 then

      L6_2 = AddTransaction

      L7_2 = L5_2

      L8_2 = L3_2

      L9_2 = L

      L10_2 = "APPS.CRYPTO.REFUND_TRANSACTION"

      L9_2 = L9_2(L10_2)

      L10_2 = "./assets/img/icons/apps/Crypto.jpg"

      L6_2(L7_2, L8_2, L9_2, L10_2)

    end

  end

  L6_2 = {}

  L7_2 = 1

  L8_2 = #L4_2

  L9_2 = 1

  for L10_2 = L7_2, L8_2, L9_2 do

    L11_2 = #L6_2

    L11_2 = L11_2 + 1

    L12_2 = L4_2[L10_2]

    L12_2 = L12_2.coin

    L6_2[L11_2] = L12_2

  end

  L7_2 = #L6_2

  if L7_2 > 0 then

    L7_2 = MySQL

    L7_2 = L7_2.update

    L7_2 = L7_2.await

    L8_2 = "DELETE FROM phone_crypto WHERE id = ? AND coin IN (?)"

    L9_2 = {}

    L10_2 = A1_2

    L11_2 = L6_2

    L9_2[1] = L10_2

    L9_2[2] = L11_2

    L7_2(L8_2, L9_2)

  end

  L7_2 = SetResourceKvpInt

  L8_2 = "crypto:refund:"

  L9_2 = A1_2

  L8_2 = L8_2 .. L9_2

  L9_2 = 1

  L7_2(L8_2, L9_2)

end

L12_1 = RegisterCallback

L13_1 = "crypto:get"

function L14_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L1_2 = GetIdentifier

  L2_2 = A0_2

  L1_2 = L1_2(L2_2)

  if not L1_2 then

    L2_2 = {}

    return L2_2

  end

  while true do

    L2_2 = L3_1

    if L2_2 then

      L2_2 = DatabaseCheckerFinished

      if L2_2 then

        break

      end

    end

    L2_2 = Wait

    L3_2 = 500

    L2_2(L3_2)

  end

  L2_2 = MySQL

  L2_2 = L2_2.query

  L2_2 = L2_2.await

  L3_2 = "SELECT coin, amount, invested FROM phone_crypto WHERE id = ?"

  L4_2 = {}

  L5_2 = L1_2

  L4_2[1] = L5_2

  L2_2 = L2_2(L3_2, L4_2)

  L3_2 = table

  L3_2 = L3_2.deep_clone

  L4_2 = L1_1

  L3_2 = L3_2(L4_2)

  L4_2 = 1

  L5_2 = #L2_2

  L6_2 = 1

  for L7_2 = L4_2, L5_2, L6_2 do

    L8_2 = L2_2[L7_2]

    if L8_2 then

      L9_2 = L8_2.coin

      L9_2 = L3_2[L9_2]

      if L9_2 then

        L9_2 = L8_2.coin

        L9_2 = L3_2[L9_2]

        L10_2 = L8_2.amount

        L9_2.owned = L10_2

        L9_2 = L8_2.coin

        L9_2 = L3_2[L9_2]

        L10_2 = L8_2.invested

        L9_2.invested = L10_2

      end

    end

  end

  L4_2 = Config

  L4_2 = L4_2.Crypto

  L4_2 = L4_2.Refund

  if L4_2 then

    L4_2 = L5_1

    L4_2 = L4_2[L1_2]

    if not L4_2 then

      L4_2 = L11_1

      L5_2 = A0_2

      L6_2 = L1_2

      L7_2 = L2_2

      L4_2(L5_2, L6_2, L7_2)

    end

  end

  return L3_2

end

L15_1 = {}

L15_1.preventSpam = true

L12_1(L13_1, L14_1, L15_1)

L12_1 = RegisterCallback

L13_1 = "crypto:buy"

function L14_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2

  L3_2 = GetIdentifier

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  L4_2 = GetBalance

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  if A2_2 <= 0 then

    L5_2 = {}

    L5_2.success = false

    L5_2.msg = "INVALID_AMOUNT"

    return L5_2

  else

    L5_2 = L0_1.Buy

    if A2_2 > L5_2 then

      L5_2 = debugprint

      L6_2 = A2_2

      L7_2 = "is above crypto buy limit"

      L5_2(L6_2, L7_2)

      L5_2 = {}

      L5_2.success = false

      L5_2.msg = "INVALID_AMOUNT"

      return L5_2

    elseif A2_2 > L4_2 then

      L5_2 = {}

      L5_2.success = false

      L5_2.msg = "NO_MONEY"

      return L5_2

    end

  end

  L5_2 = L1_1

  L5_2 = L5_2[A1_2]

  if not L5_2 then

    L6_2 = {}

    L6_2.success = false

    L6_2.msg = "INVALID_COIN"

    return L6_2

  else

    L6_2 = L5_2.permissions

    if L6_2 then

      L6_2 = L5_2.permissions

      L6_2 = L6_2.buy

      if false == L6_2 then

        L6_2 = {}

        L6_2.success = false

        L6_2.msg = "BUY_DISABLED"

        return L6_2

    end

    elseif not L3_2 then

      L6_2 = {}

      L6_2.success = false

      L6_2.msg = "NO_IDENTIFIER"

      return L6_2

    else

      L6_2 = ValidateChecks

      L7_2 = "buyCrypto"

      L8_2 = A0_2

      L9_2 = A1_2

      L10_2 = A2_2

      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)

      if not L6_2 then

        L6_2 = {}

        L6_2.success = false

        L6_2.msg = "CHECK_FAILED"

        return L6_2

      end

    end

  end

  L6_2 = L5_2.current_price

  L6_2 = A2_2 / L6_2

  L7_2 = L8_1

  L8_2 = L3_2

  L9_2 = A1_2

  L10_2 = L6_2

  L11_2 = A2_2

  L7_2(L8_2, L9_2, L10_2, L11_2)

  L7_2 = RemoveMoney

  L8_2 = A0_2

  L9_2 = A2_2

  L7_2(L8_2, L9_2)

  L7_2 = Log

  L8_2 = "Crypto"

  L9_2 = A0_2

  L10_2 = "success"

  L11_2 = L

  L12_2 = "BACKEND.LOGS.BOUGHT_CRYPTO"

  L11_2 = L11_2(L12_2)

  L12_2 = L

  L13_2 = "BACKEND.LOGS.CRYPTO_DETAILS"

  L14_2 = {}

  L14_2.coin = A1_2

  L14_2.amount = L6_2

  L14_2.price = A2_2

  L12_2, L13_2, L14_2 = L12_2(L13_2, L14_2)

  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)

  L7_2 = {}

  L7_2.success = true

  return L7_2

end

L15_1 = {}

L15_1.preventSpam = true

L12_1(L13_1, L14_1, L15_1)

L12_1 = RegisterCallback

L13_1 = "crypto:sell"

function L14_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2

  L3_2 = GetIdentifier

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  if A2_2 <= 0 then

    L4_2 = {}

    L4_2.success = false

    L4_2.msg = "INVALID_AMOUNT"

    return L4_2

  end

  L4_2 = L1_1

  L4_2 = L4_2[A1_2]

  if not L4_2 then

    L5_2 = {}

    L5_2.success = false

    L5_2.msg = "INVALID_COIN"

    return L5_2

  else

    L5_2 = L4_2.permissions

    if L5_2 then

      L5_2 = L4_2.permissions

      L5_2 = L5_2.sell

      if false == L5_2 then

        L5_2 = {}

        L5_2.success = false

        L5_2.msg = "SELL_DISABLED"

        return L5_2

      end

    end

  end

  L5_2 = MySQL

  L5_2 = L5_2.single

  L5_2 = L5_2.await

  L6_2 = "SELECT amount, invested FROM phone_crypto WHERE id = ? AND coin = ?"

  L7_2 = {}

  L8_2 = L3_2

  L9_2 = A1_2

  L7_2[1] = L8_2

  L7_2[2] = L9_2

  L5_2 = L5_2(L6_2, L7_2)

  if not L5_2 then

    L6_2 = {}

    L6_2.success = false

    L6_2.msg = "NO_COINS"

    return L6_2

  else

    L6_2 = L5_2.amount

    if A2_2 > L6_2 then

      L6_2 = {}

      L6_2.success = false

      L6_2.msg = "NOT_ENOUGH_COINS"

      return L6_2

    end

  end

  L6_2 = L4_2.current_price

  L6_2 = A2_2 * L6_2

  L7_2 = L0_1.Sell

  if L6_2 > L7_2 then

    L7_2 = debugprint

    L8_2 = L6_2

    L9_2 = "is above crypto sell limit"

    L7_2(L8_2, L9_2)

    L7_2 = {}

    L7_2.success = false

    L7_2.msg = "INVALID_AMOUNT"

    return L7_2

  else

    L7_2 = ValidateChecks

    L8_2 = "sellCrypto"

    L9_2 = A0_2

    L10_2 = A1_2

    L11_2 = A2_2

    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)

    if not L7_2 then

      L7_2 = {}

      L7_2.success = false

      L7_2.msg = "CHECK_FAILED"

      return L7_2

    end

  end

  L7_2 = MySQL

  L7_2 = L7_2.update

  L7_2 = L7_2.await

  L8_2 = "UPDATE phone_crypto SET amount = amount - ?, invested = invested - ? WHERE id = ? AND coin = ?"

  L9_2 = {}

  L10_2 = A2_2

  L11_2 = L6_2

  L12_2 = L3_2

  L13_2 = A1_2

  L9_2[1] = L10_2

  L9_2[2] = L11_2

  L9_2[3] = L12_2

  L9_2[4] = L13_2

  L7_2(L8_2, L9_2)

  L7_2 = MySQL

  L7_2 = L7_2.update

  L7_2 = L7_2.await

  L8_2 = "DELETE FROM phone_crypto WHERE id = ? AND coin = ? AND amount <= 0"

  L9_2 = {}

  L10_2 = L3_2

  L11_2 = A1_2

  L9_2[1] = L10_2

  L9_2[2] = L11_2

  L7_2(L8_2, L9_2)

  L7_2 = AddMoney

  L8_2 = A0_2

  L9_2 = L6_2

  L7_2(L8_2, L9_2)

  L7_2 = Log

  L8_2 = "Crypto"

  L9_2 = A0_2

  L10_2 = "error"

  L11_2 = L

  L12_2 = "BACKEND.LOGS.SOLD_CRYPTO"

  L11_2 = L11_2(L12_2)

  L12_2 = L

  L13_2 = "BACKEND.LOGS.CRYPTO_DETAILS"

  L14_2 = {}

  L14_2.coin = A1_2

  L14_2.amount = A2_2

  L14_2.price = L6_2

  L12_2, L13_2, L14_2 = L12_2(L13_2, L14_2)

  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)

  L7_2 = {}

  L7_2.success = true

  return L7_2

end

L15_1 = {}

L15_1.preventSpam = true

L12_1(L13_1, L14_1, L15_1)

L12_1 = BaseCallback

L13_1 = "crypto:transfer"

function L14_1(A0_2, A1_2, A2_2, A3_2, A4_2)

  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2

  L5_2 = L1_1

  L5_2 = L5_2[A2_2]

  if not L5_2 then

    L6_2 = {}

    L6_2.success = false

    L6_2.msg = "INVALID_COIN"

    return L6_2

  else

    L6_2 = L5_2.permissions

    if L6_2 then

      L6_2 = L5_2.permissions

      L6_2 = L6_2.transfer

      if false == L6_2 then

        L6_2 = {}

        L6_2.success = false

        L6_2.msg = "TRANSFER_DISABLED"

        return L6_2

    end

    else

      L6_2 = ValidateChecks

      L7_2 = "transferCrypto"

      L8_2 = A0_2

      L9_2 = A4_2

      L10_2 = A2_2

      L11_2 = A3_2

      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)

      if not L6_2 then

        L6_2 = {}

        L6_2.success = false

        L6_2.msg = "CHECK_FAILED"

        return L6_2

      end

    end

  end

  L6_2 = GetSourceFromNumber

  L7_2 = A4_2

  L6_2 = L6_2(L7_2)

  L7_2 = nil

  if L6_2 then

    L8_2 = GetIdentifier

    L9_2 = L6_2

    L8_2 = L8_2(L9_2)

    L7_2 = L8_2

  else

    L8_2 = Config

    L8_2 = L8_2.Item

    L8_2 = L8_2.Unique

    if not L8_2 then

      L8_2 = MySQL

      L8_2 = L8_2.scalar

      L8_2 = L8_2.await

      L9_2 = "SELECT id FROM phone_phones WHERE phone_number = ?"

      L10_2 = {}

      L11_2 = A4_2

      L10_2[1] = L11_2

      L8_2 = L8_2(L9_2, L10_2)

      L7_2 = L8_2

    else

      L8_2 = MySQL

      L8_2 = L8_2.scalar

      L8_2 = L8_2.await

      L9_2 = "SELECT owned_id FROM phone_phones WHERE phone_number = ?"

      L10_2 = {}

      L11_2 = A4_2

      L10_2[1] = L11_2

      L8_2 = L8_2(L9_2, L10_2)

      L7_2 = L8_2

    end

  end

  if not L7_2 then

    L8_2 = {}

    L8_2.success = false

    L8_2.msg = "INVALID_NUMBER"

    return L8_2

  end

  L8_2 = GetIdentifier

  L9_2 = A0_2

  L8_2 = L8_2(L9_2)

  if A3_2 <= 0 then

    L9_2 = {}

    L9_2.success = false

    L9_2.msg = "INVALID_AMOUNT"

    return L9_2

  end

  L9_2 = MySQL

  L9_2 = L9_2.scalar

  L9_2 = L9_2.await

  L10_2 = "SELECT amount FROM phone_crypto WHERE id = ? AND coin = ?"

  L11_2 = {}

  L12_2 = L8_2

  L13_2 = A2_2

  L11_2[1] = L12_2

  L11_2[2] = L13_2

  L9_2 = L9_2(L10_2, L11_2)

  L10_2 = L9_2 or L10_2

  if not L9_2 then

    L10_2 = 0

  end

  if A3_2 > L10_2 then

    L10_2 = {}

    L10_2.success = false

    L10_2.msg = "INVALID_AMOUNT"

    return L10_2

  end

  L10_2 = MySQL

  L10_2 = L10_2.update

  L10_2 = L10_2.await

  L11_2 = "UPDATE phone_crypto SET amount = amount - ? WHERE id = ? AND coin = ?"

  L12_2 = {}

  L13_2 = A3_2

  L14_2 = L8_2

  L15_2 = A2_2

  L12_2[1] = L13_2

  L12_2[2] = L14_2

  L12_2[3] = L15_2

  L10_2(L11_2, L12_2)

  L10_2 = L8_1

  L11_2 = L7_2

  L12_2 = A2_2

  L13_2 = A3_2

  L10_2(L11_2, L12_2, L13_2)

  L10_2 = SendNotification

  L11_2 = A4_2

  L12_2 = {}

  L12_2.app = "Crypto"

  L13_2 = L

  L14_2 = "BACKEND.CRYPTO.RECEIVED_TRANSFER_TITLE"

  L15_2 = {}

  L16_2 = L5_2.name

  L15_2.coin = L16_2

  L13_2 = L13_2(L14_2, L15_2)

  L12_2.title = L13_2

  L13_2 = L

  L14_2 = "BACKEND.CRYPTO.RECEIVED_TRANSFER_DESCRIPTION"

  L15_2 = {}

  L15_2.amount = A3_2

  L16_2 = L5_2.name

  L15_2.coin = L16_2

  L16_2 = math

  L16_2 = L16_2.floor

  L17_2 = L5_2.current_price

  L17_2 = A3_2 * L17_2

  L17_2 = L17_2 + 0.5

  L16_2 = L16_2(L17_2)

  L15_2.value = L16_2

  L13_2 = L13_2(L14_2, L15_2)

  L12_2.content = L13_2

  L10_2(L11_2, L12_2)

  L10_2 = Log

  L11_2 = "Crypto"

  L12_2 = A0_2

  L13_2 = "error"

  L14_2 = L

  L15_2 = "BACKEND.LOGS.TRANSFERRED_CRYPTO"

  L14_2 = L14_2(L15_2)

  L15_2 = L

  L16_2 = "BACKEND.LOGS.TRANSFERRED_CRYPTO_DETAILS"

  L17_2 = {}

  L17_2.coin = A2_2

  L17_2.amount = A3_2

  L17_2.to = A4_2

  L17_2.from = A1_2

  L15_2, L16_2, L17_2 = L15_2(L16_2, L17_2)

  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)

  if L6_2 then

    L10_2 = TriggerClientEvent

    L11_2 = "phone:crypto:changeOwnedAmount"

    L12_2 = L6_2

    L13_2 = A2_2

    L14_2 = A3_2

    L10_2(L11_2, L12_2, L13_2, L14_2)

  end

  L10_2 = {}

  L10_2.success = true

  return L10_2

end

L15_1 = {}

L15_1.preventSpam = true

L12_1(L13_1, L14_1, L15_1)

L12_1 = RegisterNetEvent

L13_1 = "phone:crypto:fetchCoins"

function L14_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2

  L0_2 = source

  L1_2 = TriggerLatentClientEvent

  L2_2 = "phone:crypto:updateCoins"

  L3_2 = L0_2

  L4_2 = 1000000.0

  L5_2 = L1_1

  L1_2(L2_2, L3_2, L4_2, L5_2)

end

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "AddCrypto"

function L14_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L3_2 = GetIdentifier

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  L4_2 = L1_1

  L4_2 = L4_2[A1_2]

  if not L4_2 then

    L4_2 = print

    L5_2 = "AddCrypto: invalid coin"

    L6_2 = A1_2

    L4_2(L5_2, L6_2)

    L4_2 = false

    return L4_2

  elseif not L3_2 then

    L4_2 = print

    L5_2 = "AddCrypto: no identifier found for source"

    L6_2 = A0_2

    L4_2(L5_2, L6_2)

    L4_2 = false

    return L4_2

  end

  L4_2 = L8_1

  L5_2 = L3_2

  L6_2 = A1_2

  L7_2 = A2_2

  L4_2(L5_2, L6_2, L7_2)

  L4_2 = TriggerClientEvent

  L5_2 = "phone:crypto:changeOwnedAmount"

  L6_2 = A0_2

  L7_2 = A1_2

  L8_2 = A2_2

  L4_2(L5_2, L6_2, L7_2, L8_2)

  L4_2 = true

  return L4_2

end

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "RemoveCrypto"

function L14_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L3_2 = GetIdentifier

  L4_2 = A0_2

  L3_2 = L3_2(L4_2)

  L4_2 = L1_1

  L4_2 = L4_2[A1_2]

  if not L4_2 then

    L4_2 = print

    L5_2 = "RemoveCrypto: invalid coin"

    L6_2 = A1_2

    L4_2(L5_2, L6_2)

    L4_2 = false

    return L4_2

  elseif not L3_2 then

    L4_2 = print

    L5_2 = "RemoveCrypto: no identifier found for source"

    L6_2 = A0_2

    L4_2(L5_2, L6_2)

    L4_2 = false

    return L4_2

  end

  L4_2 = MySQL

  L4_2 = L4_2.Async

  L4_2 = L4_2.execute

  L5_2 = "UPDATE phone_crypto SET amount = amount - ? WHERE id = ? AND coin = ?"

  L6_2 = {}

  L7_2 = A2_2

  L8_2 = L3_2

  L9_2 = A1_2

  L6_2[1] = L7_2

  L6_2[2] = L8_2

  L6_2[3] = L9_2

  L4_2(L5_2, L6_2)

  L4_2 = TriggerClientEvent

  L5_2 = "phone:crypto:changeOwnedAmount"

  L6_2 = A0_2

  L7_2 = A1_2

  L8_2 = -A2_2

  L4_2(L5_2, L6_2, L7_2, L8_2)

  L4_2 = true

  return L4_2

end

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "AddCustomCoin"

function L14_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2)

  local L8_2, L9_2, L10_2, L11_2, L12_2

  L8_2 = assert

  L9_2 = type

  L10_2 = A0_2

  L9_2 = L9_2(L10_2)

  L9_2 = "string" == L9_2

  L10_2 = "id must be a string"

  L8_2(L9_2, L10_2)

  L8_2 = assert

  L9_2 = type

  L10_2 = A1_2

  L9_2 = L9_2(L10_2)

  L9_2 = "string" == L9_2

  L10_2 = "name must be a string"

  L8_2(L9_2, L10_2)

  L8_2 = assert

  L9_2 = type

  L10_2 = A2_2

  L9_2 = L9_2(L10_2)

  L9_2 = "string" == L9_2

  L10_2 = "symbol must be a string"

  L8_2(L9_2, L10_2)

  L8_2 = assert

  L9_2 = type

  L10_2 = A3_2

  L9_2 = L9_2(L10_2)

  L9_2 = "string" == L9_2

  L10_2 = "image must be a string"

  L8_2(L9_2, L10_2)

  L8_2 = assert

  L9_2 = type

  L10_2 = A4_2

  L9_2 = L9_2(L10_2)

  L9_2 = "number" == L9_2

  L10_2 = "currentPrice must be a number"

  L8_2(L9_2, L10_2)

  L8_2 = assert

  L9_2 = type

  L10_2 = A5_2

  L9_2 = L9_2(L10_2)

  L9_2 = "table" == L9_2

  L10_2 = "prices must be a table"

  L8_2(L9_2, L10_2)

  L8_2 = assert

  L9_2 = type

  L10_2 = A6_2

  L9_2 = L9_2(L10_2)

  L9_2 = "number" == L9_2

  L10_2 = "change24h must be a number"

  L8_2(L9_2, L10_2)

  L8_2 = assert

  L9_2 = nil == A7_2

  L10_2 = "permissions must be a table or nil"

  L8_2(L9_2, L10_2)

  if A7_2 then

    L8_2 = assert

    L9_2 = A7_2.buy

    L9_2 = nil == L9_2

    L10_2 = "permissions.buy must be a boolean or nil"

    L8_2(L9_2, L10_2)

    L8_2 = assert

    L9_2 = A7_2.sell

    L9_2 = nil == L9_2

    L10_2 = "permissions.sell must be a boolean or nil"

    L8_2(L9_2, L10_2)

    L8_2 = assert

    L9_2 = A7_2.transfer

    L9_2 = nil == L9_2

    L10_2 = "permissions.transfer must be a boolean or nil"

    L8_2(L9_2, L10_2)

  end

  L8_2 = L1_1

  L9_2 = {}

  L9_2.id = A0_2

  L9_2.name = A1_2

  L9_2.symbol = A2_2

  L9_2.image = A3_2

  L9_2.current_price = A4_2

  L9_2.prices = A5_2

  L9_2.change_24h = A6_2

  L9_2.permissions = A7_2

  L8_2[A0_2] = L9_2

  L8_2 = TriggerLatentClientEvent

  L9_2 = "phone:crypto:updateCoins"

  L10_2 = -1

  L11_2 = 1000000.0

  L12_2 = L1_1

  L8_2(L9_2, L10_2, L11_2, L12_2)

end

L12_1(L13_1, L14_1)

L12_1 = exports

L13_1 = "GetCoin"

function L14_1(A0_2)

  local L1_2

  L1_2 = L1_1

  L1_2 = L1_2[A0_2]

  return L1_2

end

L12_1(L13_1, L14_1)

L12_1 = AddEventHandler

L13_1 = "playerDropped"

function L14_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2

  L0_2 = source

  L1_2 = table

  L1_2 = L1_2.contains

  L2_2 = L4_1

  L3_2 = L0_2

  L1_2, L2_2 = L1_2(L2_2, L3_2)

  if L2_2 then

    L3_2 = table

    L3_2 = L3_2.remove

    L4_2 = L4_1

    L5_2 = L2_2

    L3_2(L4_2, L5_2)

  end

end

L12_1(L13_1, L14_1)
