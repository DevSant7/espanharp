local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1

L0_1 = {}

L1_1 = {}

L2_1 = {}

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = L2_1

  L2_2 = L2_2[A0_2]

  if L2_2 then

    L3_2 = L2_2[A1_2]

    if L3_2 then

      goto lbl_9

    end

  end

  do return end

  ::lbl_9::

  L3_2 = L0_1

  L3_2 = L3_2[A1_2]

  if L3_2 then

    L4_2 = TriggerClientEvent

    L5_2 = "phone:webrtc:endCall"

    L6_2 = L3_2

    L7_2 = A0_2

    L4_2(L5_2, L6_2, L7_2)

  end

  L4_2 = L2_1

  L4_2 = L4_2[A0_2]

  L4_2[A1_2] = nil

  L4_2 = L2_1

  L4_2 = L4_2[A1_2]

  L4_2[A0_2] = nil

end

function L4_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L1_2 = L0_1

  L1_2 = L1_2[A0_2]

  if not L1_2 then

    return

  end

  L2_2 = L2_1

  L2_2 = L2_2[A0_2]

  if L2_2 then

    L3_2 = pairs

    L4_2 = L2_2

    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)

    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do

      L9_2 = L3_1

      L10_2 = A0_2

      L11_2 = L7_2

      L9_2(L10_2, L11_2)

    end

    L3_2 = L2_1

    L3_2[A0_2] = nil

  end

  L3_2 = L1_1

  L3_2 = L3_2[L1_2]

  if L3_2 then

    L4_2 = 1

    L5_2 = #L3_2

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = L3_2[L7_2]

      if L8_2 == A0_2 then

        L8_2 = table

        L8_2 = L8_2.remove

        L9_2 = L3_2

        L10_2 = L7_2

        L8_2(L9_2, L10_2)

        break

      end

    end

    L4_2 = #L3_2

    if 0 == L4_2 then

      L4_2 = L1_1

      L4_2[L1_2] = nil

    end

  end

  L4_2 = L0_1

  L4_2[A0_2] = nil

end

L5_1 = RegisterNetEvent

L6_1 = "phone:webrtc:createdPeer"

function L7_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = source

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  if L2_2 then

    return

  end

  L2_2 = L0_1

  L2_2[A0_2] = L1_2

  L2_2 = L1_1

  L2_2 = L2_2[L1_2]

  if not L2_2 then

    L2_2 = L1_1

    L3_2 = {}

    L2_2[L1_2] = L3_2

  end

  L2_2 = table

  L2_2 = L2_2.insert

  L3_2 = L1_1

  L3_2 = L3_2[L1_2]

  L4_2 = A0_2

  L2_2(L3_2, L4_2)

end

L5_1(L6_1, L7_1)

L5_1 = RegisterNetEvent

L6_1 = "phone:webrtc:deletedPeer"

function L7_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = source

  L2_2 = L0_1

  L2_2 = L2_2[A0_2]

  if L2_2 ~= L1_2 then

    return

  end

  L2_2 = L4_1

  L3_2 = A0_2

  L2_2(L3_2)

end

L5_1(L6_1, L7_1)

L5_1 = RegisterNetEvent

L6_1 = "phone:webrtc:signal"

function L7_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L3_2 = source

  L4_2 = L0_1

  L4_2 = L4_2[A0_2]

  if L4_2 then

    L4_2 = L0_1

    L4_2 = L4_2[A0_2]

    if L4_2 == L3_2 then

      goto lbl_11

    end

  end

  do return end

  ::lbl_11::

  L4_2 = L0_1

  L4_2 = L4_2[A1_2]

  if L4_2 then

    L5_2 = L0_1

    L5_2 = L5_2[A0_2]

    if L5_2 == L3_2 then

      goto lbl_20

    end

  end

  do return end

  ::lbl_20::

  L5_2 = A2_2.type

  if "offer" == L5_2 then

    L5_2 = L2_1

    L5_2 = L5_2[A0_2]

    if not L5_2 then

      L5_2 = L2_1

      L6_2 = {}

      L5_2[A0_2] = L6_2

    end

    L5_2 = L2_1

    L5_2 = L5_2[A1_2]

    if not L5_2 then

      L5_2 = L2_1

      L6_2 = {}

      L5_2[A1_2] = L6_2

    end

    L5_2 = L2_1

    L5_2 = L5_2[A0_2]

    L5_2[A1_2] = true

    L5_2 = L2_1

    L5_2 = L5_2[A1_2]

    L5_2[A0_2] = true

  end

  L5_2 = TriggerClientEvent

  L6_2 = "phone:webrtc:signal"

  L7_2 = L4_2

  L8_2 = {}

  L8_2.signalData = A2_2

  L8_2.from = A0_2

  L8_2.target = A1_2

  L5_2(L6_2, L7_2, L8_2)

end

L5_1(L6_1, L7_1)

L5_1 = AddEventHandler

L6_1 = "playerDropped"

function L7_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L0_2 = source

  L1_2 = L1_1

  L1_2 = L1_2[L0_2]

  if not L1_2 then

    return

  end

  L1_2 = table

  L1_2 = L1_2.clone

  L2_2 = L1_1

  L2_2 = L2_2[L0_2]

  L1_2 = L1_2(L2_2)

  L2_2 = 1

  L3_2 = #L1_2

  L4_2 = 1

  for L5_2 = L2_2, L3_2, L4_2 do

    L6_2 = L4_1

    L7_2 = L1_2[L5_2]

    L6_2(L7_2)

  end

  L2_2 = L1_1

  L2_2[L0_2] = nil

end

L5_1(L6_1, L7_1)
