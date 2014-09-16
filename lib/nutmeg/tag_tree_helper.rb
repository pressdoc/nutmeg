module Nutmeg
  class TagTreeHelper
    attr_accessor :tree
    def initialize(tree)
      raise "No valid data type" unless tree.class == TagTree
      @tree = tree
    end

    def print_html(tags_given, greedy = false)
      [print_node(@tree.original, tags_given, greedy)].join("")
    end

    def node_html(node, active, leaf, content)
      "<li class='level_#{node.level}#{leaf ? ' leaf' : ''}#{active ? ' active' : ''}'> <a #{(leaf) ? "href=\'#{node_path(node)}\'" : ''}>#{content}</a>"
    end

    def node_path(node)
      ([""] + node.parentage.map{|p| p.content[:slug]}.reverse.reject{|n| n == "root"} + [node.content[:slug]]).join("/")
    end

    def print_node(node, tags_given, greedy = false)
      output = []
      if render_node?(node,tags_given)
        output << node_html(node, (!@tree.get_paths(tags_given).first.nil? && @tree.get_paths(tags_given).first.map(&:name).include?(node.name) || (greedy == true && tags_given.include?(node.content[:slug]))), node.is_leaf?, node.content[:slug])
      end

      if !traverse_node?(node, tags_given)
        output << "</li>"
        return output
      end
      if node.has_children?
        output << "<ul>"
          node.children.each do |child|
            output << print_node(child, tags_given, greedy)
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
      true
    end
  end
end