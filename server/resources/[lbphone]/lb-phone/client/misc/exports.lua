local L0_1, L1_1, L2_1, L3_1

L0_1 = exports

L1_1 = "ToggleHomeIndicator"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "toggleShowHomeIndicator"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L0_1(L1_1, L2_1)

L0_1 = exports

L1_1 = "ToggleLandscape"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "toggleLandscape"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L0_1(L1_1, L2_1)

L0_1 = exports

L1_1 = "OpenApp"

function L2_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "setApp"

  L4_2 = {}

  L4_2.name = A0_2

  L4_2.metadata = A1_2

  L2_2(L3_2, L4_2)

end

L0_1(L1_1, L2_1)

L0_1 = exports

L1_1 = "CloseApp"

function L2_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  if not A0_2 then

    L1_2 = {}

    A0_2 = L1_2

  end

  L1_2 = debugprint

  L2_2 = "CloseApp: "

  L3_2 = A0_2.app

  if not L3_2 then

    L3_2 = "nil"

  end

  L4_2 = ", closeCompletely: "

  L5_2 = tostring

  L6_2 = A0_2.closeCompletely

  L5_2 = L5_2(L6_2)

  L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2

  L1_2(L2_2)

  L1_2 = SendReactMessage

  L2_2 = "closeApp"

  L3_2 = {}

  L4_2 = A0_2.app

  if not L4_2 then

    L4_2 = nil

  end

  L3_2.app = L4_2

  L4_2 = A0_2.closeCompletely

  L4_2 = true == L4_2

  L3_2.closeCompletely = L4_2

  L1_2(L2_2, L3_2)

end

L0_1(L1_1, L2_1)

L0_1 = {}

function L1_1()

  local L0_2, L1_2

  L0_2 = L0_1

  return L0_2

end

GetHiddenApps = L1_1

L1_1 = exports

L2_1 = "SetAppHidden"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = L0_1

  L3_2 = true == A1_2

  L2_2[A0_2] = L3_2

  L2_2 = SendReactMessage

  L3_2 = "app:setHidden"

  L4_2 = {}

  L4_2.app = A0_2

  L5_2 = true == A1_2

  L4_2.hidden = L5_2

  L2_2(L3_2, L4_2)

end

L1_1(L2_1, L3_1)

L1_1 = exports

L2_1 = "SetAppInstalled"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = SendReactMessage

  L3_2 = "app:setInstalled"

  L4_2 = {}

  L4_2.app = A0_2

  L5_2 = true == A1_2

  L4_2.installed = L5_2

  L2_2(L3_2, L4_2)

end

L1_1(L2_1, L3_1)
