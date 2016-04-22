FactoryGirl.define do
  factory :product do
    title        {Faker::StarWars.vehicle}
    description  {Faker::Hipster.paragraph}
    price        {Faker::Commerce.price}
  end
end
