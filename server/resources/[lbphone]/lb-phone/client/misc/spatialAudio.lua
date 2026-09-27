local L0_1, L1_1

function L0_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2

  L2_2 = math

  L2_2 = L2_2.rad

  L3_2 = A1_2.x

  L2_2 = L2_2(L3_2)

  L3_2 = math

  L3_2 = L3_2.rad

  L4_2 = A1_2.y

  L3_2 = L3_2(L4_2)

  L4_2 = math

  L4_2 = L4_2.rad

  L5_2 = A1_2.z

  L4_2 = L4_2(L5_2)

  L5_2 = math

  L5_2 = L5_2.cos

  L6_2 = L2_2

  L5_2 = L5_2(L6_2)

  L6_2 = math

  L6_2 = L6_2.sin

  L7_2 = L2_2

  L6_2 = L6_2(L7_2)

  L7_2 = math

  L7_2 = L7_2.cos

  L8_2 = L3_2

  L7_2 = L7_2(L8_2)

  L8_2 = math

  L8_2 = L8_2.sin

  L9_2 = L3_2

  L8_2 = L8_2(L9_2)

  L9_2 = math

  L9_2 = L9_2.cos

  L10_2 = L4_2

  L9_2 = L9_2(L10_2)

  L10_2 = math

  L10_2 = L10_2.sin

  L11_2 = L4_2

  L10_2 = L10_2(L11_2)

  L11_2 = A0_2.x

  L11_2 = L11_2 * L9_2

  L12_2 = A0_2.y

  L12_2 = L12_2 * L10_2

  L11_2 = L11_2 - L12_2

  L12_2 = A0_2.x

  L12_2 = L12_2 * L10_2

  L13_2 = A0_2.y

  L13_2 = L13_2 * L9_2

  L12_2 = L12_2 + L13_2

  L13_2 = A0_2.z

  L14_2 = L11_2

  L15_2 = L12_2 * L5_2

  L16_2 = L13_2 * L6_2

  L15_2 = L15_2 - L16_2

  L16_2 = L12_2 * L6_2

  L17_2 = L13_2 * L5_2

  L16_2 = L16_2 + L17_2

  L17_2 = L14_2 * L7_2

  L18_2 = L16_2 * L8_2

  L17_2 = L17_2 + L18_2

  L18_2 = L15_2

  L19_2 = -L14_2

  L19_2 = L19_2 * L8_2

  L20_2 = L16_2 * L7_2

  L19_2 = L19_2 + L20_2

  L20_2 = vector3

  L21_2 = L17_2

  L22_2 = L18_2

  L23_2 = L19_2

  return L20_2(L21_2, L22_2, L23_2)

end

function L1_1(A0_2, A1_2, A2_2, A3_2, A4_2)

  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2

  L5_2 = math

  L5_2 = L5_2.clamp

  L6_2 = A4_2 or L6_2

  if not A4_2 then

    L6_2 = 1.0

  end

  L7_2 = 0.0

  L8_2 = 1.0

  L5_2 = L5_2(L6_2, L7_2, L8_2)

  A4_2 = L5_2

  L5_2 = A2_2 - A0_2

  L6_2 = #L5_2

  if A3_2 <= L6_2 then

    L7_2 = {}

    L7_2.frontLeft = 0.0

    L7_2.frontRight = 0.0

    L7_2.rearLeft = 0.0

    L7_2.rearRight = 0.0

    return L7_2

  end

  L7_2 = vector3

  L8_2 = A1_2.x

  L8_2 = -L8_2

  L9_2 = A1_2.y

  L9_2 = -L9_2

  L10_2 = A1_2.z

  L10_2 = -L10_2

  L7_2 = L7_2(L8_2, L9_2, L10_2)

  L8_2 = L0_1

  L9_2 = L5_2

  L10_2 = L7_2

  L8_2 = L8_2(L9_2, L10_2)

  L9_2 = norm

  L10_2 = vector2

  L11_2 = L8_2.x

  L12_2 = L8_2.y

  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L10_2(L11_2, L12_2)

  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)

  L10_2 = L9_2.x

  L10_2 = L10_2 + 1.0

  L10_2 = L10_2 * 0.5

  L11_2 = L9_2.y

  L11_2 = L11_2 + 1.0

  L11_2 = L11_2 * 0.5

  L12_2 = L10_2

  L13_2 = 1.0

  L13_2 = L13_2 - L10_2

  L14_2 = L11_2

  L15_2 = 1.0

  L15_2 = L15_2 - L11_2

  L16_2 = {}

  L17_2 = L14_2 * L13_2

  L16_2.frontLeft = L17_2

  L17_2 = L14_2 * L12_2

  L16_2.frontRight = L17_2

  L17_2 = L15_2 * L13_2

  L16_2.rearLeft = L17_2

  L17_2 = L15_2 * L12_2

  L16_2.rearRight = L17_2

  L17_2 = L16_2.frontLeft

  L17_2 = L17_2 ^ 2

  L18_2 = L16_2.frontRight

  L18_2 = L18_2 ^ 2

  L17_2 = L17_2 + L18_2

  L18_2 = L16_2.rearLeft

  L18_2 = L18_2 ^ 2

  L17_2 = L17_2 + L18_2

  L18_2 = L16_2.rearRight

  L18_2 = L18_2 ^ 2

  L17_2 = L17_2 + L18_2

  if L17_2 > 0 then

    L18_2 = math

    L18_2 = L18_2.sqrt

    L19_2 = L17_2

    L18_2 = L18_2(L19_2)

    L19_2 = 1.0

    L18_2 = L19_2 / L18_2

    L19_2 = L16_2.frontLeft

    L19_2 = L19_2 * L18_2

    L16_2.frontLeft = L19_2

    L19_2 = L16_2.frontRight

    L19_2 = L19_2 * L18_2

    L16_2.frontRight = L19_2

    L19_2 = L16_2.rearLeft

    L19_2 = L19_2 * L18_2

    L16_2.rearLeft = L19_2

    L19_2 = L16_2.rearRight

    L19_2 = L19_2 * L18_2

    L16_2.rearRight = L19_2

  end

  L18_2 = L6_2 / A3_2

  L19_2 = math

  L19_2 = L19_2.clamp

  L20_2 = 1.0

  L20_2 = L20_2 - L18_2

  L20_2 = L20_2 ^ 2

  L21_2 = 0.0

  L22_2 = 1.0

  L19_2 = L19_2(L20_2, L21_2, L22_2)

  L19_2 = L19_2 * A4_2

  L20_2 = {}

  L21_2 = L16_2.frontLeft

  L21_2 = L21_2 * L19_2

  L20_2.frontLeft = L21_2

  L21_2 = L16_2.frontRight

  L21_2 = L21_2 * L19_2

  L20_2.frontRight = L21_2

  L21_2 = L16_2.rearLeft

  L21_2 = L21_2 * L19_2

  L20_2.rearLeft = L21_2

  L21_2 = L16_2.rearRight

  L21_2 = L21_2 * L19_2

  L20_2.rearRight = L21_2

  return L20_2

end

CalculateSpatialAudio = L1_1
