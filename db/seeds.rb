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
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Music.instrument
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(title: title, content: content) }
end

# お気に入りリスト
5.times do |n|
  title = Faker::Music.instrument
  memo  = Faker::Lorem.sentence(5)
  users.each { |user| user.favlists.create!(title: title, memo: memo) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# いいね登録
# user = User.first
# microposts = Micropost.all
# test = microposts[1..50]
# test.each { |micropost| user.likes.create(micropost) }
