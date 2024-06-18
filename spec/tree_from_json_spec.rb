require 'spec_helper'

describe Nutmeg::TreeFromJson do

  before(:each) do
    data = File.open([Dir.pwd, "/spec/files/tree.json"].join).read
    @tree_from_json = Nutmeg::TreeFromJson.new(data)
  end

  describe "#initialize" do
    it "verifies initialize works correctly" do
      expect(@tree_from_json.tree.class).to eq(Nutmeg::TagTree)
      expect(([:tag_id, :tag, :slug, :name, :layout, :tag_image, :tag_image_file_name, :hero_image, :hero_image_file_name] - @tree_from_json.tree.original.each_leaf.first.content.keys).empty?).to eq(true)
    end
  end
end
