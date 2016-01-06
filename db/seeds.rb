# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#words = Faker::Lorem.words(30).uniq

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
        article.create_tags_and_relationships(Faker::Lorem.sentence(7))
#        hash_tag = HashTag.find_or_create_by!(name: words[rand(0..words.length-1)])
#        article.articles_hash_tags_relationships.create!(:hash_tag_id => hash_tag.id)
    end
end