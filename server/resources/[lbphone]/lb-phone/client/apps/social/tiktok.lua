local L0_1, L1_1, L2_1, L3_1

function L0_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = A0_2.metadata

  if L1_2 then

    L1_2 = json

    L1_2 = L1_2.decode

    L2_2 = A0_2.metadata

    L1_2 = L1_2(L2_2)

    A0_2.metadata = L1_2

  end

  L1_2 = A0_2.music

  if L1_2 then

    L1_2 = json

    L1_2 = L1_2.decode

    L2_2 = A0_2.music

    L1_2 = L1_2(L2_2)

    A0_2.music = L1_2

    L1_2 = Music

    L1_2 = L1_2.Songs

    L2_2 = A0_2.music

    if L2_2 then

      L2_2 = L2_2.path

    end

    L1_2 = L1_2[L2_2]

    if L1_2 then

      L2_2 = Music

      L2_2 = L2_2.Albums

      L3_2 = L1_2.album

      L2_2 = L2_2[L3_2]

      L3_2 = L2_2 or L3_2

      if L2_2 then

        L3_2 = L2_2.Cover

      end

      if L3_2 then

        L3_2 = L2_2.Cover

        L1_2.Cover = L3_2

      end

      L3_2 = {}

      L4_2 = L1_2.Title

      L3_2.title = L4_2

      L4_2 = L1_2.Artist

      L3_2.artist = L4_2

      L4_2 = L1_2.Cover

      L3_2.cover = L4_2

      L4_2 = A0_2.music

      L4_2 = L4_2.volume

      L3_2.volume = L4_2

      L4_2 = A0_2.music

      L4_2 = L4_2.path

      L3_2.path = L4_2

      A0_2.music = L3_2

    end

  end

  L1_2 = A0_2.liked

  if 1 == L1_2 then

    L1_2 = true

    if L1_2 then

      goto lbl_59

    end

  end

  L1_2 = false

  ::lbl_59::

  A0_2.liked = L1_2

  L1_2 = A0_2.saved

  if 1 == L1_2 then

    L1_2 = true

    if L1_2 then

      goto lbl_67

    end

  end

  L1_2 = false

  ::lbl_67::

  A0_2.saved = L1_2

  L1_2 = A0_2.viewed

  if 1 == L1_2 then

    L1_2 = true

    if L1_2 then

      goto lbl_75

    end

  end

  L1_2 = false

  ::lbl_75::

  A0_2.viewed = L1_2

  return A0_2

end

L1_1 = RegisterNUICallback

