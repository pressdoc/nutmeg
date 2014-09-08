require 'spec_helper'

describe Nutmeg::TagTreeHelper do

  before(:each) do
    @tree_from_yaml = Nutmeg::TreeFromYaml.new({file: [Dir.pwd, "/spec/files/tree.yml"].join})
  end

  describe "#print_html" do
    it "outputs html" do
      expect(Nutmeg::TagTreeHelper.new(@tree_from_yaml.tree).print_html([1]).class).to eq(String)
      expect(Nutmeg::TagTreeHelper.new(@tree_from_yaml.tree).print_html([1,3,5,10])).to eq("<ul><li class='level_1 active'> <a >north</a><ul><li class='level_2 active'> <a >men</a><ul><li class='level_3 active'> <a >collections</a><ul><li class='level_4 leaf'> <a href='/north/men/collections/winter_2015'>winter_2015</a></li><li class='level_4 leaf'> <a href='/north/men/collections/spring_2015'>spring_2015</a></li><li class='level_4 leaf active'> <a href='/north/men/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li><li class='level_2'> <a >women</a><ul><li class='level_3'> <a >collections</a><ul><li class='level_4 leaf'> <a href='/north/women/collections/winter_2015'>winter_2015</a></li><li class='level_4 leaf'> <a href='/north/women/collections/spring_2015'>spring_2015</a></li><li class='level_4 leaf'> <a href='/north/women/collections/summer_2015'>summer_2015</a></li></ul></li></ul></li><li class='level_2'> <a >events</a><ul><li class='level_3 leaf'> <a href='/north/events/lowlands_2014'>lowlands_2014</a></li><li class='level_3 leaf'> <a href='/north/events/sinterklaas_2014'>sinterklaas_2014</a></li></ul></li><li class='level_2'> <a >collaborations</a><ul><li class='level_3 leaf'> <a href='/north/collaborations/afro_jack'>afro_jack</a></li><li class='level_3 leaf'> <a href='/north/collaborations/pr_co'>pr_co</a></li></ul></li></ul></li><li class='level_1'> <a >south</a><ul></li></li></ul></li></ul>")
    end
  end
end