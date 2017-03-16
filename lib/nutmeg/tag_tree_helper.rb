module Nutmeg
  class TagTreeHelper
    attr_accessor :tree
    def initialize(tree, options = {})
      raise "No valid data type" unless tree.class == TagTree
      @options = options
      @tree = tree
    end

    def prepend_path
      @options[:prepend_path] || ""
    end

    def append_path
      @options[:append_path] || ""
    end

    def title(node)
      node.content[:name] || node.content[:slug]
    end

    def print_html(tags_given, greedy = false, extra_html = nil, do_not_wrap = false)
      [print_node(@tree.original, tags_given, greedy, extra_html, do_not_wrap)].join("")
    end

    def print_relevant_html(tags_given, greedy = false, extra_html = nil, do_not_wrap = false)
      html_nodes = []
      intersectional_tags(tags_given).each do |node|
        html_nodes << node_html(node, false, true, title(node), extra_html) + "</li>"
      end
      return html_nodes.join
    end

    def intersectional_tags(tags_given)
      tree_nodes = []
      @tree.original.each do |node|
        if tags_given.include? node.content[:slug]
          tree_nodes << node
        end
      end
      return tree_nodes.uniq{|p| p.content[:slug]}
    end

    def node_html(node, active, leaf, content, extra_html = nil)
      "<li class='level_#{node.level}#{leaf ? ' leaf' : 'subtree'}#{active ? ' active' : ''}'> <a #{(leaf) ? "href=\'#{prepend_path}#{node_path(node)}#{append_path}\'" : ''}>#{content}</a>#{extra_html && active && leaf ? extra_html : ''}"
    end

    def node_path(node)
      ([""] + node.parentage.map{|p| p.content[:slug]}.reverse.reject{|n| n == "root"} + [node.content[:slug]]).join("/")
    end

    def print_node(node, tags_given, greedy = false, extra_html = nil, do_not_wrap = false)
      output = []

      if render_node?(node,tags_given)
        output << node_html(node, (!@tree.get_paths(tags_given).first.nil? && @tree.get_paths(tags_given).first.map(&:name).include?(node.name) || (greedy == true && tags_given.include?(node.content[:slug]))), node.is_leaf?, title(node), extra_html)
      end

      if !traverse_node?(node, tags_given)
        output << "</li>"
        return output
      end
      if node.has_children?
        output << (do_not_wrap && node.is_root? ? "" : "<ul>")
          node.children.each do |child|
            output << print_node(child, tags_given, greedy,extra_html, do_not_wrap)
          end
        output << (do_not_wrap && node.is_root? ? "" : "</ul>")
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
