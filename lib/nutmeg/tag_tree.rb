module Nutmeg
  class TagTree
    attr_accessor :original

    def initialize(tree)
      raise "No valid data type" unless tree.class == Tree::TreeNode
      @original = tree
    end

    def subtree(slug)
      @original.each do |node|
        return Nutmeg::TagTree.new(node.detached_subtree_copy) if node.content[:slug] == slug
      end
    end

    def get_paths(tags_given, strict = false)
      start_nodes = @original.children.select{|l| tags_given.include?(l.content[:slug])}
      end_nodes = @original.each_leaf.select{|l| tags_given.include?(l.content[:slug])}

      result = end_nodes.select do |end_node|
        (end_node.parentage & start_nodes).count >= 1
      end.collect do |leaf|
        ([leaf] + leaf.parentage).reverse
      end.select do |path|
        (path.map{|tag| tag.content[:slug] } & tags_given).count >= 1
      end

      result.sort_by! do |path|
        ((path.map{|tag| tag.content[:slug] } & tags_given).count)
      end.reverse!
    end

    def get_paths_eager(tags_given)
      @original.children.select{|l| tags_given.include?(l.content[:slug])}.collect{|leaf| ([leaf] + leaf.parentage).reverse }
    end

    def get_paths_formatted(tags_given, seperator = "/")
      get_paths(tags_given).collect do |tags|
        tags.reject{|tag| tag.content[:slug] == "root"}.map{|node| node.content[:slug]}.join(seperator)
      end
    end
  end
end