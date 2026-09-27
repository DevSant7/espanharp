local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1

L0_1 = false

L1_1 = nil

L2_1 = {}

L3_1 = "sendLiveMessage"

L4_1 = "logIn"

L5_1 = "toggleFollow"

L6_1 = "toggleLike"

L7_1 = "postComment"

L8_1 = "sendMessage"

L2_1[1] = L3_1

L2_1[2] = L4_1

L2_1[3] = L5_1

L2_1[4] = L6_1

L2_1[5] = L7_1

L2_1[6] = L8_1

L3_1 = {}

watchingSources = L3_1

L3_1 = RegisterNUICallback

L4_1 = "Instagram"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "InstaPic:"

  L5_2 = L2_2 or L5_2

  if not L2_2 then

    L5_2 = ""

  end

  L4_2 = L4_2 .. L5_2

  L3_2(L4_2)

  L3_2 = table

  L3_2 = L3_2.contains

  L4_2 = L2_1

  L5_2 = L2_2

  L3_2 = L3_2(L4_2, L5_2)

  if L3_2 then

    L3_2 = CanInteract

    L3_2 = L3_2()

    if not L3_2 then

      L3_2 = A1_2

      L4_2 = false

      return L3_2(L4_2)

    end

  end

  if "getLives" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getLives"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getLiveViewers" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getLiveViewers"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L3_2(L4_2, L5_2, L6_2)

  elseif "goLive" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "instagram:canGoLive"

    L3_2 = L3_2(L4_2)

    if not L3_2 then

      L4_2 = debugprint

      L5_2 = "not allowed to go live"

      L4_2(L5_2)

      L4_2 = A1_2

      L5_2 = false

      L4_2(L5_2)

      return

    end

    L4_2 = debugprint

    L5_2 = "allowed to go live; setting live stream on ui"

    L4_2(L5_2)

    L4_2 = A1_2

    L5_2 = true

    L4_2(L5_2)

  elseif "setLive" == L2_2 then

    L3_2 = debugprint

    L4_2 = "sending server event to start livestream"

    L3_2(L4_2)

    L3_2 = TriggerServerEvent

    L4_2 = "phone:instagram:startLive"

    L5_2 = A0_2.id

    L3_2(L4_2, L5_2)

    L3_2 = true

    L0_1 = L3_2

    L3_2 = EnableWalkableCam

    L3_2()

  elseif "endLive" == L2_2 then

    L3_2 = EndLive

    L3_2()

    L3_2 = A1_2

    L4_2 = true

    L3_2(L4_2)

  elseif "viewLive" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "instagram:viewLive"

    L5_2 = A0_2.username

    L3_2 = L3_2(L4_2, L5_2)

    if not L3_2 then

      L4_2 = A1_2

      L5_2 = false

      return L4_2(L5_2)

    end

    L4_2 = settings

    if L4_2 then

      L4_2 = L4_2.sound

      if L4_2 then

        L4_2 = L4_2.volume

      end

    end

    if not L4_2 then

      L4_2 = 0.5

    end

    L4_2 = L4_2 / 1

    L5_2 = A0_2.username

    L1_1 = L5_2

    L5_2 = watchingSources

    L6_2 = watchingSources

    L6_2 = #L6_2

    L6_2 = L6_2 + 1

    L7_2 = L3_2.host

    L5_2[L6_2] = L7_2

    L5_2 = 1

    L6_2 = L3_2.participants

    L6_2 = #L6_2

    L7_2 = 1

    for L8_2 = L5_2, L6_2, L7_2 do

      L9_2 = watchingSources

      L10_2 = watchingSources

      L10_2 = #L10_2

      L10_2 = L10_2 + 1

      L11_2 = L3_2.participants

      L11_2 = L11_2[L8_2]

      L11_2 = L11_2.source

      L9_2[L10_2] = L11_2

    end

    L5_2 = debugprint

    L6_2 = "InstaPic: adding voice targets. Volume:"

    L7_2 = L4_2

    L5_2(L6_2, L7_2)

    L5_2 = MumbleClearVoiceTargetPlayers

    L6_2 = 1

    L5_2(L6_2)

    L5_2 = 1

    L6_2 = watchingSources

    L6_2 = #L6_2

    L7_2 = 1

    for L8_2 = L5_2, L6_2, L7_2 do

      L9_2 = watchingSources

      L9_2 = L9_2[L8_2]

      L10_2 = MumbleAddVoiceTargetPlayerByServerId

      L11_2 = 1

      L12_2 = L9_2

      L10_2(L11_2, L12_2)

      L10_2 = MumbleSetVolumeOverrideByServerId

      L11_2 = L9_2

      L12_2 = L4_2

      L10_2(L11_2, L12_2)

      L10_2 = debugprint

      L11_2 = "started listening to"

      L12_2 = L9_2

      L10_2(L11_2, L12_2)

    end

    L5_2 = A1_2

    L6_2 = L3_2.viewers

    L6_2 = #L6_2

    L5_2(L6_2)

  elseif "stopViewing" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "instagram:stopViewing"

    L5_2 = A0_2.username

    L3_2(L4_2, L5_2)

    L3_2 = MumbleClearVoiceTargetPlayers

    L4_2 = 1

    L3_2(L4_2)

    L3_2 = 1

    L4_2 = watchingSources

    L4_2 = #L4_2

    L5_2 = 1

    for L6_2 = L3_2, L4_2, L5_2 do

      L7_2 = MumbleSetVolumeOverrideByServerId

      L8_2 = watchingSources

      L8_2 = L8_2[L6_2]

      L9_2 = -1.0

      L7_2(L8_2, L9_2)

      L7_2 = debugprint

      L8_2 = "stopped listening to"

      L9_2 = watchingSources

      L9_2 = L9_2[L6_2]

      L7_2(L8_2, L9_2)

    end

    L3_2 = nil

    L1_1 = L3_2

    L3_2 = {}

    watchingSources = L3_2

  elseif "sendLiveMessage" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:instagram:sendLiveMessage"

    L5_2 = A0_2.data

    L3_2(L4_2, L5_2)

  elseif "addCall" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:instagram:addCall"

    L5_2 = A0_2.id

    L3_2(L4_2, L5_2)

  elseif "inviteLive" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:instagram:inviteLive"

    L5_2 = A0_2.username

    L3_2(L4_2, L5_2)

  elseif "removeLive" == L2_2 then

    L3_2 = TriggerServerEvent

    L4_2 = "phone:instagram:removeLive"

    L5_2 = A0_2.username

    L3_2(L4_2, L5_2)

  elseif "joinLive" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "instagram:joinLive"

    L5_2 = A0_2.username

    L6_2 = A0_2.streamId

    L3_2 = L3_2(L4_2, L5_2, L6_2)

    L4_2 = A1_2

    L5_2 = L3_2

    L4_2(L5_2)

    if not L3_2 then

      return

    end

    L4_2 = true

    L0_1 = L4_2

    L4_2 = EnableWalkableCam

    L4_2()

  end

  if "addToStory" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "instagram:canCreateStory"

    L3_2 = L3_2(L4_2)

    if not L3_2 then

      L4_2 = debugprint

      L5_2 = "not allowed to go create story"

      L4_2(L5_2)

      L4_2 = A1_2

      L5_2 = false

      L4_2(L5_2)

      return

    end

    L4_2 = debugprint

    L5_2 = "allowed to create story"

    L4_2(L5_2)

    L4_2 = TriggerCallback

    L5_2 = "instagram:addToStory"

    L6_2 = A1_2

    L7_2 = A0_2.media

    L8_2 = A0_2.metadata

    L4_2(L5_2, L6_2, L7_2, L8_2)

  elseif "removeFromStory" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:removeFromStory"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "getStories" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getStories"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getStory" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getStory"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L3_2(L4_2, L5_2, L6_2)

  elseif "getViewers" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getViewers"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "viewedStory" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:viewedStory"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  end

  if "flipCamera" == L2_2 then

    L3_2 = ToggleSelfieCam

    L4_2 = IsSelfieCam

    L4_2 = L4_2()

    L4_2 = not L4_2

    L3_2(L4_2)

  elseif "createAccount" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:createAccount"

    L5_2 = A1_2

    L6_2 = A0_2.name

    L7_2 = A0_2.username

    L8_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "changePassword" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:changePassword"

    L5_2 = A1_2

    L6_2 = A0_2.oldPassword

    L7_2 = A0_2.newPassword

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "deleteAccount" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:deleteAccount"

    L5_2 = A1_2

    L6_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2)

  elseif "logIn" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:logIn"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "signOut" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:signOut"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "isLoggedIn" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:isLoggedIn"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getProfile" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getProfile"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L3_2(L4_2, L5_2, L6_2)

  elseif "newPost" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:createPost"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L6_2 = L6_2.images

    L7_2 = A0_2.data

    L7_2 = L7_2.caption

    L8_2 = A0_2.data

    L8_2 = L8_2.location

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "deletePost" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:deletePost"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "getPosts" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getPosts"

    L5_2 = A1_2

    L6_2 = A0_2.filters

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getPost" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getPost"

    L5_2 = A1_2

    L6_2 = A0_2.id

    L3_2(L4_2, L5_2, L6_2)

  elseif "updateProfile" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:updateProfile"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2)

  elseif "getFollowers" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getData"

    L5_2 = A1_2

    L6_2 = "followers"

    L7_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getFollowing" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getData"

    L5_2 = A1_2

    L6_2 = "following"

    L7_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getLikes" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getData"

    L5_2 = A1_2

    L6_2 = "likes"

    L7_2 = A0_2.data

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "toggleFollow" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:toggleFollow"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L6_2 = L6_2.username

    L7_2 = A0_2.data

    L7_2 = L7_2.following

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "toggleLike" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:toggleLike"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L6_2 = L6_2.postId

    L7_2 = A0_2.data

    L7_2 = L7_2.toggle

    L8_2 = A0_2.data

    L8_2 = L8_2.isComment

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "getComments" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "instagram:getComments"

    L5_2 = A0_2.postId

    L6_2 = A0_2.page

    if not L6_2 then

      L6_2 = 0

    end

    L3_2 = L3_2(L4_2, L5_2, L6_2)

    L4_2 = {}

    L5_2 = 1

    L6_2 = #L3_2

    L7_2 = 1

    for L8_2 = L5_2, L6_2, L7_2 do

      L9_2 = L3_2[L8_2]

      L10_2 = {}

      L11_2 = {}

      L12_2 = L9_2.username

      L11_2.username = L12_2

      L12_2 = L9_2.profile_image

      L11_2.avatar = L12_2

      L12_2 = L9_2.verified

      L11_2.verified = L12_2

      L10_2.user = L11_2

      L11_2 = {}

      L12_2 = L9_2.comment

      L11_2.content = L12_2

      L12_2 = L9_2.timestamp

      L11_2.timestamp = L12_2

      L12_2 = L9_2.like_count

      L11_2.likes = L12_2

      L12_2 = L9_2.liked

      L11_2.liked = L12_2

      L12_2 = L9_2.id

      L11_2.id = L12_2

      L10_2.comment = L11_2

      L4_2[L8_2] = L10_2

    end

    L5_2 = A1_2

    L6_2 = L4_2

    L5_2(L6_2)

  elseif "postComment" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:postComment"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L6_2 = L6_2.postId

    L7_2 = A0_2.data

    L7_2 = L7_2.comment

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "signOut" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:signOut"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getNotifications" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getNotifications"

    L5_2 = A1_2

    L6_2 = A0_2.page

    if not L6_2 then

      L6_2 = 0

    end

    L3_2(L4_2, L5_2, L6_2)

  elseif "getFollowRequests" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:getFollowRequests"

    L5_2 = A1_2

    L6_2 = A0_2.page

    if not L6_2 then

      L6_2 = 0

    end

    L3_2(L4_2, L5_2, L6_2)

  elseif "handleFollowRequest" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:handleFollowRequest"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.accept

    L3_2(L4_2, L5_2, L6_2, L7_2)

  end

  if "getRecentMessages" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "instagram:getRecentMessages"

    L5_2 = A0_2.page

    L3_2 = L3_2(L4_2, L5_2)

    L4_2 = 1

    L5_2 = #L3_2

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = L3_2[L7_2]

      L9_2 = L3_2[L7_2]

      L9_2 = L9_2.attachments

      if L9_2 then

        L9_2 = json

        L9_2 = L9_2.decode

        L10_2 = L3_2[L7_2]

        L10_2 = L10_2.attachments

        L9_2 = L9_2(L10_2)

      end

      L8_2.attachments = L9_2

    end

    L4_2 = A1_2

    L5_2 = L3_2

    L4_2(L5_2)

  elseif "getMessages" == L2_2 then

    L3_2 = AwaitCallback

    L4_2 = "instagram:getMessages"

    L5_2 = A0_2.username

    L6_2 = A0_2.page

    L3_2 = L3_2(L4_2, L5_2, L6_2)

    L4_2 = 1

    L5_2 = #L3_2

    L6_2 = 1

    for L7_2 = L4_2, L5_2, L6_2 do

      L8_2 = L3_2[L7_2]

      L9_2 = L3_2[L7_2]

      L9_2 = L9_2.attachments

      if L9_2 then

        L9_2 = json

        L9_2 = L9_2.decode

        L10_2 = L3_2[L7_2]

        L10_2 = L10_2.attachments

        L9_2 = L9_2(L10_2)

      end

      L8_2.attachments = L9_2

    end

    L4_2 = A1_2

    L5_2 = L3_2

    L4_2(L5_2)

  elseif "sendMessage" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:sendMessage"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.message

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "search" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "instagram:search"

    L5_2 = A1_2

    L6_2 = A0_2.query

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  end

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:addLiveMessage"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "instagram:addMessage"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:updateLives"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "instagram:updateLives"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:endLive"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2

  L1_2 = L1_1

  if A0_2 == L1_2 then

    L1_2 = MumbleClearVoiceTargetPlayers

    L2_2 = 1

    L1_2(L2_2)

    L1_2 = 1

    L2_2 = watchingSources

    L2_2 = #L2_2

    L3_2 = 1

    for L4_2 = L1_2, L2_2, L3_2 do

      L5_2 = MumbleSetVolumeOverrideByServerId

      L6_2 = watchingSources

      L6_2 = L6_2[L4_2]

      L7_2 = -1.0

      L5_2(L6_2, L7_2)

      L5_2 = debugprint

      L6_2 = "InstaPic endLive: stopped listening to"

      L7_2 = watchingSources

      L7_2 = L7_2[L4_2]

      L5_2(L6_2, L7_2)

    end

    L1_2 = nil

    L1_1 = L1_2

    L1_2 = {}

    watchingSources = L1_2

  end

  L1_2 = SendReactMessage

  L2_2 = "instagram:liveEnded"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:joinedLive"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = SendReactMessage

  L2_2 = "instagram:joinedLive"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = A0_2.source

  L2_2 = GetPlayerServerId

  L3_2 = PlayerId

  L3_2, L4_2, L5_2, L6_2 = L3_2()

  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)

  if L1_2 == L2_2 then

    return

  end

  L1_2 = watchingSources

  L2_2 = watchingSources

  L2_2 = #L2_2

  L2_2 = L2_2 + 1

  L3_2 = A0_2.source

  L1_2[L2_2] = L3_2

  L1_2 = settings

  if L1_2 then

    L1_2 = L1_2.sound

    if L1_2 then

      L1_2 = L1_2.volume

    end

  end

  if not L1_2 then

    L1_2 = 0.5

  end

  L1_2 = L1_2 / 1

  L2_2 = MumbleAddVoiceTargetPlayerByServerId

  L3_2 = 1

  L4_2 = A0_2.source

  L2_2(L3_2, L4_2)

  L2_2 = MumbleSetVolumeOverrideByServerId

  L3_2 = A0_2.source

  L4_2 = L1_2

  L2_2(L3_2, L4_2)

  L2_2 = debugprint

  L3_2 = "InstaPic joinedLive: started listening to"

  L4_2 = A0_2.source

  L5_2 = "volume:"

  L6_2 = L1_2

  L2_2(L3_2, L4_2, L5_2, L6_2)

