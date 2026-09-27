local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1

L0_1 = Config

L0_1 = L0_1.Camera

if L0_1 then

  L0_1 = L0_1.MaxFOV

end

if not L0_1 then

  L0_1 = 70.0

end

L1_1 = Config

L1_1 = L1_1.Camera

if L1_1 then

  L1_1 = L1_1.DefaultFOV

end

if not L1_1 then

  L1_1 = 60.0

end

L2_1 = Config

L2_1 = L2_1.Camera

if L2_1 then

  L2_1 = L2_1.MinFOV

end

if not L2_1 then

  L2_1 = 10.0

end

L3_1 = Config

L3_1 = L3_1.Camera

if L3_1 then

  L3_1 = L3_1.MaxLookUp

end

if not L3_1 then

  L3_1 = 80.0

end

L4_1 = Config

L4_1 = L4_1.Camera

if L4_1 then

  L4_1 = L4_1.MaxLookDown

end

if not L4_1 then

  L4_1 = -80.0

end

L5_1 = Config

L5_1 = L5_1.Camera

if L5_1 then

  L5_1 = L5_1.AllowRunning

end

L5_1 = true == L5_1

L6_1 = Config

L6_1 = L6_1.Camera

if L6_1 then

  L6_1 = L6_1.Vehicle

  if L6_1 then

    L6_1 = L6_1.Zoom

  end

end

L6_1 = true == L6_1

L7_1 = Config

L7_1 = L7_1.Camera

if L7_1 then

  L7_1 = L7_1.Vehicle

  if L7_1 then

    L7_1 = L7_1.MaxFOV

  end

end

if not L7_1 then

  L7_1 = 80.0

end

L8_1 = Config

L8_1 = L8_1.Camera

if L8_1 then

  L8_1 = L8_1.Vehicle

  if L8_1 then

    L8_1 = L8_1.DefaultFOV

  end

end

if not L8_1 then

  L8_1 = 60.0

end

L9_1 = Config

L9_1 = L9_1.Camera

if L9_1 then

  L9_1 = L9_1.Vehicle

  if L9_1 then

    L9_1 = L9_1.MinFOV

  end

end

if not L9_1 then

  L9_1 = 10.0

end

L10_1 = Config

L10_1 = L10_1.Camera

if L10_1 then

  L10_1 = L10_1.Vehicle

  if L10_1 then

    L10_1 = L10_1.MaxLookUp

  end

end

if not L10_1 then

  L10_1 = 50.0

end

L11_1 = Config

L11_1 = L11_1.Camera

if L11_1 then

  L11_1 = L11_1.Vehicle

  if L11_1 then

    L11_1 = L11_1.MaxLookDown

  end

end

if not L11_1 then

  L11_1 = -30.0

end

L12_1 = Config

L12_1 = L12_1.Camera

if L12_1 then

  L12_1 = L12_1.Vehicle

  if L12_1 then

    L12_1 = L12_1.MaxLeftRight

  end

end

if not L12_1 then

  L12_1 = 120.0

end

L13_1 = Config

L13_1 = L13_1.Camera

if L13_1 then

  L13_1 = L13_1.Vehicle

  if L13_1 then

    L13_1 = L13_1.MinLeftRight

  end

end

if not L13_1 then

  L13_1 = -120.0

end

L14_1 = Config

L14_1 = L14_1.Camera

if L14_1 then

  L14_1 = L14_1.Selfie

  if L14_1 then

    L14_1 = L14_1.MaxFOV

  end

end

if not L14_1 then

  L14_1 = 80.0

end

L15_1 = Config

L15_1 = L15_1.Camera

if L15_1 then

  L15_1 = L15_1.Selfie

  if L15_1 then

    L15_1 = L15_1.DefaultFOV

  end

end

if not L15_1 then

  L15_1 = 60.0

end

L16_1 = Config

L16_1 = L16_1.Camera

if L16_1 then

  L16_1 = L16_1.Selfie

  if L16_1 then

    L16_1 = L16_1.MinFOV

  end

end

if not L16_1 then

  L16_1 = 50.0

end

L17_1 = Config

L17_1 = L17_1.Camera

if L17_1 then

  L17_1 = L17_1.Freeze

  if L17_1 then

    L17_1 = L17_1.Enabled

  end

