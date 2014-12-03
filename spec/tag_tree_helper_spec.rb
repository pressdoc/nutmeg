require 'spec_helper'

describe Nutmeg::TagTreeHelper do

  before(:each) do
    @tree_from_yaml = Nutmeg::TreeFromYaml.new({file: [Dir.pwd, "/spec/files/tree.yml"].join})
    data = File.open([Dir.pwd, "/spec/files/tree.json"].join)
    @tree_from_json = Nutmeg::TreeFromJson.new(data)
  end

  describe "#print_html" do
    it "outputs html" do
      expect(Nutmeg::TagTreeHelper.new(@tree_from_yaml.tree).print_html([1]).class).to eq(String)
      expect(Nutmeg::TagTreeHelper.new(@tree_from_yaml.tree).print_html(["north", "men", "collections", "summer_2015"])).to eq("<ul><li class='level_1 active'> <a >north</a><ul><li class='level_2 active'> <a >men</a><ul><li class='level_3 active'> <a >collections</a><ul><li class='level_4 leaf'> <a href='/north/men/collections/winter_2015'>winter_2015</a></li><li class='level_4 leaf'> <a href='/north/men/collections/spring_2015'>spring_2015</a></li><li class='level_4 leaf active'> <a href='/north/men/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li><li class='level_2'> <a >women</a><ul><li class='level_3'> <a >collections</a><ul><li class='level_4 leaf'> <a href='/north/women/collections/winter_2015'>winter_2015</a></li><li class='level_4 leaf'> <a href='/north/women/collections/spring_2015'>spring_2015</a></li><li class='level_4 leaf'> <a href='/north/women/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li><li class='level_2'> <a >events</a><ul><li class='level_3 leaf'> <a href='/north/events/lowlands_2014'>lowlands_2014</a></li><li class='level_3 leaf'> <a href='/north/events/sinterklaas_2014'>sinterklaas_2014</a></li></ul></li><li class='level_2'> <a >collaborations</a><ul><li class='level_3 leaf'> <a href='/north/collaborations/afro_jack'>afro_jack</a></li><li class='level_3 leaf'> <a href='/north/collaborations/pr_co'>pr_co</a></li></ul></li></ul></li><li class='level_1'> <a >south</a><ul><li class='level_2'> <a >men</a><ul><li class='level_3'> <a >collections</a><ul><li class='level_4 leaf'> <a href='/south/men/collections/winter_2015'>winter_2015</a></li><li class='level_4 leaf'> <a href='/south/men/collections/spring_2015'>spring_2015</a></li><li class='level_4 leaf'> <a href='/south/men/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li><li class='level_2'> <a >women</a><ul><li class='level_3'> <a >collections</a><ul><li class='level_4 leaf'> <a href='/south/women/collections/winter_2015'>winter_2015</a></li><li class='level_4 leaf'> <a href='/south/women/collections/spring_2015'>spring_2015</a></li><li class='level_4 leaf'> <a href='/south/women/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li></ul></li></ul>")
    end

    it "outputs html for subtree" do
      subtree = @tree_from_yaml.tree.subtree("north")
      expect(Nutmeg::TagTreeHelper.new(subtree).print_html(["men", "collections", "summer_2015"])).to eq("<ul><li class='level_1 active'> <a >men</a><ul><li class='level_2 active'> <a >collections</a><ul><li class='level_3 leaf'> <a href='/north/men/collections/winter_2015'>winter_2015</a></li><li class='level_3 leaf'> <a href='/north/men/collections/spring_2015'>spring_2015</a></li><li class='level_3 leaf active'> <a href='/north/men/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li><li class='level_1'> <a >women</a><ul><li class='level_2'> <a >collections</a><ul><li class='level_3 leaf'> <a href='/north/women/collections/winter_2015'>winter_2015</a></li><li class='level_3 leaf'> <a href='/north/women/collections/spring_2015'>spring_2015</a></li><li class='level_3 leaf'> <a href='/north/women/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li><li class='level_1'> <a >events</a><ul><li class='level_2 leaf'> <a href='/north/events/lowlands_2014'>lowlands_2014</a></li><li class='level_2 leaf'> <a href='/north/events/sinterklaas_2014'>sinterklaas_2014</a></li></ul></li><li class='level_1'> <a >collaborations</a><ul><li class='level_2 leaf'> <a href='/north/collaborations/afro_jack'>afro_jack</a></li><li class='level_2 leaf'> <a href='/north/collaborations/pr_co'>pr_co</a></li></ul></li></ul>")
    end

    it "outputs html for subtree (greedy)" do
      subtree = @tree_from_yaml.tree.subtree("north")
      expect(Nutmeg::TagTreeHelper.new(subtree).print_html(["men", "collections"],true)).to eq("<ul><li class='level_1 active'> <a >men</a><ul><li class='level_2 active'> <a >collections</a><ul><li class='level_3 leaf'> <a href='/north/men/collections/winter_2015'>winter_2015</a></li><li class='level_3 leaf'> <a href='/north/men/collections/spring_2015'>spring_2015</a></li><li class='level_3 leaf'> <a href='/north/men/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li><li class='level_1'> <a >women</a><ul><li class='level_2 active'> <a >collections</a><ul><li class='level_3 leaf'> <a href='/north/women/collections/winter_2015'>winter_2015</a></li><li class='level_3 leaf'> <a href='/north/women/collections/spring_2015'>spring_2015</a></li><li class='level_3 leaf'> <a href='/north/women/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li><li class='level_1'> <a >events</a><ul><li class='level_2 leaf'> <a href='/north/events/lowlands_2014'>lowlands_2014</a></li><li class='level_2 leaf'> <a href='/north/events/sinterklaas_2014'>sinterklaas_2014</a></li></ul></li><li class='level_1'> <a >collaborations</a><ul><li class='level_2 leaf'> <a href='/north/collaborations/afro_jack'>afro_jack</a></li><li class='level_2 leaf'> <a href='/north/collaborations/pr_co'>pr_co</a></li></ul></li></ul>")
    end
    context "from json" do
      it "outputs html for subtree" do
        subtree = @tree_from_json.tree
        expect(Nutmeg::TagTreeHelper.new(subtree, {:prepend_path => "/nl/t"}).print_html(["men", "collections"],false)).to eq("<ul><li class='level_1'> <a >North</a><ul><li class='level_2'> <a >Men</a><ul><li class='level_3 leaf'> <a href='/nl/t/north/men/footwear'>Footwear</a></li><li class='level_3 leaf'> <a href='/nl/t/north/men/eyewear'>Eyewear</a></li></ul></li><li class='level_2'> <a >Women</a><ul><li class='level_3 leaf'> <a href='/nl/t/north/women/footwear'>Footwear</a></li><li class='level_3'> <a >Eyewear</a><ul><li class='level_4 leaf'> <a href='/nl/t/north/women/eyewear/gfdgdfs'>gfdgdfs</a></li></ul></li></ul></li><li class='level_2 leaf'> <a href='/nl/t/north/collaboration'>Collaboration</a></li></ul></li><li class='level_1'> <a >South</a><ul><li class='level_2'> <a >Men</a><ul><li class='level_3 leaf'> <a href='/nl/t/south/men/collection'>Collection</a></li><li class='level_3 leaf'> <a href='/nl/t/south/men/footwear'>Footwear</a></li><li class='level_3 leaf'> <a href='/nl/t/south/men/eyewear'>Eyewear</a></li></ul></li><li class='level_2'> <a >Women</a><ul><li class='level_3 leaf'> <a href='/nl/t/south/women/collection'>Collection</a></li><li class='level_3 leaf'> <a href='/nl/t/south/women/footwear'>Footwear</a></li><li class='level_3 leaf'> <a href='/nl/t/south/women/eyewear'>Eyewear</a></li></ul></li><li class='level_2 leaf'> <a href='/nl/t/south/collaboration'>Collaboration</a></li></ul></li></ul>")
      end
      context "additional leaf content" do
        it "renders additional content in the leaf" do
          subtree = @tree_from_json.tree
          expect(Nutmeg::TagTreeHelper.new(subtree, {:prepend_path => "/nl/t"}).print_html(["north", "men", "footwear"],false, "<a href='#'>Extra content</a>")).to eq("<ul><li class='level_1 active'> <a >North</a><ul><li class='level_2 active'> <a >Men</a><ul><li class='level_3 leaf active'> <a href='/nl/t/north/men/footwear'>Footwear</a><a href='#'>Extra content</a></li><li class='level_3 leaf'> <a href='/nl/t/north/men/eyewear'>Eyewear</a></li></ul></li><li class='level_2'> <a >Women</a><ul><li class='level_3 leaf'> <a href='/nl/t/north/women/footwear'>Footwear</a></li><li class='level_3'> <a >Eyewear</a><ul><li class='level_4 leaf'> <a href='/nl/t/north/women/eyewear/gfdgdfs'>gfdgdfs</a></li></ul></li></ul></li><li class='level_2 leaf'> <a href='/nl/t/north/collaboration'>Collaboration</a></li></ul></li><li class='level_1'> <a >South</a><ul><li class='level_2'> <a >Men</a><ul><li class='level_3 leaf'> <a href='/nl/t/south/men/collection'>Collection</a></li><li class='level_3 leaf'> <a href='/nl/t/south/men/footwear'>Footwear</a></li><li class='level_3 leaf'> <a href='/nl/t/south/men/eyewear'>Eyewear</a></li></ul></li><li class='level_2'> <a >Women</a><ul><li class='level_3 leaf'> <a href='/nl/t/south/women/collection'>Collection</a></li><li class='level_3 leaf'> <a href='/nl/t/south/women/footwear'>Footwear</a></li><li class='level_3 leaf'> <a href='/nl/t/south/women/eyewear'>Eyewear</a></li></ul></li><li class='level_2 leaf'> <a href='/nl/t/south/collaboration'>Collaboration</a></li></ul></li></ul>")
        end
      end

      context "Wrapping ul element" do
        it "do not return wrapping ul" do
          subtree = @tree_from_json.tree
          expect(Nutmeg::TagTreeHelper.new(subtree, {:prepend_path => "/nl/t"}).print_html(["north", "men", "footwear"],false, "<a href='#'>Extra content</a>", true)).to eq("<li class='level_1 active'> <a >North</a><ul><li class='level_2 active'> <a >Men</a><ul><li class='level_3 leaf active'> <a href='/nl/t/north/men/footwear'>Footwear</a><a href='#'>Extra content</a></li><li class='level_3 leaf'> <a href='/nl/t/north/men/eyewear'>Eyewear</a></li></ul></li><li class='level_2'> <a >Women</a><ul><li class='level_3 leaf'> <a href='/nl/t/north/women/footwear'>Footwear</a></li><li class='level_3'> <a >Eyewear</a><ul><li class='level_4 leaf'> <a href='/nl/t/north/women/eyewear/gfdgdfs'>gfdgdfs</a></li></ul></li></ul></li><li class='level_2 leaf'> <a href='/nl/t/north/collaboration'>Collaboration</a></li></ul></li><li class='level_1'> <a >South</a><ul><li class='level_2'> <a >Men</a><ul><li class='level_3 leaf'> <a href='/nl/t/south/men/collection'>Collection</a></li><li class='level_3 leaf'> <a href='/nl/t/south/men/footwear'>Footwear</a></li><li class='level_3 leaf'> <a href='/nl/t/south/men/eyewear'>Eyewear</a></li></ul></li><li class='level_2'> <a >Women</a><ul><li class='level_3 leaf'> <a href='/nl/t/south/women/collection'>Collection</a></li><li class='level_3 leaf'> <a href='/nl/t/south/women/footwear'>Footwear</a></li><li class='level_3 leaf'> <a href='/nl/t/south/women/eyewear'>Eyewear</a></li></ul></li><li class='level_2 leaf'> <a href='/nl/t/south/collaboration'>Collaboration</a></li></ul></li>")
        end
      end


      context "Big tree with complex structure" do
        it "returns the correct html" do
          data = File.open([Dir.pwd, "/spec/files/big_tree.json"].join)
          @tree_from_json = Nutmeg::TreeFromJson.new(data)
          subtree = @tree_from_json.tree.subtree("north")
          tree_html = Nutmeg::TagTreeHelper.new(subtree).print_html(["north", "about", "milestones", "2014", "the-netherlands"], true)
          expect(tree_html).to include("<a >About</a><ul><li class='level_2'> <a >Factsheets</a>")
          expect(tree_html).not_to include("<a >About</a><ul><li class='level_2 active'> <a >Factsheets</a>")
          expect(tree_html).to include("<li class='level_2 active'> <a >Milestones</a><ul><li class='level_3 leaf active'> <a href='/north/about/milestones/2014'>2014</a></li></ul></li>")
        end
      end
    end

  end
end