# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  Intrusion.create(description: Faker::Lorem.paragraph(2))
end

100.times do
  Tag.create(name: Faker::Lorem.word)
end

1000.times do
  Intrusion.find(1 + rand(100)).tags << Tag.find(1 + rand(100))
end