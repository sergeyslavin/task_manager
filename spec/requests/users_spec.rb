require 'rails_helper'

describe "Users page", type: :feature do

  context "from admin" do

    before(:each) do
      admin = create(:admin)
      login_as(admin, :scope => :user)
    end

    let!(:users) { create_list(:just_user, 3) }

    it "check admin access to users" do
      visit(users_path)
      expect(page).to have_text("Users")
    end

    it "check user role on page" do
      visit(users_path + "/#{users[0].id}")
      expect(page).to have_text("Role: user")
    end

  end

  context "from user" do
    
    before(:all) do
      user = create(:user)
      login_as(user, :scope => :user)
    end

    it "should redirect from users page" do
      visit(users_path)
      expect(page.current_path).to eq(items_path)
    end

    after(:all) { logout(:user) }
  end

end