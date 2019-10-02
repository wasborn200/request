# 簡単ログインユーザー
User.create!(name:  "簡単ログインユーザー",
             email: "sample-1@collabrequest.com",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now,
             unique_name: "sample_1")

# 投稿機能チェック用ユーザー

User.create!(name:  "吉田",
            email: "sample-2@collabrequest.com",
            password:              "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now,
            unique_name: "yoshida")

User.create!(name:  "高井",
            email: "sample-3@collabrequest.com",
            password:              "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now,
            unique_name: "hiroshi")

User.create!(name:  "前廣",
            email: "sample-4@collabrequest.com",
            password:              "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now,
            unique_name: "maehiro")

User.create!(name:  "祖堅",
            email: "sample-5@collabrequest.com",
            password:              "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now,
            unique_name: "soken")

# 投稿チェック用素材

user = User.second
title1 = "「最愛」を歌ってみました。"
title2 = "「家族になろうよ」を歌ってみました。"
content1 = "福山雅治の「最愛」を歌ってみました。※サイト管理人が音声サンプルとして録音したデータです。
            聞き苦しいかと思いますので音量にご注意ください。"
content2 = "福山雅治の「家族になろうよ」を歌ってみました。※サイト管理人が音声サンプルとして録音したデータです。
            聞き苦しいかと思いますので音量にご注意ください。"
picture1 = open("#{Rails.root}/db/fixtures/saiai_voice.mp3")
picture2 = open("#{Rails.root}/db/fixtures/kazoku_voice.mp3")
user.microposts.create!(title: title1, content: content1, picture: picture1)
user.microposts.create!(title: title2, content: content2, picture: picture2)

user = User.third
title3 = "「lemon」を歌ってみました。"
title4 = "「大丈夫」を歌ってみました。"
content3 = "米津玄師の「lemon」を歌ってみました。※サイト管理人が音声サンプルとして録音したデータです。
            聞き苦しいかと思いますので音量にご注意ください。"
content4 = "Radwimpsの「大丈夫」を歌ってみました。※サイト管理人が音声サンプルとして録音したデータです。
            聞き苦しいかと思いますので音量にご注意ください。"
picture3 = open("#{Rails.root}/db/fixtures/lemon_voice.mp3")
picture4 = open("#{Rails.root}/db/fixtures/daijyoubu_voice.mp3")
user.microposts.create!(title: title3, content: content3, picture: picture3)
user.microposts.create!(title: title4, content: content4, picture: picture4)

user = User.fourth
title5 = "「最愛」を演奏してみました。"
title6 = "「家族になろうよ」を演奏してみました。"
content5 = "福山雅治の「最愛」を演奏しました。※こちらはカラオケ音源データになります。"
content6 = "福山雅治の「家族になろうよ」を演奏しました。※こちらはカラオケ音源データになります。"
picture5 = open("#{Rails.root}/db/fixtures/saiai_instrumental.mp3")
picture6 = open("#{Rails.root}/db/fixtures/kazoku_instrumental.mp3")
user.microposts.create!(title: title5, content: content5, picture: picture5)
user.microposts.create!(title: title6, content: content6, picture: picture6)

user = User.fifth
title7 = "「lemon」を演奏してみました。"
title8 = "「大丈夫」を演奏してみました。"
content7 = "米津玄師の「lemon」を演奏しました。※こちらはカラオケ音源データになります。"
content8 = "Radwimpsの「大丈夫」を演奏しました。※こちらはカラオケ音源データになります。"
picture7 = open("#{Rails.root}/db/fixtures/lemon_instrumental.mp3")
picture8 = open("#{Rails.root}/db/fixtures/daijyoubu_instrumental.mp3")
user.microposts.create!(title: title7, content: content7, picture: picture7)
user.microposts.create!(title: title8, content: content8, picture: picture8)

# 投稿チェック用コラボ