end

L3_1(L4_1, L5_1)

L3_1 = AddEventHandler

L4_1 = "lb-phone:settingsUpdated"

function L5_1()

  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L0_2 = L1_1

  if L0_2 then

    L0_2 = watchingSources

    L0_2 = #L0_2

    if 0 ~= L0_2 then

      goto lbl_9

    end

  end

  do return end

  ::lbl_9::

  L0_2 = settings

  if L0_2 then

    L0_2 = L0_2.sound

    if L0_2 then

      L0_2 = L0_2.volume

    end

  end

  if not L0_2 then

    L0_2 = 0.5

  end

  L0_2 = L0_2 / 1

  L1_2 = 1

  L2_2 = watchingSources

  L2_2 = #L2_2

  L3_2 = 1

  for L4_2 = L1_2, L2_2, L3_2 do

    L5_2 = watchingSources

    L5_2 = L5_2[L4_2]

    L6_2 = GetPlayerServerId

    L7_2 = PlayerId

    L7_2, L8_2, L9_2, L10_2 = L7_2()

    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)

    if L5_2 == L6_2 then

    else

      L6_2 = MumbleSetVolumeOverrideByServerId

      L7_2 = L5_2

      L8_2 = L0_2

      L6_2(L7_2, L8_2)

      L6_2 = debugprint

      L7_2 = "InstaPic settingsUpdated: set volume to"

      L8_2 = L0_2

      L9_2 = "for"

      L10_2 = L5_2

      L6_2(L7_2, L8_2, L9_2, L10_2)

    end

  end

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:leftLive"