end

L17_1 = true == L17_1

L18_1 = Config

L18_1 = L18_1.Camera

if L18_1 then

  L18_1 = L18_1.Freeze

  if L18_1 then

    L18_1 = L18_1.MaxDistance

  end

end

if not L18_1 then

  L18_1 = 10.0

end

L19_1 = Config

L19_1 = L19_1.Camera

if L19_1 then

  L19_1 = L19_1.Freeze

  if L19_1 then

    L19_1 = L19_1.MaxTime

  end

end

if not L19_1 then

  L19_1 = 60

end

L19_1 = L19_1 * 1000

L20_1 = Config

L20_1 = L20_1.Camera

if L20_1 then

  L20_1 = L20_1.Selfie

  if L20_1 then

    L20_1 = L20_1.Offset

  end

end

if not L20_1 then

  L20_1 = vector3

  L21_1 = 0.1

  L22_1 = 0.55

  L23_1 = 0.6

  L20_1 = L20_1(L21_1, L22_1, L23_1)

end

L21_1 = Config

L21_1 = L21_1.Camera

if L21_1 then

  L21_1 = L21_1.Selfie

  if L21_1 then

    L21_1 = L21_1.Rotation

  end

end

if not L21_1 then

  L21_1 = vector3

  L22_1 = 10.0

  L23_1 = 0.0

  L24_1 = -180.0

  L21_1 = L21_1(L22_1, L23_1, L24_1)

end

L22_1 = Config

L22_1 = L22_1.Camera

L22_1 = L22_1.Roll

L22_1 = true == L22_1

L23_1 = vector3

L24_1 = 0.0

L25_1 = 0.5

L26_1 = 0.6

L23_1 = L23_1(L24_1, L25_1, L26_1)

L24_1 = 0.0

L25_1 = 0.0

L26_1 = 60.0

L27_1 = 0

L28_1 = 0.0

L29_1 = false

L30_1 = false

L31_1 = 0

L32_1 = PlayerPedId

L32_1 = L32_1()

L33_1 = false

L34_1 = false

L35_1 = 0.0

L36_1 = GetProfileSetting

L37_1 = 754

L36_1 = L36_1(L37_1)

L36_1 = L36_1 + 10

L37_1 = 1.0

L38_1 = nil

L39_1 = {}

L39_1.REAR = 0

L39_1.SELFIE = 1

L39_1.IN_VEHICLE = 2

L40_1 = L39_1.REAR

function L41_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L0_2 = IsPedInAnyVehicle

  L1_2 = L32_1

  L2_2 = true

  L0_2 = L0_2(L1_2, L2_2)

  L1_2 = L33_1

  if L1_2 then

    L1_2 = L14_1

    if L1_2 then

      goto lbl_17

    end

  end

  if L0_2 then

    L1_2 = L7_1

    if L1_2 then

      goto lbl_17

    end

  end

  L1_2 = L0_1

  ::lbl_17::

  L2_2 = L33_1

  if L2_2 then

    L2_2 = L16_1

    if L2_2 then

      goto lbl_35

    end

  end

  if L0_2 then

    L2_2 = L6_1

    if L2_2 then

      L2_2 = L9_1

      if L2_2 then

        goto lbl_35

      end

    end

    L2_2 = L7_1

    if L2_2 then

      goto lbl_35

    end

  end

  L2_2 = L2_1

  ::lbl_35::

  L3_2 = L33_1

  if L3_2 then

    L3_2 = L15_1

    if L3_2 then

      goto lbl_47

    end

  end

  if L0_2 then

    L3_2 = L8_1

    if L3_2 then

      goto lbl_47

    end

  end

  L3_2 = L1_1

  ::lbl_47::

  L4_2 = L1_2

  L5_2 = L2_2

  L6_2 = L3_2

  return L4_2, L5_2, L6_2

end

