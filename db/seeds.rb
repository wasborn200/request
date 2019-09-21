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
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               unique_name: "example_#{n+1}")
end

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Music.instrument #　instrumentは楽器だから曲名を探さないといけない
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(title: title, content: content) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# お気に入り
user.favlists.create!(title: "favorite", content: "test")
