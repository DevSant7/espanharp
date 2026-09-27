local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1

function L0_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  if not A0_2 then

    L1_2 = {}

    return L1_2

  end

  L1_2 = A0_2.attachments

  L2_2 = type

  L3_2 = A0_2.attachments

  L2_2 = L2_2(L3_2)

  if "string" == L2_2 then

    L2_2 = json

    L2_2 = L2_2.decode

    L3_2 = A0_2.attachments

    L2_2 = L2_2(L3_2)

    L1_2 = L2_2

  end

  if L1_2 then

    L2_2 = type

    L3_2 = L1_2

    L2_2 = L2_2(L3_2)

    if "table" == L2_2 then

      L2_2 = table

      L2_2 = L2_2.type

      L3_2 = L1_2

      L2_2 = L2_2(L3_2)

      if "array" == L2_2 then

        goto lbl_35

      end

    end

    L1_2 = nil

    L2_2 = debugprint

    L3_2 = "Malformed attachments for birdy post"

    L4_2 = A0_2.id

    L2_2(L3_2, L4_2)

  end

  ::lbl_35::

  L2_2 = {}

  L3_2 = {}

  L4_2 = A0_2.profile_image

  L3_2.profile_picture = L4_2

  L4_2 = A0_2.display_name

  L3_2.name = L4_2

  L4_2 = A0_2.username

  L3_2.username = L4_2

  L4_2 = A0_2.verified

  L4_2 = true == L4_2

  L3_2.verified = L4_2

  L4_2 = A0_2.private

  L4_2 = true == L4_2

  L3_2.private = L4_2

  L2_2.user = L3_2

  L3_2 = {}

  L4_2 = A0_2.id

  L3_2.id = L4_2

  L4_2 = A0_2.content

  L3_2.content = L4_2

  L4_2 = A0_2.timestamp

  L3_2.date_created = L4_2

  L4_2 = A0_2.reply_count

  L3_2.replies = L4_2

  L4_2 = A0_2.like_count

  L3_2.likes = L4_2

  L4_2 = A0_2.retweet_count

  L3_2.retweets = L4_2

  L3_2.attachments = L1_2

  L4_2 = A0_2.reply_to

  L3_2.replyToId = L4_2

  L4_2 = A0_2.liked

  L4_2 = true == L4_2

  L3_2.liked = L4_2

  L4_2 = A0_2.retweeted

  L4_2 = true == L4_2

  L3_2.retweeted = L4_2

  L4_2 = A0_2.replyToAuthor

  L3_2.replyToAuthor = L4_2

  L4_2 = A0_2.retweeted_by_display_name

  L3_2.retweetedByName = L4_2

  L4_2 = A0_2.retweeted_by_username

  L3_2.retweetedByUsername = L4_2

  L2_2.tweet = L3_2

  return L2_2

end

function L1_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2

  L2_2 = AwaitCallback

  L3_2 = "birdy:getPosts"

  L4_2 = A0_2

  L5_2 = A1_2

  L2_2 = L2_2(L3_2, L4_2, L5_2)

  L3_2 = {}

  L4_2 = 1

  L5_2 = #L2_2

  L6_2 = 1

  for L7_2 = L4_2, L5_2, L6_2 do

    L8_2 = L0_1

    L9_2 = L2_2[L7_2]

    L8_2 = L8_2(L9_2)

    L3_2[L7_2] = L8_2

  end

  L4_2 = math

  L4_2 = L4_2.random

  L5_2 = 3

  L6_2 = 6

  L4_2 = L4_2(L5_2, L6_2)

  L5_2 = #L3_2

  if L4_2 >= L5_2 then

    L5_2 = #L3_2

    L4_2 = L5_2 - 1

  end

  L5_2 = Config

  L5_2 = L5_2.PromoteBirdy

  if L5_2 then

    L5_2 = L5_2.Enabled

  end

  if L5_2 then

    L5_2 = #L2_2

    if L5_2 > 1 then

      L5_2 = AwaitCallback

      L6_2 = "birdy:getRandomPromoted"

      L5_2 = L5_2(L6_2)

      if L5_2 then

        L6_2 = L0_1

        L7_2 = L5_2

        L6_2 = L6_2(L7_2)

        L5_2 = L6_2

        L6_2 = L5_2.tweet

        L6_2.promoted = true

        L6_2 = table

        L6_2 = L6_2.insert

        L7_2 = L3_2

        L8_2 = L4_2

        L9_2 = L5_2

        L6_2(L7_2, L8_2, L9_2)

      end

    end

  end

  return L3_2

