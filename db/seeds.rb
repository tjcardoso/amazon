# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
8.times do
  Category.create(name: Faker::Commerce.department)
end

categories = Category.all

100.times do
  p = Product.create title:          Faker::Company.bs,
                     description:    Faker::Company.catch_phrase,
                     price:          Faker::Commerce.price,
                     category:       categories.shuffle.first

 10.times do
   random = rand(20)
   if random < 10
     p.reviews.create(body: Faker::StarWars.quote)
   else
     p.reviews.create(body: Faker::ChuckNorris.fact)
   end
 end

end



puts Cowsay.say("Generated 100 questions!")
