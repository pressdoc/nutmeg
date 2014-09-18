require 'spec_helper'

describe Nutmeg::TreeFromYaml do

  before(:each) do
    @tree_from_yaml = Nutmeg::TreeFromYaml.new({file: [Dir.pwd, "/spec/files/tree.yml"].join})
  end

  describe "#initialize" do
    it "verifies initialize works correctly" do
      expect(@tree_from_yaml.tree_hash.class).to eq(Array)
      expect(@tree_from_yaml.tree_hash.first.class).to eq(Hash)
      expect(@tree_from_yaml.tree.class).to eq(Nutmeg::TagTree)
      expect(@tree_from_yaml.tree.original.each_leaf.first.content[:slug]).to eq("winter_2015")
      expect(@tree_from_yaml.tree.original.each_leaf.first.content[:tag_id]).to eq(8)
      expect(([:tag_id, :tag, :slug] - @tree_from_yaml.tree.original.each_leaf.first.content.keys).empty?).to eq(true)
    end
  end
end