require 'spec_helper'

describe Nutmeg::TreeFromJson do

  before(:each) do
    data = JSON.load(File.open([Dir.pwd, "/spec/files/tree.json"].join))
    @tree_from_json = Nutmeg::TreeFromJson.new(data)
  end

  describe "#initialize" do
    it "verifies initialize works correctly" do
      expect(@tree_from_json.tree.class).to eq(Nutmeg::TagTree)
      expect(([:tag_id, :tag, :slug, :name] - @tree_from_json.tree.original.each_leaf.first.content.keys).empty?).to eq(true)
    end
  end
end