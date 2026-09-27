local L0_1, L1_1, L2_1, L3_1

function L0_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2

  L0_2 = AwaitCallback

  L1_2 = "music:getPlaylists"

  L0_2 = L0_2(L1_2)

  L1_2 = {}

  L2_2 = {}

  L3_2 = 1

  L4_2 = #L0_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = L0_2[L6_2]

    L8_2 = L7_2.id

    L8_2 = L2_2[L8_2]

    if not L8_2 then

      L8_2 = L7_2.id

      L2_2[L8_2] = true

      L8_2 = #L1_2

      L8_2 = L8_2 + 1

      L9_2 = {}

      L10_2 = L7_2.id

      L9_2.Id = L10_2

      L10_2 = L7_2.name

      L9_2.Title = L10_2

      L10_2 = L7_2.cover

      L9_2.Cover = L10_2

      L10_2 = L7_2.phone_number

      L11_2 = currentPhone

      L10_2 = L10_2 == L11_2

      L9_2.IsOwner = L10_2

      L10_2 = {}

      L9_2.Songs = L10_2

      L1_2[L8_2] = L9_2

    end

    L8_2 = L7_2.song_id

    if L8_2 then

      L8_2 = #L1_2

      L8_2 = L1_2[L8_2]

      L8_2 = L8_2.Songs

      L9_2 = #L1_2

      L9_2 = L1_2[L9_2]

      L9_2 = L9_2.Songs

      L9_2 = #L9_2

      L9_2 = L9_2 + 1

      L10_2 = L7_2.song_id

      L8_2[L9_2] = L10_2

    end

  end

  return L1_2

end

L1_1 = RegisterNUICallback

L2_1 = "Music"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Music:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "getConfig" == L2_2 then

    L3_2 = A1_2

    L4_2 = Music

    L3_2(L4_2)

  end

  if "createPlaylist" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "music:createPlaylist"

    L5_2 = A1_2

    L6_2 = A0_2.name

    L3_2(L4_2, L5_2, L6_2)

  elseif "editPlaylist" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "music:editPlaylist"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.title

    L8_2 = A0_2.cover

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "getPlaylists" == L2_2 then

    L3_2 = A1_2

    L4_2 = L0_1

    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2()

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "deletePlaylist" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "music:deletePlaylist"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "savePlaylist" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "music:savePlaylist"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "addSong" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "music:addSong"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.song

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "removeSong" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "music:removeSong"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.song

    L3_2(L4_2, L5_2, L6_2, L7_2)

  end

end

L1_1(L2_1, L3_1)