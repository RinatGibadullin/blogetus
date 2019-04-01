FactoryBot.define do
  factory :user do
    email { generate(:email) }
    password "123456"
    password_confirmation "123456"

    confirmed_at { Time.zone.now }
  end

  trait :not_confirmed do
    confirmed_at nil

    after(:create) do |user|
      user.update(confirmation_sent_at: 3.days.ago)
    end
  end
end
