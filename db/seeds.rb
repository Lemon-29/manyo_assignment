# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: "test@test.com", name: "test_user", password: "password")

10.times do |n|
  Task.create(
      status_name: "status_name#{n}",
      title: "task_title#{n}",
      content: "task_content#{n}",
      status: rand(1..3),
      priority: rand(1..3),
      expired_at: Date.new,
      user_id: user.id
    )
end

Label.create!(
  [
    {name: 'Zelda'},
    {name: 'Final Fantasy'},
    {name: 'Dragon Quest'},
    {name: 'Splatoon'},
    {name: 'Bullet Voyage'},
    {name: 'Among Us'},
    {name: 'Mini Metro'},
    {name: 'Mario Odessay'},
    {name: 'Mario World'},
    {name: 'Star Ocean'}
  ]
) 