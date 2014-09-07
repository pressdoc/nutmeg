require 'spec_helper'

describe Nutmeg::TagTreeHelper do

  before(:each) do
    @tree_from_yaml = Nutmeg::TreeFromYaml.new({file: [Dir.pwd, "/spec/files/tree.yml"].join})
  end

  describe "#print_html" do
    it "outputs html" do
      expect(Nutmeg::TagTreeHelper.new(@tree_from_yaml.tree).print_html([1]).class).to eq(String)
      expect(Nutmeg::TagTreeHelper.new(@tree_from_yaml.tree).print_html([1,3,5,10])).to eq("<ul><li class='level_1 active'>north<ul><li class='level_2 active'>men<ul><li class='level_3 active'>collections<ul><li class='level_4 leaf'>winter 2015</li><li class='level_4 leaf'>spring 2015</li><li class='level_4 leaf active'>summer 2015</li></ul></li></ul></li><li class='level_2'>women<ul><li class='level_3'>collections<ul><li class='level_4 leaf'>winter 2015</li><li class='level_4 leaf'>spring 2015</li><li class='level_4 leaf'>summer 2015</li></ul></li></ul></li><li class='level_2'>events<ul><li class='level_3 leaf'>lowlands 2014</li><li class='level_3 leaf'>sinterklaas 2014</li></ul></li><li class='level_2'>collaborations<ul><li class='level_3 leaf'>afro jack</li><li class='level_3 leaf'>pr.co</li></ul></li></ul></li><li class='level_1'>south<ul></li></li></ul></li></ul>")
    end
  end
end