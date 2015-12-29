# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |u|
    email = "exampleruser#{u}@fakeemail.com"
    password = '12345678'
    user = User.create!(
        email: email,
        password: password
    )

    20.times do |p|
        article = user.articles.create!(
            description: Faker::Lorem.paragraph
        )
        article.add_tags(Faker::Lorem.words(10).join(' '))
    end
end