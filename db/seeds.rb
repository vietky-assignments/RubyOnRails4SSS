# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

words = Faker::Lorem.words(30).uniq
hash_tags = []
puts words
words.length.times do |h|
    hash_tags << HashTag.create!(:name => words[h])
end

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
        article.articles_hash_tags_relationships.create!(:hash_tag_id => hash_tags[rand(0..hash_tags.length-1)].id)
    end
end