FactoryGirl.define do
  
  factory :tag do
    sequence(:name) { |i| "tag#{i}" }
  end

  factory :item do
    user
    sequence(:title) { |i| "Task title #{i}"}
    notes { Forgery(:lorem_ipsum).words(20) }
    done false
    tags { |a| [a.association(:tag), a.association(:tag)] }
  end
end