end

L2_1 = {}

L3_1 = "login"

L4_1 = "toggleFollow"

L5_1 = "toggleLike"

L6_1 = "toggleRetweet"

L7_1 = "sendMessage"

L2_1[1] = L3_1

L2_1[2] = L4_1

L2_1[3] = L5_1

L2_1[4] = L6_1

L2_1[5] = L7_1

L3_1 = RegisterNUICallback

L4_1 = "Twitter"

function L5_1(A0_2, A1_2)

  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2

  L2_2 = currentPhone

  if not L2_2 then

    return

  end

  L2_2 = A0_2.action

  L3_2 = debugprint

  L4_2 = "Birdy:"

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

  if "createAccount" == L2_2 then

    L3_2 = A0_2.data

    L4_2 = TriggerCallback

    L5_2 = "birdy:createAccount"

    L6_2 = A1_2

    L7_2 = L3_2.name

    L8_2 = L3_2.username

    L9_2 = L3_2.password

    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)

  elseif "changePassword" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:changePassword"

    L5_2 = A1_2

    L6_2 = A0_2.oldPassword

    L7_2 = A0_2.newPassword

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "deleteAccount" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:deleteAccount"

    L5_2 = A1_2

    L6_2 = A0_2.password

    L3_2(L4_2, L5_2, L6_2)

  elseif "login" == L2_2 then

    L3_2 = A0_2.data

    L4_2 = TriggerCallback

    L5_2 = "birdy:login"

    L6_2 = A1_2

    L7_2 = L3_2.username

    L8_2 = L3_2.password

    L4_2(L5_2, L6_2, L7_2, L8_2)

  elseif "isLoggedIn" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:isLoggedIn"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "sendTweet" == L2_2 then

    L3_2 = A0_2.data

    L4_2 = TriggerCallback

    L5_2 = "birdy:sendPost"

    L6_2 = A1_2

    L7_2 = L3_2.content

    L8_2 = L3_2.attachments

    L9_2 = L3_2.replyTo

    L10_2 = L3_2.hashtags

    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)

  elseif "updateProfile" == L2_2 then

    L3_2 = A0_2.data

    L4_2 = TriggerCallback

    L5_2 = "birdy:updateProfile"

    L6_2 = A1_2

    L7_2 = L3_2

    L4_2(L5_2, L6_2, L7_2)

  elseif "searchAccounts" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:searchAccounts"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3

      L1_3 = {}

      L2_3 = 1

      L3_3 = #A0_3

      L4_3 = 1

      for L5_3 = L2_3, L3_3, L4_3 do

        L6_3 = A0_3[L5_3]

        L7_3 = {}

        L8_3 = L6_3.username

        L7_3.username = L8_3

        L8_3 = L6_3.display_name

        L7_3.name = L8_3

        L8_3 = L6_3.profile_image

        L7_3.profile_picture = L8_3

        L8_3 = L6_3.verified

        L8_3 = true == L8_3

        L7_3.verified = L8_3

        L8_3 = L6_3.private

        L8_3 = true == L8_3

        L7_3.private = L8_3

        L1_3[L5_3] = L7_3

      end

      L2_3 = A1_2

      L3_3 = L1_3

      L2_3(L3_3)

    end

    L6_2 = A0_2.query

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "searchTweets" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:searchTweets"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3

      L1_3 = {}

      L2_3 = 1

      L3_3 = #A0_3

      L4_3 = 1

      for L5_3 = L2_3, L3_3, L4_3 do

        L6_3 = L0_1

        L7_3 = A0_3[L5_3]

        L6_3 = L6_3(L7_3)

        L1_3[L5_3] = L6_3

      end

      L2_3 = A1_2

      L3_3 = L1_3

      L2_3(L3_3)

    end

    L6_2 = A0_2.query

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getProfile" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getProfile"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3

      if not A0_3 then

        L1_3 = debugprint

        L2_3 = "Birdy: failed to get profile"

        L3_3 = A0_2.data

        L3_3 = L3_3.username

        L1_3(L2_3, L3_3)

        L1_3 = A1_2

        return L1_3()

      end

      L1_3 = A0_3.pinnedTweet

      if L1_3 then

        L1_3 = L0_1

        L2_3 = A0_3.pinnedTweet

        L1_3 = L1_3(L2_3)

        A0_3.pinnedTweet = L1_3

      end

      L1_3 = A1_2

      L2_3 = A0_3

      L1_3(L2_3)

    end

    L6_2 = A0_2.data

    L6_2 = L6_2.username

    L3_2(L4_2, L5_2, L6_2)

  elseif "getFollowers" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getData"

    L5_2 = A1_2

    L6_2 = "followers"

    L7_2 = A0_2.data

    L7_2 = L7_2.username

    L8_2 = A0_2.data

    L8_2 = L8_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "getFollowing" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getData"

    L5_2 = A1_2

    L6_2 = "following"

    L7_2 = A0_2.data

    L7_2 = L7_2.username

    L8_2 = A0_2.data

    L8_2 = L8_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "getLikes" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getData"

    L5_2 = A1_2

    L6_2 = "likes"

    L7_2 = A0_2.data

    L7_2 = L7_2.tweet_id

    L8_2 = A0_2.data

    L8_2 = L8_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "getRetweeters" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getData"

    L5_2 = A1_2

    L6_2 = "retweeters"

    L7_2 = A0_2.data

    L7_2 = L7_2.tweet_id

    L8_2 = A0_2.data

    L8_2 = L8_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "getTweets" == L2_2 then

    L3_2 = A0_2.filter

    if not L3_2 then

      L3_2 = A0_2.filters

    end

    A0_2.filter = L3_2

    L3_2 = A0_2.filter

    if L3_2 then

      L3_2 = next

      L4_2 = A0_2.filter

      L3_2 = L3_2(L4_2)

      if nil == L3_2 then

        A0_2.filter = nil

      end

    end

    L3_2 = A1_2

    L4_2 = L1_1

    L5_2 = A0_2.filter

    L6_2 = A0_2.page

    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L4_2(L5_2, L6_2)

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)

  elseif "getTweet" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getPost"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3

      L1_3 = A1_2

      L2_3 = L0_1

      L3_3 = A0_3

      L2_3, L3_3 = L2_3(L3_3)

      L1_3(L2_3, L3_3)

    end

    L6_2 = A0_2.tweetId

    L3_2(L4_2, L5_2, L6_2)

  elseif "getAuthor" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getAuthor"

    L5_2 = A1_2

    L6_2 = A0_2.tweetId

    L3_2(L4_2, L5_2, L6_2)

  elseif "toggleFollow" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:toggleFollow"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L6_2 = L6_2.username

    L7_2 = A0_2.data

    L7_2 = L7_2.following

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "toggleNotifications" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:toggleNotifications"

    L5_2 = A1_2

    L6_2 = A0_2.data

    L6_2 = L6_2.username

    L7_2 = A0_2.data

    L7_2 = L7_2.toggle

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "toggleLike" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:toggleInteraction"

    L5_2 = A1_2

    L6_2 = "like"

    L7_2 = A0_2.tweet_id

    L8_2 = A0_2.liked

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "toggleRetweet" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:toggleInteraction"

    L5_2 = A1_2

    L6_2 = "retweet"

    L7_2 = A0_2.tweet_id

    L8_2 = A0_2.retweeted

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "deleteTweet" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:deletePost"

    L5_2 = A1_2

    L6_2 = A0_2.tweet_id

    L3_2(L4_2, L5_2, L6_2)

  elseif "promoteTweet" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:promotePost"

    L5_2 = A1_2

    L6_2 = A0_2.tweet_id

    L3_2(L4_2, L5_2, L6_2)

  elseif "sendMessage" == L2_2 then

    A0_2 = A0_2.data

    L3_2 = TriggerCallback

    L4_2 = "birdy:sendMessage"

    L5_2 = A1_2

    L6_2 = A0_2.recipient

    L7_2 = A0_2.content

    L8_2 = A0_2.attachments

    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)

  elseif "getMessages" == L2_2 then

    A0_2 = A0_2.data

    L3_2 = TriggerCallback

    L4_2 = "birdy:getMessages"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3

      L1_3 = 1

      L2_3 = #A0_3

      L3_3 = 1

      for L4_3 = L1_3, L2_3, L3_3 do

        L5_3 = A0_3[L4_3]

        L6_3 = A0_3[L4_3]

        L6_3 = L6_3.attachments

        if L6_3 then

          L6_3 = json

          L6_3 = L6_3.decode

          L7_3 = A0_3[L4_3]

          L7_3 = L7_3.attachments

          L6_3 = L6_3(L7_3)

        end

        L5_3.attachments = L6_3

      end

      L1_3 = A1_2

      L2_3 = A0_3

      L1_3(L2_3)

    end

    L6_2 = A0_2.username

    L7_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2, L7_2)

  elseif "getRecentMessages" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getRecentMessages"

    L5_2 = A1_2

    L6_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2)

  elseif "signOut" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:signOut"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "getNotifications" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getNotifications"

    function L5_2(A0_3)

      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3

      L1_3 = pairs

      L2_3 = A0_3.notifications

      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3)

      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do

        L7_3 = L6_3.attachments

        if L7_3 then

          L7_3 = json

          L7_3 = L7_3.decode

          L8_3 = L6_3.attachments

          L7_3 = L7_3(L8_3)

          L6_3.attachments = L7_3

        end

      end

      L1_3 = A1_2

      L2_3 = A0_3

      L1_3(L2_3)

    end

    L6_2 = A0_2.page

    L3_2(L4_2, L5_2, L6_2)

  elseif "getRecentHashtags" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getRecentHashtags"

    L5_2 = A1_2

    L3_2(L4_2, L5_2)

  elseif "pinTweet" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:pinPost"

    L5_2 = A1_2

    L6_2 = A0_2.toggle

    if L6_2 then

      L6_2 = A0_2.tweet_id

    end

    L3_2(L4_2, L5_2, L6_2)

  elseif "getFollowRequests" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:getFollowRequests"

    L5_2 = A1_2

    L6_2 = A0_2.page

    if not L6_2 then

      L6_2 = 0

    end

    L3_2(L4_2, L5_2, L6_2)

  elseif "handleFollowRequest" == L2_2 then

    L3_2 = TriggerCallback

    L4_2 = "birdy:handleFollowRequest"

    L5_2 = A1_2

    L6_2 = A0_2.username

    L7_2 = A0_2.accept

    L3_2(L4_2, L5_2, L6_2, L7_2)

  end

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:twitter:updateTweetData"

