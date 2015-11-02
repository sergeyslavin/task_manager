require 'rails_helper'

describe "Items page", js: true do
  
  before(:each) do
    @user = create(:just_user, :with_items)
    login_as(@user, :scope => :user)
  end

  context "Items list" do
    before(:each) do
      visit items_path
    end

    let(:first_item) { @user.items.first }

    it "is present tags list on page" do
      expect(page).to have_text("Tags: " + first_item.tags.map(&:name).join(", "))
    end

    it "check search form" do
      page.fill_in 'search_title', :with => first_item.title
      page.find(".form-search input[type='submit']").click
      expect(page.all("#sortable tr").count).to eq(1)
    end
  end

  context "Item" do
    context ".create" do

      before(:each) do
        visit new_item_path
      end

      it "should work tags input" do
        input_text_list = []

        3.times { |i|
          cur_text = "test#{i}"
          find(:css, ".bootstrap-tagsinput input").set("#{cur_text},")
          input_text_list << cur_text
        }

        result_tags = page.all(".bootstrap-tagsinput span").map(&:text)

        expect(result_tags).to include(*input_text_list)
      end

    end
  end
end