FactoryGirl.define do

  factory :role do
    name "user"
  end

  factory :user do
    sequence(:email) { |i| "email#{i}@mail.com" }
    password "123"
    last_sign_in_at Time.now.utc

    factory :admin do
      association :role, factory: :role, name: "admin"
    end

    factory :just_user do
      association :role, factory: :role, name: "user"
    end
  end

  trait :with_items do
    after(:create) do |user|
      FactoryGirl.create_list :item, 3, :user => user
    end
  end

end