local L0_1, L1_1, L2_1

L0_1 = RegisterNUICallback

L1_1 = "WebRTC"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L2_2 = A0_2.action

  if "createdPeer" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:webrtc:createdPeer"

    L5_2 = A0_2.peerId

    L3_2(L4_2, L5_2)

  elseif "deletedPeer" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:webrtc:deletedPeer"

    L5_2 = A0_2.peerId

    L3_2(L4_2, L5_2)

  elseif "signal" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:webrtc:signal"

    L5_2 = A0_2.from

    L6_2 = A0_2.target

    L7_2 = A0_2.signalData

    L3_2(L4_2, L5_2, L6_2, L7_2)

  else

    L3_2 = debugprint

    L4_2 = "Unknown WebRTC action:"

    L5_2 = L2_2

    L3_2(L4_2, L5_2)

  end

  L3_2 = A1_2

  L4_2 = "ok"

  L3_2(L4_2)

end

L0_1(L1_1, L2_1)

L0_1 = RegisterNetEvent

L1_1 = "phone:webrtc:signal"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "webrtc:signal"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L0_1(L1_1, L2_1)

L0_1 = RegisterNetEvent

L1_1 = "phone:webrtc:endCall"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "webrtc:endCall"

  L3_2 = {}

  L3_2.from = A0_2

  L1_2(L2_2, L3_2)

end

L0_1(L1_1, L2_1)
