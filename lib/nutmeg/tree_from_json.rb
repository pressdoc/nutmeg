module Nutmeg
  class TreeFromJson
    attr_accessor :base_tree, :tags, :tree_hash, :tree, :tag_tree

    def initialize(data)
      @data = JSON.load(data)
      @base_tree = @data
      @tag_tree = Tree::TreeNode.new("ROOT", {:tag => "root",:otag => "root", :level => nil, :slug => "root"})
      base_tree.each do |node|
        node_tree = @tag_tree << Tree::TreeNode.new(node["id"], node_hash(node))
        build_node(node_tree, node)
      end
      @tree = Nutmeg::TagTree.new(@tag_tree)
      nil
    end

    private
      def node_hash(node)
        {
          :tag_id => node["data"]["id"],
          :tag => node["id"],
          :slug => node["data"]["slug"],
          :name => node["data"]["name"]
        }
      end

      def build_node(parent, node)
        # puts "Building node #{node['id']}"
        # puts "===="
        #puts node["children"].map{|d| d["id"]}

        node["children"].each do |child|
          #puts "Adding #{child['id']} to #{node['id']}"
          node_tree = parent << Tree::TreeNode.new(child["id"], node_hash(child))
          build_node(node_tree, child)
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
        base_tree.each do |node|
          walk(node.symbolize_keys!)
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