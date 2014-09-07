module Nutmeg
  class TagTree
    attr_accessor :original

    def initialize(tree)
      raise "No valid data type" unless tree.class == Tree::TreeNode
      @original = tree
    end

    def subtree(id)
      @original.each do |node|
        return Nutmeg::TagTree.new(node.detached_subtree_copy) if node.content[:tag_id] == id
      end
    end

    def get_paths(tags_given)
      start_nodes = @original.children.select{|l| tags_given.include?(l.content[:tag_id])}
      end_nodes = @original.each_leaf.select{|l| tags_given.include?(l.content[:tag_id])}

      end_nodes.select do |end_node|
        (end_node.parentage & start_nodes).count >= 1
      end.collect do |leaf|
        ([leaf] + leaf.parentage).reverse
      end.select do |path|
        # we always include the 'root' tag
        (path.map{|tag| tag.content[:tag_id] } - tags_given).count == 1
      end
    end

    def get_paths_formatted(tags_given, seperator = "/")
      get_paths(tags_given).collect do |tags|
        tags.reject{|tag| tag.content[:slug] == "root"}.map{|node| node.content[:slug]}.join(seperator)
      end
    end
  end
end