function L42_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L1_2 = L41_1

  L1_2, L2_2, L3_2 = L1_2()

  L4_2 = math

  L4_2 = L4_2.clamp

  L5_2 = A0_2

  L6_2 = L2_2

  L7_2 = L1_2

  L4_2 = L4_2(L5_2, L6_2, L7_2)

  if L4_2 == L3_2 then

    L5_2 = 1.0

    return L5_2

  elseif L3_2 > L4_2 then

    if L4_2 <= 0 then

      L5_2 = 1.0

      return L5_2

    end

    L5_2 = L3_2 / L4_2

    return L5_2

  else

    L5_2 = L4_2 - L3_2

    L6_2 = L1_2 - L3_2

    L5_2 = L5_2 / L6_2

    L6_2 = L5_2 * 0.5

    L7_2 = 1.0

    L6_2 = L7_2 - L6_2

    return L6_2

  end

end

ConvertFovToZoom = L42_1

function L42_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L1_2 = L41_1

  L1_2, L2_2, L3_2 = L1_2()

  L4_2 = 1.0

  if L3_2 < L1_2 then

    L4_2 = 0.5

  end

  L5_2 = 1.0

  if L2_2 < L3_2 and L2_2 > 0 then

    L5_2 = L3_2 / L2_2

  end

  L6_2 = math

  L6_2 = L6_2.clamp

  L7_2 = A0_2

  L8_2 = L4_2

  L9_2 = L5_2

  L6_2 = L6_2(L7_2, L8_2, L9_2)

  if 1.0 == L6_2 then

    return L3_2

  elseif L6_2 > 1.0 then

    L7_2 = L3_2 / L6_2

    return L7_2

  else

    L7_2 = 1.0

    L7_2 = L7_2 - L6_2

    L7_2 = 2.0 * L7_2

    L8_2 = L1_2 - L3_2

    L8_2 = L7_2 * L8_2

    L8_2 = L3_2 + L8_2

    return L8_2

  end

end

function L43_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L0_2 = L41_1

  L0_2, L1_2, L2_2 = L0_2()

  L3_2 = ConvertFovToZoom

  L4_2 = L0_2

  L3_2 = L3_2(L4_2)

  L4_2 = ConvertFovToZoom

  L5_2 = L1_2

  L4_2 = L4_2(L5_2)

  L5_2 = {}

  L6_2 = 1.0

  L5_2[1] = L6_2

  if L3_2 < 1.0 then

    L6_2 = table

    L6_2 = L6_2.insert

    L7_2 = L5_2

    L8_2 = 1

    L9_2 = L3_2

    L6_2(L7_2, L8_2, L9_2)

  end

  if L4_2 > 2.0 then

    L6_2 = table

    L6_2 = L6_2.insert

    L7_2 = L5_2

    L8_2 = 2

    L6_2(L7_2, L8_2)

  end

  if L4_2 > 5.0 then

    L6_2 = table

    L6_2 = L6_2.insert

    L7_2 = L5_2

    L8_2 = 5

    L6_2(L7_2, L8_2)

  elseif L4_2 > 3.0 then

    L6_2 = table

    L6_2 = L6_2.insert

    L7_2 = L5_2

    L8_2 = 3

    L6_2(L7_2, L8_2)

  end

  L6_2 = SendReactMessage

  L7_2 = "camera:setZoomLevels"

  L8_2 = L5_2

  L6_2(L7_2, L8_2)

end

function L44_1(A0_2)

  local L1_2, L2_2

  L1_2 = L42_1

  L2_2 = A0_2

  L1_2 = L1_2(L2_2)

  L26_1 = L1_2

end

SetCameraZoom = L44_1