L2_1 = "TikTok"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Trendy:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  if "login" == L2_2 then

    A0_2 = A0_2.data

    L3_2 = TriggerCallback

    L4_2 = "tiktok:login"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "signup" == L2_2 then

    A0_2 = A0_2.data

    L3_2 = TriggerCallback

    L4_2 = "tiktok:signup"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.password

    L8_2 = A0_2.name

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "changePassword" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:changePassword"

    L5_2 = A1_2

    L6_2 = A0_2.oldPassword

    L7_2 = A0_2.newPassword

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "deleteAccount" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:deleteAccount"

    L5_2 = A1_2

    L6_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2)

  elseif "logout" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:logout"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "isLoggedIn" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:isLoggedIn"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getProfile" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getProfile"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L3_2(L4_2, L5_2, L6_2)

  elseif "updateProfile" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:updateProfile"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "searchAccounts" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:searchAccounts"

    L5_2 = A1_2

    L6_2 = A0_2.query

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "toggleFollow" == L2_2 then

    A0_2 = A0_2.data

    L3_2 = TriggerCallback

    L4_2 = "tiktok:toggleFollow"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.follow

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getFollowing" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getFollowing"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getFollowers" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getFollowers"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "uploadVideo" == L2_2 then

    A0_2 = A0_2.data

    L3_2 = A0_2.src

    if L3_2 then

      L3_2 = A0_2.caption

      if L3_2 then

        goto lbl_134

      end

    end

    L3_2 = A1_2

    L4_2 = {}

    L4_2.success = false

    L4_2.error = "invalid_caption"

    do return L3_2(L4_2) end

    ::lbl_134::

    L3_2 = A0_2.music

    if L3_2 then

      L3_2 = A0_2.music

      L3_2 = L3_2.path

      if L3_2 then

        L3_2 = A0_2.music

        L3_2 = L3_2.volume

        if L3_2 then

          goto lbl_152

        end

      end

      L3_2 = A1_2

      L4_2 = {}

      L4_2.success = false

      L4_2.error = "invalid_music"

      return L3_2(L4_2)

    end

    ::lbl_152::

    L3_2 = A0_2.music

    if L3_2 then

      L3_2 = json

      L3_2 = L3_2.encode

      L4_2 = A0_2.music

      L3_2 = L3_2(L4_2)

      A0_2.music = L3_2

    end

    L3_2 = A0_2.metadata

    if L3_2 then

      L3_2 = type

      L4_2 = A0_2.metadata

      L3_2 = L3_2(L4_2)

      if "table" == L3_2 then

        L3_2 = true

        L4_2 = pairs

        L5_2 = A0_2.metadata

        L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)

        for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do

          L3_2 = false

          break

        end

        if L3_2 then

          A0_2.metadata = nil

        else

          L4_2 = json

          L4_2 = L4_2.encode

          L5_2 = A0_2.metadata

          L4_2 = L4_2(L5_2)

          A0_2.metadata = L4_2

        end

    end

    else

      A0_2.metadata = nil

    end

    L3_2 = TriggerCallback

    L4_2 = "tiktok:uploadVideo"

    L5_2 = A1_2

    L6_2 = A0_2

    L3_2(L4_2, L5_2, L6_2)

  elseif "deleteVideo" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:deleteVideo"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "togglePinnedVideo" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:togglePinnedVideo"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.toggle

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getVideos" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getVideos"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3

      L1_3 = 1

      L2_3 = #A0_3

      L3_3 = 1

      for L4_3 = L1_3, L2_3, L3_3 do

        L5_3 = L0_1

        L6_3 = A0_3[L4_3]

        L5_3 = L5_3(L6_3)

        A0_3[L4_3] = L5_3

      end

      L1_3 = A1_2

      L2_3 = A0_3

      L1_3(L2_3)

    end

    L6_2 = A0_2.data

    L7_2 = A0_2.page

    if not L7_2 then

      L7_2 = 0

    end

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getVideo" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getVideo"

    function L5_2(A0_3)

      local L1_3, L2_3

      L1_3 = A0_3.video

      if L1_3 then

        L1_3 = L0_1

        L2_3 = A0_3.video

        L1_3 = L1_3(L2_3)

        A0_3.video = L1_3

      end

      L1_3 = A1_2

      L2_3 = A0_3

      L1_3(L2_3)

    end

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "setViewed" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:tiktok:setViewed"

    L5_2 = A0_2.id

    L3_2(L4_2, L5_2)

    L3_2 = A1_2

    L4_2 = "ok"

    L3_2(L4_2)

  elseif "toggleLike" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:toggleVideoAction"

    L5_2 = A1_2

    L6_2 = "like"

    L7_2 = A0_2.id

    L8_2 = A0_2.toggle

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "toggleSave" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:toggleVideoAction"

    L5_2 = A1_2

    L6_2 = "save"

    L7_2 = A0_2.id

    L8_2 = A0_2.toggle

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "postComment" == L2_2 then

    A0_2 = A0_2.data

    L3_2 = TriggerCallback

    L4_2 = "tiktok:postComment"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.replyTo

    L8_2 = A0_2.comment

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "getComments" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getComments"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L6_2 = L6_2.id

    L7_2 = A0_2.data

    L7_2 = L7_2.replyTo

    L8_2 = A0_2.data

    L8_2 = L8_2.creator

    L9_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)

  elseif "deleteComment" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:deleteComment"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.videoId

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "setPinnedComment" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:setPinnedComment"

    L5_2 = A1_2

    L6_2 = A0_2.commentId

    L7_2 = A0_2.videoId

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "toggleLikeComment" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:toggleLikeComment"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.toggle

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getRecentMessages" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getRecentMessages"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getMessages" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getMessages"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "sendMessage" == L2_2 then

    L3_2 = CanInteract

    L3_2 = L3_2()

    if not L3_2 then

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    end

    L3_2 = TriggerCallback

    L4_2 = "tiktok:sendMessage"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "getChannelId" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getChannelId"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L3_2(L4_2, L5_2, L6_2)

  elseif "getNotifications" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getNotifications"

    L5_2 = A1_2

    L6_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2)

  elseif "getUnreadMessages" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "tiktok:getUnreadMessages"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "clearUnreadMessages" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:tiktok:clearUnreadMessages"

    L5_2 = A0_2.id

    L3_2(L4_2, L5_2)

  end

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:tiktok:updateFollowers"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "tiktok:updateFollowers"

  L4_2 = {}

  L4_2.username = A0_2

  L4_2.method = A1_2

  L2_2(L3_2, L4_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:tiktok:updateFollowing"

function L3_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "tiktok:updateFollowing"

  L4_2 = {}

  L4_2.username = A0_2

  L4_2.method = A1_2

  L2_2(L3_2, L4_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:tiktok:updateVideoStats"

function L3_1(A0_2, A1_2, A2_2, A3_2)

  local L4_2, L5_2, L6_2, L7_2

  L4_2 = {}

  L4_2.id = A1_2

  L4_2.method = A2_2

  L4_2.count = A3_2

  if "like" == A0_2 then

    L5_2 = SendReactMessage

    L6_2 = "tiktok:updateLikes"

    L7_2 = L4_2

    L5_2(L6_2, L7_2)

  elseif "save" == A0_2 then

    L5_2 = SendReactMessage

    L6_2 = "tiktok:updateSaves"

    L7_2 = L4_2

    L5_2(L6_2, L7_2)

  elseif "comment" == A0_2 then

    L5_2 = SendReactMessage

    L6_2 = "tiktok:updateComments"

    L7_2 = L4_2

    L5_2(L6_2, L7_2)

  end

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:tiktok:updateCommentStats"

function L3_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2

  if "reply" == A0_2 then

    L3_2 = SendReactMessage

    L4_2 = "tiktok:updateReplies"

    L5_2 = {}

    L5_2.id = A1_2

    L5_2.method = A2_2

    L3_2(L4_2, L5_2)

  elseif "like" == A0_2 then

    L3_2 = SendReactMessage

    L4_2 = "tiktok:updateCommentLikes"

    L5_2 = {}

    L5_2.id = A1_2

    L5_2.method = A2_2

    L3_2(L4_2, L5_2)

  end

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:tiktok:receivedMessage"

function L3_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "tiktok:receivedMessage"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L1_1(L2_1, L3_1)

L1_1 = RegisterNetEvent

L2_1 = "phone:tiktok:newVideo"

function L3_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = TriggerEvent

  L2_2 = "lb-phone:trendy:newPost"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L1_1(L2_1, L3_1)