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

            # 「音声」
            # 吉田　最愛、家族になろうよ
            # 髙井　lemon, 大丈夫
            #
            # 「音源」
            # 祖堅　lemon, 大丈夫
            # 前廣　最愛, 家族になろうよ

# user = User.second
# 10.times do
#   title = Faker::Music.instrument
#   content = Faker::Lorem.sentence(5)
#   user.microposts.create!(title: title, content: content)
# end

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
micropost1 = microposts[57]
micropost2 = microposts[140]
micropost3 = microposts[245]
user1.each { |user| user.likes.create!(micropost_id: micropost1.id) }
user2.each { |user| user.likes.create!(micropost_id: micropost2.id) }
user3.each { |user| user.likes.create!(micropost_id: micropost3.id) }
