FactoryBot.define do
  factory :user, class: UserPantauAuth do
    email { Faker::Internet.email }
  end
end
