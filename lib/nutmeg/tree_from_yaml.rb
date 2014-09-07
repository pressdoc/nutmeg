module Nutmeg
  class TreeFromYaml
    attr_accessor :base_tree, :tags, :tree_hash, :tree, :tag_tree

    def initialize(params)
      @data = YAML.load_file(params[:file])
      @tags = @data["tags"]
      @base_tree = @data["tree"]
      @tree_hash = []
      traverse_tree
      get_levels
      @tag_tree = Tree::TreeNode.new("ROOT", {:tag => "root",:otag => "root", :level => nil, :slug => "root"})
      @tree_hash.select{|node|node[:level] == 0}.each do |node|
        node_tree = @tag_tree << Tree::TreeNode.new("tag_#{node[:tag]}_#{node[:level]}_root", node)
        build_node(node_tree, node)
      end
      @tree = Nutmeg::TagTree.new(@tag_tree)
      nil
    end

    private
      def build_node(start, node)
        get_children(node[:tag], node[:level]).each do |node|
          node_tree = start << Tree::TreeNode.new("tag_#{node[:tag]}", node)
          build_node(node_tree, node)
        end
      end

      def get_levels
        @levels = @tree_hash.collect do |tag|
          tag[:level]
        end.uniq.sort
      end

      def get_children(parent, level)
        @tree_hash.select{|node| node[:parent] == parent && node[:level] > level }
      end

      def traverse_tree
        base_tree.each do |l|
          walk(l,0,"root")
        end
      end

      def walk(array, level = 0, parent = nil)
        array.keys.each do |key|
          @tree_hash << {:tag => [key, level,parent].join("_"), :level => level, :parent => parent, :otag => key, :slug => @tags[key], :tag_id => key}
          return if array[key].nil?
          array[key].compact.each do |child|
            walk(child, level + 1, [key, level,parent].join("_"))
          end
        end
      end
  end
end