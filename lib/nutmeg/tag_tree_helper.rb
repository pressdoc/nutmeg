module Nutmeg
  class TagTreeHelper
    attr_accessor :tree
    def initialize(tree)
      raise "No valid data type" unless tree.class == TagTree
      @tree = tree
    end

    def print_html(tags_given)
      [print_node(@tree.original, tags_given)].join("")
    end

    def node_html(node, active, leaf)
      "<li class='level_#{node.level}#{leaf ? ' leaf' : ''}#{active ? ' active' : ''}'>"
    end

    def print_node(node, tags_given)
      output = []
      if render_node?(node,tags_given)
        output << node_html(node, (!@tree.get_paths(tags_given).first.nil? && @tree.get_paths(tags_given).first.map(&:name).include?(node.name)), node.is_leaf? )
        output << node.content[:slug]
      end

      if !traverse_node?(node, tags_given)
        output << "</li>"
        return output
      end
      if node.has_children?
        output << "<ul>"
          node.children.each do |child|
            output << print_node(child, tags_given)
          end
        output << "</ul>"
      end
      if render_node?(node,tags_given)
        output << "</li>"
      end
      output
    end

    def render_node?(node, tags_given)
      return false if node.is_root?
      traverse_node?(node, tags_given)
    end

    def traverse_node?(node, tags_given)
      return true if node.is_root?
      return true if node.level == 1
      (node.parentage.select{|n| n.level == 1}.map{|n| n.content[:tag_id]} & tags_given).count >= 1
    end
  end
end