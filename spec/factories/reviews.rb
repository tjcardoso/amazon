FactoryGirl.define do
  factory :review do
    association :product, factory: :product
    association :user, factory: :user

    body        { Faker::StarWars.quote}
    stars       { rand(5) }
  end
end
