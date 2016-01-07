# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = []

20.times do |u|
    if u == 0
        email = "kq.viet@gmail.com"
    else
        email = "exampleruser#{u}@fakeemail.com"
    end
    password = '12345678'
    user = User.create!(
        email: email,
        password: password
    )

    20.times do |p|
        article = user.articles.create!(
            description: Faker::Lorem.paragraph
        )
        article.create_tags_and_relationships(Faker::Lorem.sentence(23))
    end

    users << user
end

users.each do |user|
    followed_index = rand(0..users.length-1)
    user.follow!(users[followed_index].id)
end