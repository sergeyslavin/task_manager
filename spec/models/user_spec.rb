require 'rails_helper'
require "cancan/matchers"

describe User do
  context "users methods" do
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

  context "abilities" do
    let(:admin) { create(:admin) }
    let(:just_user) { create(:just_user) }
    let(:item) { create(:item) }

    context "admin" do
      let(:ability_admin) { Ability.new(admin) }

      it "admin can access to another users" do
        expect(ability_admin).to be_able_to [:read, :write], User.new
      end

      it "admin cannot read items which is not owned" do
        expect(ability_admin).to_not be_able_to [:read, :write], item
      end  
    end

    context "user" do
      let(:ability_just_user) { Ability.new(just_user) }

      it "user cannot access to other users" do
        expect(ability_just_user).to_not be_able_to :destroy, admin
      end

      it "admin cannot read items which is not owned" do
        expect(ability_just_user).to_not be_able_to [:read, :write], item
      end 
    end
  end
end