function L44_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2

  L0_2 = IsPedInAnyVehicle

  L1_2 = L32_1

  L2_2 = true

  L0_2 = L0_2(L1_2, L2_2)

  L1_2 = L33_1

  if L1_2 then

    L1_2 = L39_1.SELFIE

    if L1_2 then

      goto lbl_12

    end

  end

  L1_2 = L39_1.REAR

  ::lbl_12::

  if L0_2 then

    L2_2 = L39_1.IN_VEHICLE

    L1_2 = L1_2 | L2_2

  end

  L2_2 = L40_1

  if L2_2 ~= L1_2 then

    L2_2 = L41_1

    L2_2, L3_2, L4_2 = L2_2()

    L40_1 = L1_2

    L26_1 = L4_2

    L5_2 = debugprint

    L6_2 = "Camera mode changed to: "

    L7_2 = L40_1

    L6_2 = L6_2 .. L7_2

    L5_2(L6_2)

    L5_2 = L43_1

    L5_2()

    L5_2 = SetCamFov

    L6_2 = L38_1

    L7_2 = L26_1

    L5_2(L6_2, L7_2)

  end

  L2_2 = L33_1

  L2_2 = IsDisabledControlPressed

  L3_2 = 0

  L4_2 = 33

  L2_2 = L2_2(L3_2, L4_2)

  if not L2_2 then

    L2_2 = IsDisabledControlPressed

    L3_2 = 0

    L4_2 = 34

    L2_2 = L2_2(L3_2, L4_2)

    if not L2_2 then

      L2_2 = IsDisabledControlPressed

      L3_2 = 0

      L4_2 = 35

      L2_2 = not L2_2 and not L0_2 and L2_2

    end

  end

  L34_1 = L2_2

  L2_2 = SetFollowPedCamViewMode

  L3_2 = 0

  L2_2(L3_2)

  L2_2 = SetGameplayCamRelativeHeading

  L3_2 = 0.0

  L2_2(L3_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 1

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 14

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 15

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 16

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 17

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 99

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 100

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 115

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 116

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 261

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = DisableControlAction

  L3_2 = 0

  L4_2 = 262

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = SetPedResetFlag

  L3_2 = L32_1

  L4_2 = 47

  L5_2 = true

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = L30_1

  if L2_2 and not L0_2 then

    L2_2 = GetEntityCoords

    L3_2 = L32_1

    L2_2 = L2_2(L3_2)

    L3_2 = GetCamCoord

    L4_2 = L38_1

    L3_2 = L3_2(L4_2)

    L2_2 = L2_2 - L3_2

    L2_2 = #L2_2

    L3_2 = L18_1

    if not (L2_2 > L3_2) then

      L3_2 = GetGameTimer

      L3_2 = L3_2()

      L4_2 = L31_1

      if not (L3_2 > L4_2) then

        goto lbl_154

      end

    end

    L3_2 = false

    L30_1 = L3_2

    L3_2 = TogglePhoneAnimation

    L4_2 = true

    L5_2 = "camera"

    L3_2(L4_2, L5_2)

    ::lbl_154::

    return

  end

  L2_2 = L5_1

  if not L2_2 then

    L2_2 = DisableControlAction

    L3_2 = 0

    L4_2 = 21

    L5_2 = true

    L2_2(L3_2, L4_2, L5_2)

  end

  L2_2 = L33_1

  if L2_2 and not L0_2 then

    L2_2 = AttachCamToPedBone_2

    L3_2 = L38_1

    L4_2 = L32_1

    L5_2 = 0

    L6_2 = L21_1.x

    L7_2 = L24_1

    L6_2 = L6_2 + L7_2

    L7_2 = L21_1.y

    L8_2 = L21_1.z

    L9_2 = L20_1.x

    L10_2 = L20_1.y

    L11_2 = L20_1.z

    L12_2 = true

    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

  else

    L2_2 = L33_1

    if not L2_2 and not L0_2 then

      L2_2 = GetOffsetFromEntityInWorldCoords

      L3_2 = L32_1

      L4_2 = L23_1.x

      L5_2 = L23_1.y

      L6_2 = L23_1.z

      L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)

      L3_2 = GetPedBoneCoords

      L4_2 = L32_1

      L5_2 = 31086

      L6_2 = 0.0

      L7_2 = 0.0

      L8_2 = 0.0

      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

      L4_2 = math

      L4_2 = L4_2.abs

      L5_2 = L3_2.z

      L6_2 = L2_2.z

      L5_2 = L5_2 - L6_2

      L4_2 = L4_2(L5_2)

      L5_2 = 0.2

      if L4_2 > L5_2 then

        L4_2 = L3_2.z

        if L4_2 then

          goto lbl_216

        end

      end

      L4_2 = L2_2.z

      ::lbl_216::

      L5_2 = DetachCam

      L6_2 = L38_1

      L5_2(L6_2)

      L5_2 = SetCamCoord

      L6_2 = L38_1

      L7_2 = L2_2.x

      L8_2 = L2_2.y

      L9_2 = L4_2

      L5_2(L6_2, L7_2, L8_2, L9_2)

      L5_2 = SetCamRot

      L6_2 = L38_1

      L7_2 = L24_1

      L8_2 = L25_1

      L9_2 = GetEntityHeading

      L10_2 = L32_1

      L9_2 = L9_2(L10_2)

      L10_2 = 2

      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)

    else

      L2_2 = L33_1

      if L2_2 and L0_2 then

        L2_2 = AttachCamToPedBone_2

        L3_2 = L38_1

        L4_2 = L32_1

        L5_2 = 0

        L6_2 = L24_1

        L6_2 = 80.0 + L6_2

        L7_2 = 0.0

        L8_2 = -180.0

        L9_2 = 0.0

        L10_2 = 0.2

        L11_2 = 0.5

        L12_2 = true

        L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)

      else

        L2_2 = L33_1

        if not L2_2 and L0_2 then

          L2_2 = GetPhoneObject

          L2_2 = L2_2()

          if L2_2 then

            L3_2 = SetEntityLocallyInvisible

            L4_2 = L2_2

            L3_2(L4_2)

          end

          L3_2 = SetEntityLocallyInvisible

          L4_2 = L32_1

          L3_2(L4_2)

          L3_2 = AttachCamToPedBone_2

          L4_2 = L38_1

          L5_2 = L32_1

          L6_2 = GetPedBoneIndex

          L7_2 = L32_1

          L8_2 = 11816

          L6_2 = L6_2(L7_2, L8_2)

          L7_2 = L24_1

          L8_2 = 0.0

          L9_2 = L28_1

          L10_2 = 0.0

          L11_2 = 0.0

          L12_2 = 0.55

          L13_2 = true

          L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)

        end

      end

    end

  end

  if L0_2 then

    L2_2 = L29_1

    if not L2_2 then

      L2_2 = true

      L29_1 = L2_2

      L2_2 = SetUserRadioControlEnabled

      L3_2 = false

      L2_2(L3_2)

    end

  else

    L2_2 = L29_1

    if L2_2 then

      L2_2 = false

      L29_1 = L2_2

      L2_2 = SetUserRadioControlEnabled

      L3_2 = true

      L2_2(L3_2)

    end

    L2_2 = 0.0

    L28_1 = L2_2

  end

  L2_2 = L34_1

  if L2_2 then

    L2_2 = SetPedResetFlag

    L3_2 = L32_1

    L4_2 = 69

    L5_2 = true

    L2_2(L3_2, L4_2, L5_2)

  else

    L2_2 = L33_1

    if not L2_2 and not L0_2 then

      L2_2 = DisableControlAction

      L3_2 = 0

      L4_2 = 30

      L5_2 = true

      L2_2(L3_2, L4_2, L5_2)

    end

  end

  L2_2 = GetCamFov

  L3_2 = L38_1

  L2_2 = L2_2(L3_2)

  L3_2 = L33_1

  if L3_2 then

    L3_2 = L14_1

    if L3_2 then

      goto lbl_340

    end

  end

  if L0_2 then

    L3_2 = L7_1

    if L3_2 then

      goto lbl_340

    end

  end

  L3_2 = L0_1

  ::lbl_340::

  L4_2 = L33_1

  if L4_2 then

    L4_2 = L16_1

    if L4_2 then

      goto lbl_358

    end

  end

  if L0_2 then

    L4_2 = L6_1

    if L4_2 then

      L4_2 = L9_1

      if L4_2 then

        goto lbl_358

      end

    end

    L4_2 = L7_1

    if L4_2 then

      goto lbl_358

    end

  end

  L4_2 = L2_1

  ::lbl_358::

  L5_2 = math

  L5_2 = L5_2.clamp

  L6_2 = L26_1

  L7_2 = L4_2

  L8_2 = L3_2

  L5_2 = L5_2(L6_2, L7_2, L8_2)

  L26_1 = L5_2

  L5_2 = math

  L5_2 = L5_2.round

  L6_2 = ConvertFovToZoom

  L7_2 = L2_2

  L6_2 = L6_2(L7_2)

  L7_2 = 1

  L5_2 = L5_2(L6_2, L7_2)

  L6_2 = L37_1

  if L5_2 ~= L6_2 then

    L6_2 = debugprint

    L7_2 = "Zoom changed to: "

    L8_2 = L5_2

    L7_2 = L7_2 .. L8_2

    L8_2 = ConvertFovToZoom

    L9_2 = L2_2

    L8_2 = L8_2(L9_2)

    L9_2 = L2_2

    L6_2(L7_2, L8_2, L9_2)

    L37_1 = L5_2

    L6_2 = SendReactMessage

    L7_2 = "camera:setZoom"

    L8_2 = L5_2

    L6_2(L7_2, L8_2)

  end

  L6_2 = math

  L6_2 = L6_2.abs

  L7_2 = L26_1

  L7_2 = L2_2 - L7_2

  L6_2 = L6_2(L7_2)

  L7_2 = 0.05

  if L6_2 > L7_2 then

    L6_2 = SetCamFov

    L7_2 = L38_1

    L8_2 = L26_1

    L8_2 = L8_2 - L2_2

    L8_2 = L8_2 / 25

    L8_2 = L2_2 + L8_2

    L6_2(L7_2, L8_2)

  end

  L6_2 = IsNuiFocused

  L6_2 = L6_2()

  if L6_2 then

    return

  end

  L6_2 = L36_1

  L7_2 = L26_1

  L8_2 = L0_1

  L7_2 = L7_2 / L8_2

  L6_2 = L6_2 * L7_2

  L6_2 = L6_2 / 5

  L35_1 = L6_2

  L6_2 = GetDisabledControlNormal

  L7_2 = 0

  L8_2 = 1

  L6_2 = L6_2(L7_2, L8_2)

  if L0_2 then

    L7_2 = math

    L7_2 = L7_2.clamp

    L8_2 = L28_1

    L9_2 = L35_1

    L9_2 = L6_2 * L9_2

    L8_2 = L8_2 - L9_2

    L9_2 = L13_1

    L10_2 = L12_1

    L7_2 = L7_2(L8_2, L9_2, L10_2)

    L28_1 = L7_2

  elseif 0.0 ~= L6_2 then

    L7_2 = SetEntityHeading

    L8_2 = L32_1

    L9_2 = GetEntityHeading

    L10_2 = L32_1

    L9_2 = L9_2(L10_2)

    L10_2 = L35_1

    L10_2 = L6_2 * L10_2

    L9_2 = L9_2 - L10_2

    L7_2(L8_2, L9_2)

  end

  L7_2 = IsDisabledControlPressed

  L8_2 = 0

  L9_2 = 180

  L7_2 = L7_2(L8_2, L9_2)

  if L7_2 then

    L7_2 = L26_1

    L7_2 = L7_2 + 5

    L26_1 = L7_2

  else

    L7_2 = IsDisabledControlPressed

    L8_2 = 0

    L9_2 = 181

    L7_2 = L7_2(L8_2, L9_2)

    if L7_2 then

      L7_2 = L26_1

      L7_2 = L7_2 - 5

      L26_1 = L7_2

    end

  end

  L7_2 = GetDisabledControlNormal

  L8_2 = 0

  L9_2 = 2

  L7_2 = L7_2(L8_2, L9_2)

  if 0.0 ~= L7_2 then

    L8_2 = L35_1

    L8_2 = L7_2 * L8_2

    if L0_2 then

      L9_2 = math

      L9_2 = L9_2.clamp

      L10_2 = L24_1

      L10_2 = L10_2 - L8_2

      L11_2 = L11_1

      L12_2 = L10_1

      L9_2 = L9_2(L10_2, L11_2, L12_2)

      L24_1 = L9_2

    else

      L9_2 = math

      L9_2 = L9_2.clamp

      L10_2 = L24_1

      L10_2 = L10_2 - L8_2

      L11_2 = L4_1

      L12_2 = L3_1

      L9_2 = L9_2(L10_2, L11_2, L12_2)

      L24_1 = L9_2

    end

  end