function L5_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = debugprint

  L4_2 = "updateTweetData"

  L5_2 = A0_2

  L6_2 = A1_2

  L7_2 = A2_2

  L3_2(L4_2, L5_2, L6_2, L7_2)

  L3_2 = SendReactMessage

  L4_2 = "twitter:updateTweetData"

  L5_2 = {}

  L5_2.tweetId = A0_2

  L5_2.data = A1_2

  L5_2.increment = A2_2

  L3_2(L4_2, L5_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:twitter:updateProfileData"

function L5_1(A0_2, A1_2, A2_2)

  local L3_2, L4_2, L5_2, L6_2, L7_2

  L3_2 = debugprint

  L4_2 = "updateProfileData"

  L5_2 = A0_2

  L6_2 = A1_2

  L7_2 = A2_2

  L3_2(L4_2, L5_2, L6_2, L7_2)

  L3_2 = SendReactMessage

  L4_2 = "twitter:updateProfileData"

  L5_2 = {}

  L5_2.username = A0_2

  L5_2.data = A1_2

  L5_2.increment = A2_2

  L3_2(L4_2, L5_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:twitter:newMessage"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2

  L1_2 = SendReactMessage

  L2_2 = "twitter:newMessage"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

end

L3_1(L4_1, L5_1)

L3_1 = RegisterNetEvent

L4_1 = "phone:twitter:newtweet"

function L5_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2

  L1_2 = TriggerEvent

  L2_2 = "lb-phone:birdy:newPost"

  L3_2 = A0_2

  L1_2(L2_2, L3_2)

  L1_2 = SendReactMessage

  L2_2 = "twitter:newTweet"

  L3_2 = L0_1

  L4_2 = A0_2

  L3_2, L4_2 = L3_2(L4_2)

  L1_2(L2_2, L3_2, L4_2)

end

L3_1(L4_1, L5_1)

function L3_1(A0_2)

  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2

  L2_2 = L2_2(L3_2)

  L2_2 = "table" == L2_2

  L3_2 = "Expected table for data, got "

  L4_2 = type

  L5_2 = A0_2

  L4_2 = L4_2(L5_2)

  L3_2 = L3_2 .. L4_2

  L1_2(L2_2, L3_2)

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2.content

  L2_2 = L2_2(L3_2)

  L2_2 = "string" == L2_2

  L3_2 = "Expected string for data.content, got "

  L4_2 = type

  L5_2 = A0_2.content

  L4_2 = L4_2(L5_2)

  L3_2 = L3_2 .. L4_2

  L1_2(L2_2, L3_2)

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2.attachments

  L2_2 = L2_2(L3_2)

  L2_2 = "table" == L2_2

  L3_2 = "Expected table / nil for data.attachments, got "

  L4_2 = type

  L5_2 = A0_2.attachments

  L4_2 = L4_2(L5_2)

  L3_2 = L3_2 .. L4_2

  L1_2(L2_2, L3_2)

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2.replyTo

  L2_2 = L2_2(L3_2)

  L2_2 = "string" == L2_2

  L3_2 = "Expected string / nil for data.replyTo, got "

  L4_2 = type

  L5_2 = A0_2.replyTo

  L4_2 = L4_2(L5_2)

  L3_2 = L3_2 .. L4_2

  L1_2(L2_2, L3_2)

  L1_2 = assert

  L2_2 = type

  L3_2 = A0_2.hashtags

  L2_2 = L2_2(L3_2)

  L2_2 = "table" == L2_2

  L3_2 = "Expected table / nil for data.hashtags, got "

  L4_2 = type

  L5_2 = A0_2.hashtags

  L4_2 = L4_2(L5_2)

  L3_2 = L3_2 .. L4_2

  L1_2(L2_2, L3_2)

  L1_2 = CanInteract

  L1_2 = L1_2()

  if not L1_2 then

    return

  end

  L1_2 = AwaitCallback

  L2_2 = "birdy:sendPost"

  L3_2 = A0_2.content

  L4_2 = A0_2.attachments

  L5_2 = A0_2.replyTo

  L6_2 = A0_2.hashtags

  return L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)

end

SendTweet = L3_1

L3_1 = exports

L4_1 = "SendTweet"

L5_1 = SendTweet

L3_1(L4_1, L5_1)

L3_1 = exports

L4_1 = "PostBirdy"

L5_1 = SendTweet

L3_1(L4_1, L5_1)