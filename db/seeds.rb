User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar")
User.create!(name:  "Tino ne",
             email: "tinobia@gmail.com",
             password: "tinobia112",
             password_confirmation: "tinobia112",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name, email: email, password: password, password_confirmation: password)
end