end

function L45_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2

  L0_2 = GetDisabledControlNormal

  L1_2 = 0

  L2_2 = 1

  L0_2 = L0_2(L1_2, L2_2)

  if 0.0 ~= L0_2 then

    L1_2 = SetEntityHeading

    L2_2 = L32_1

    L3_2 = GetEntityHeading

    L4_2 = L32_1

    L3_2 = L3_2(L4_2)

    L4_2 = L35_1

    L4_2 = L0_2 * L4_2

    L3_2 = L3_2 - L4_2

    L1_2(L2_2, L3_2)

  end

end

function L46_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = L38_1

  if L1_2 then

    return

  end

  L1_2 = true == A0_2

  L33_1 = L1_2

  L1_2 = false

  L34_1 = L1_2

  L1_2 = L33_1

  if L1_2 then

    L1_2 = L15_1

    if L1_2 then

      goto lbl_19

    end

  end

  L1_2 = L1_1

  ::lbl_19::

  L26_1 = L1_2

  L1_2 = PlayerPedId

  L1_2 = L1_2()

  L32_1 = L1_2

  L1_2 = GetFollowPedCamViewMode

  L1_2 = L1_2()

  L27_1 = L1_2

  L1_2 = 0.0

  L24_1 = L1_2

  L1_2 = 0.0

  L28_1 = L1_2

  L1_2 = 0.0

  L25_1 = L1_2

  L1_2 = false

  L30_1 = L1_2

  L1_2 = CreateCam

  L2_2 = "DEFAULT_SCRIPTED_CAMERA"

  L3_2 = true

  L1_2 = L1_2(L2_2, L3_2)

  L38_1 = L1_2

  L1_2 = GetProfileSetting

  L2_2 = 754

  L1_2 = L1_2(L2_2)

  L1_2 = L1_2 + 10

  L36_1 = L1_2

  L1_2 = 1.0

  L37_1 = L1_2

  L1_2 = SetPhoneAction

  L2_2 = "camera"

  L1_2(L2_2)

  L1_2 = CreateThread

  function L2_2()

    local L0_3, L1_3

    while true do

      L0_3 = L38_1

      if not L0_3 then

        break

      end

      L0_3 = Wait

      L1_3 = 0

      L0_3(L1_3)

      L0_3 = L34_1

      if not L0_3 then

        L0_3 = L30_1

        if not L0_3 then

          goto lbl_19

        end

      end

      L0_3 = IsNuiFocused

      L0_3 = L0_3()

      if not L0_3 then

        L0_3 = L45_1

        L0_3()

      end

      ::lbl_19::

    end

  end

  L1_2(L2_2)

  L1_2 = CreateThread

  function L2_2()

    local L0_3, L1_3

    while true do

      L0_3 = L38_1

      if not L0_3 then

        break

      end

      L0_3 = Wait

      L1_3 = 0

      L0_3(L1_3)

      L0_3 = L44_1

      L0_3()

    end

    L0_3 = L29_1

    if L0_3 then

      L0_3 = false

      L29_1 = L0_3

      L0_3 = SetUserRadioControlEnabled

      L1_3 = true

      L0_3(L1_3)

    end

  end

  L1_2(L2_2)

  L1_2 = SetCamFov

  L2_2 = L38_1

  L3_2 = L26_1

  L1_2(L2_2, L3_2)

  L1_2 = RenderScriptCams

  L2_2 = true

  L3_2 = false

  L4_2 = 0

  L5_2 = true

  L6_2 = true

  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)

  L1_2 = SetCamActive

  L2_2 = L38_1

  L3_2 = true

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "camera:setZoom"

  L3_2 = 1.0

  L1_2(L2_2, L3_2)

  L1_2 = L43_1

  L1_2()

  L1_2 = RefreshAnimationsInterval

  L1_2()

