User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             unique_name: "example_user")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  unique_name = "example_#{n+1}"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               unique_name: unique_name )
end

# マイクロポスト
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

# コラボリスト
20.times do |n|
  title = Faker::Music.instrument
  content = Faker::Lorem.sentence(5)
  collablist = "#{n+1} #{n+3}"
  users.each { |user| user.microposts.create!(title: title, content: content, collablist: collablist) }
end

# お気に入りリスト
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
