require 'spec_helper'

describe Nutmeg::TagTree do

  before(:each) do
    tree = Tree::TreeNode.new("ROOT", {:tag_id => 0, :slug => "root"})
    tree << Tree::TreeNode.new("base", {:tag_id => 1, :slug => "base"}) << Tree::TreeNode.new("child", {:tag_id => 2, :slug => "child"})
    @tag_tree = Nutmeg::TagTree.new(tree)
  end

  describe "#initialize" do
    it "verifies initialize works correctly" do
      expect(@tag_tree.original.class).to eq(Tree::TreeNode)
    end
  end

  describe "#subtree" do
    it "returns a subtree starting at tag with slug 'base'" do
      expect(@tag_tree.original.size).to eq(3)
      expect(@tag_tree.subtree("base").original.size).to eq(2)
    end
  end

  describe "#get_paths_eager" do
    it 'verifies output is similar' do
      expect(@tag_tree.get_paths_eager(["base"]).first.first.class).to eq(@tag_tree.get_paths(["base", "child"]).first.first.class)
    end
  end

  describe "#get_paths_formatted" do
    it "returns base/child when using [1,2] as selector" do
      expect(@tag_tree.get_paths_formatted(["base", "child"]).first).to eq("base/child")
    end
  end
end