end

EnableWalkableCam = L46_1

function L46_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2

  L0_2 = L38_1

  if not L0_2 then

    return

  end

  L0_2 = RenderScriptCams

  L1_2 = false

  L2_2 = false

  L3_2 = 0

  L4_2 = true

  L5_2 = true

  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)

  L0_2 = DestroyCam

  L1_2 = L38_1

  L2_2 = false

  L0_2(L1_2, L2_2)

  L0_2 = SetFollowPedCamViewMode

  L1_2 = L27_1

  L0_2(L1_2)

  L0_2 = SetPhoneAction

  L1_2 = IsInCall

  L1_2 = L1_2()

  if L1_2 then

    L1_2 = "call"

    if L1_2 then

      goto lbl_28

    end

  end

  L1_2 = "default"

  ::lbl_28::

  L0_2(L1_2)

  L0_2 = nil

  L38_1 = L0_2

  L0_2 = L30_1

  if L0_2 then

    L0_2 = TogglePhoneAnimation

    L1_2 = true

    L2_2 = "camera"

    L0_2(L1_2, L2_2)

  end

  L0_2 = RefreshAnimationsInterval

  L0_2()

end

DisableWalkableCam = L46_1

function L46_1(A0_2)

  local L1_2, L2_2

  L1_2 = L33_1

  L2_2 = true == A0_2

  L33_1 = L2_2

  L2_2 = L33_1

  if L1_2 ~= L2_2 then

    L2_2 = 0.0

    L25_1 = L2_2

    L2_2 = 0.0

    L24_1 = L2_2

  end

