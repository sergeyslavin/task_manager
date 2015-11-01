require 'rails_helper'

describe ItemsHelper do
  context "#print_tags" do
    
    let(:item) { create(:item) }

    context "should be tags separated by comma" do
      it "without params" do
        tags_list = print_tags(item.tags)
        expect(tags_list).to eq(item.tags.map(&:name).join(", "))
      end

      it "with link eql false" do
        tags_list = print_tags(item.tags, link: false)
        expect(tags_list).to eq(item.tags.map(&:name).join(", "))
      end
    end

    it "with param link eql true and should be returns with link" do
      tags_list = print_tags(item.tags, link: true)
      expect(tags_list).to match(/\<a href/)
    end    
  end
end