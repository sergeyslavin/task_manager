require 'rails_helper'

describe Item do

  context ".search_by" do

    before{ create_list(:item, 3) }

    it "check search only with title" do
      search_result = Item.search_by(title: "Task title", tags: [])
      expect(search_result).to have(3).items
    end

    it "check search only with tags" do
      search_result = Item.search_by(title: nil, tags: [2, 3])
      expect(search_result).to have(2).items
    end

    it "check search with title and tags" do
      search_result = Item.search_by(title: "Task title", tags: [2, 3])
      expect(search_result).to have(2).items
    end

    it "should be empty result" do
      search_result = Item.search_by(title: "Wrong text", tags: [])
      expect(search_result).to be_empty
    end

    it "should be return all values" do
      search_result = Item.search_by(title: nil, tags: [])
      expect(search_result).to have(Item.all.size).items
    end

  end

end