end

ToggleSelfieCam = L46_1

function L46_1()

  local L0_2, L1_2, L2_2, L3_2

  L0_2 = L17_1

  if L0_2 then

    L0_2 = L38_1

    if L0_2 then

      L0_2 = L33_1

      if not L0_2 then

        goto lbl_11

      end

    end

  end

  do return end

  ::lbl_11::

  L0_2 = L30_1

  L0_2 = not L0_2

  if L0_2 then

    L1_2 = TogglePhoneAnimation

    L2_2 = false

    L3_2 = "camera"

    L1_2(L2_2, L3_2)

    L1_2 = GetGameTimer

    L1_2 = L1_2()

    L2_2 = L19_1

    L1_2 = L1_2 + L2_2

    L31_1 = L1_2

  end

  L30_1 = L0_2

end

ToggleCameraFrozen = L46_1

function L46_1()

  local L0_2, L1_2

  L0_2 = L38_1

  L0_2 = nil ~= L0_2

  return L0_2

end

IsWalkingCamEnabled = L46_1

function L46_1()

  local L0_2, L1_2

  L0_2 = L33_1

  return L0_2

end

IsSelfieCam = L46_1

L46_1 = AddEventHandler

L47_1 = "lb-phone:keyPressed"

function L48_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = L38_1

  if not L1_2 then

    return

  end

  if "FreezeCamera" == A0_2 then

    L1_2 = L17_1

    if L1_2 then

      L1_2 = L33_1

      if not L1_2 then

        goto lbl_14

      end

    end

    do return end

    ::lbl_14::

    L1_2 = ToggleCameraFrozen

    L1_2()

  elseif "RollLeft" == A0_2 or "RollRight" == A0_2 then

    L1_2 = L22_1

    if not L1_2 then

      return

    end

    if "RollLeft" == A0_2 then

      L1_2 = -0.5

      if L1_2 then

        goto lbl_31

      end

    end

    L1_2 = 0.5

    ::lbl_31::

    L2_2 = Config

    L2_2 = L2_2.KeyBinds

    L2_2 = L2_2[A0_2]

    L2_2 = L2_2.bindData

    while true do

      L3_2 = L2_2.pressed

      if not L3_2 then

        break

      end

      L3_2 = Wait

      L4_2 = 0

      L3_2(L4_2)

      L3_2 = L25_1

      L3_2 = L3_2 + L1_2

      L25_1 = L3_2

    end

  end

end

L46_1(L47_1, L48_1)

L46_1 = exports

L47_1 = "EnableWalkableCam"

L48_1 = EnableWalkableCam

L46_1(L47_1, L48_1)

L46_1 = exports

L47_1 = "DisableWalkableCam"

L48_1 = DisableWalkableCam

L46_1(L47_1, L48_1)

L46_1 = exports

L47_1 = "ToggleSelfieCam"

L48_1 = ToggleSelfieCam

L46_1(L47_1, L48_1)

L46_1 = exports

L47_1 = "ToggleCameraFrozen"

L48_1 = ToggleCameraFrozen

L46_1(L47_1, L48_1)

L46_1 = exports

L47_1 = "IsWalkingCamEnabled"

L48_1 = IsWalkingCamEnabled

L46_1(L47_1, L48_1)

L46_1 = exports

L47_1 = "IsSelfieCam"

L48_1 = IsSelfieCam

L46_1(L47_1, L48_1)