# 9
user = User.third
title = "「大丈夫」をコラボしてみました。"
content = "Radwimpsの「大丈夫」を祖堅さんの音源とコラボさせてもらいました。※サイト管理人がサンプルとして録音したデータを含んでおります。
            聞き苦しいかと思いますので音量にご注意ください。"
picture = open("#{Rails.root}/db/fixtures/daijyoubu_music.mp3")
collablist = "4 8"
user.microposts.create!(title: title, content: content, picture: picture, collablist: collablist)

# 10
user = User.second
title = "「最愛」をコラボしてみました。"
content = "福山雅治の「最愛」を前廣さんの音源とコラボさせてもらいました。※サイト管理人が音声サンプルとして録音したデータを含んでおります。
            聞き苦しいかと思いますので音量にご注意ください。"
picture = open("#{Rails.root}/db/fixtures/saiai_music.mp3")
collablist = "1 5"
user.microposts.create!(title: title, content: content, picture: picture, collablist: collablist)

# 11
user = User.fourth
title = "「lemon」をコラボしてみました。"
content = "米津玄師の「lemon」を高井さんの音声とコラボさせてもらいました。※サイト管理人がサンプルとして録音したデータを含んでおります。
            聞き苦しいかと思いますので音量にご注意ください。"
picture = open("#{Rails.root}/db/fixtures/lemon_music.mp3")
collablist = "3 7"
user.microposts.create!(title: title, content: content, picture: picture, collablist: collablist)

# 12
user = User.second
title = "「家族になろうよ」をコラボしてみました。"
content = "福山雅治の「家族になろうよ」を吉田さんの音声とコラボさせてもらいました。※サイト管理人が音声サンプルとして録音したデータを含んでおります。
            聞き苦しいかと思いますので音量にご注意ください。"
picture = open("#{Rails.root}/db/fixtures/kazoku_music.mp3")
collablist = "2 6"
user.microposts.create!(title: title, content: content, picture: picture, collablist: collablist)

# 「音声」
# 吉田　最愛、家族になろうよ
# 髙井　lemon, 大丈夫
#
# 「音源」
# 祖堅　lemon, 大丈夫
# 前廣　最愛, 家族になろうよ

# その他ユーザー
99.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+6}@collabrequest.com"
  password = "password"
  unique_name = "example_#{n+6}"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               unique_name: unique_name )
end

# 管理者

User.create!(name:  "管理者",
             email: "admin@collabrequest.com",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             unique_name: "admin_1")

# 素材投稿
user = User.first
10.times do
  title = Faker::Music.instrument
  content = Faker::Lorem.sentence(5)
  user.microposts.create!(title: title, content: content)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Music.instrument
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(title: title, content: content) }
end

# コラボ投稿
20.times do |n|
  title = Faker::Music.instrument
  content = Faker::Lorem.sentence(5)
  collablist = "#{n+1} #{n+3}"
  users.each { |user| user.microposts.create!(title: title, content: content, collablist: collablist) }
end

# コラボリスト
5.times do |n|
  title = Faker::Music.instrument
  memo  = Faker::Lorem.sentence(5)
  users.each { |user| user.favlists.create!(title: title, memo: memo) }
end

# リレーションシップ
users = User.all
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# 自分の投稿に対してのいいね
user4 = users[40..42]
user5 = users[12..18]
user6 = users[34..35]
user4.each { |user| user.likes.create!(micropost_id: 1) }
user5.each { |user| user.likes.create!(micropost_id: 2) }
user6.each { |user| user.likes.create!(micropost_id: 3) }

# いいねランキング
microposts = Micropost.all
user1 = users[1..43]
user2 = users[1..29]
user3 = users[1..17]
micropost1 = microposts[11]
micropost2 = microposts[9]
micropost3 = microposts[10]
user1.each { |user| user.likes.create!(micropost_id: 11) }
user2.each { |user| user.likes.create!(micropost_id: 10) }
user3.each { |user| user.likes.create!(micropost_id: 9) }
