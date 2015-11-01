FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "email#{i}@mail.com" }
    password "123"
  end

  trait :with_items do
    after(:create) do |user|
      FactoryGirl.create_list :item, 3, :user => user
    end
  end
end