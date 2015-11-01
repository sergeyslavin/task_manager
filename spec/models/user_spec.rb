require 'rails_helper'

describe User do

  let(:users) { create_list(:user, 3, :with_items) }
  let(:first_user) { users.first }

  context ".user list" do
    it "check user list without admin" do
      expect(User.users_without_me(first_user)).to have(2).items
    end
  end

  context ".user actions related to items and tags" do
    it "check actual tags craeted by user" do
      expect(first_user.actual_tags).to have(first_user.items.count * 2).items #always should be 2 tags per item
    end

    it "should be empty array of actual tags" do
      user_without_items = create(:user)
      expect(user_without_items.actual_tags).to be_empty
    end
  end
  
end