function L5_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L3_2 = SendReactMessage

  L4_2 = "instagram:leftLive"

  L5_2 = {}

  L5_2.host = A0_2

  L5_2.participant = A1_2

  L3_2(L4_2, L5_2)

  L3_2 = GetPlayerServerId

  L4_2 = PlayerId

  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2()

  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)

  if A2_2 == L3_2 then

    return

  end

  L3_2 = 1

  L4_2 = watchingSources

  L4_2 = #L4_2

  L5_2 = 1

  for L6_2 = L3_2, L4_2, L5_2 do

    L7_2 = watchingSources

    L7_2 = L7_2[L6_2]

    if L7_2 == A2_2 then

      L7_2 = MumbleSetVolumeOverrideByServerId

      L8_2 = A2_2

      L9_2 = -1.0

      L7_2(L8_2, L9_2)

      L7_2 = MumbleRemoveVoiceTargetPlayerByServerId

      L8_2 = 1

      L9_2 = A2_2

      L7_2(L8_2, L9_2)

      L7_2 = debugprint

      L8_2 = "InstaPic leftLive: stopped listening to"

      L9_2 = A2_2

      L7_2(L8_2, L9_2)

      L7_2 = table

      L7_2 = L7_2.remove

      L8_2 = watchingSources

      L9_2 = L6_2

      L7_2(L8_2, L9_2)

      break

    end

  end

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:endCall"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "instagram:endCall"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:updateViewers"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2

  L2_2 = SendReactMessage

  L3_2 = "instagram:updateViewers"

  L4_2 = {}

  L4_2.username = A0_2

  L4_2.viewers = A1_2

  L2_2(L3_2, L4_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:updateProfileData"

function L5_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = debugprint

  L4_2 = "updateProfileData"

  L5_2 = A0_2

  L6_2 = A1_2

  L7_2 = A2_2

  L3_2(L4_2, L5_2, L6_2, L7_2)

  L3_2 = SendReactMessage

  L4_2 = "instagram:updateProfileData"

  L5_2 = {}

  L5_2.username = A0_2

  L5_2.data = A1_2

  L5_2.increment = A2_2

  L3_2(L4_2, L5_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:updatePostData"

function L5_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = debugprint

  L4_2 = "updatePostData"

  L5_2 = A0_2

  L6_2 = A1_2

  L7_2 = A2_2

  L3_2(L4_2, L5_2, L6_2, L7_2)

  L3_2 = SendReactMessage

  L4_2 = "instagram:updatePostData"

  L5_2 = {}

  L5_2.postId = A0_2

  L5_2.data = A1_2

  L5_2.increment = A2_2

  L3_2(L4_2, L5_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:updateCommentLikes"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2

  L2_2 = debugprint

  L3_2 = "updateCommentLikes"

  L4_2 = A0_2

  L5_2 = A1_2

  L2_2(L3_2, L4_2, L5_2)

  L2_2 = SendReactMessage

  L3_2 = "instagram:updateCommentLikes"

  L4_2 = {}

  L4_2.commentId = A0_2

  L4_2.increment = A1_2

  L2_2(L3_2, L4_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:newMessage"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "instagram:newMessage"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:invitedLive"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "instagram:invitedLive"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:removedLive"

function L5_1()

  local L0_2, L1_2

  L0_2 = EndLive

  L0_2()

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:instagram:newPost"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = TriggerEvent

  L2_2 = "lb-phone:instapic:newPost"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1(L4_1, L5_1)

function L3_1()

  local L0_2, L1_2

  L0_2 = L0_1

  if not L0_2 then

    return

  end

  L0_2 = false

  L0_1 = L0_2

  L0_2 = DisableWalkableCam

  L0_2()

  L0_2 = AwaitCallback

  L1_2 = "instagram:endLive"

  L0_2(L1_2)

end

EndLive = L3_1

function L3_1()

  local L0_2, L1_2

  L0_2 = L0_1

  return L0_2

end

IsLive = L3_1

function L3_1()

  local L0_2, L1_2

  L0_2 = L1_1

  return L0_2

end

IsWatchingLive = L3_1

L3_1 = exports

L4_1 = "IsLive"

L5_1 = IsLive

L3_1(L4_1, L5_1)