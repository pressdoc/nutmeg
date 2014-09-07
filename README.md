# Nutmeg

Help you build and show a menu tree in rails
## Installation

Add this line to your application's Gemfile:

    gem 'nutmeg'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nutmeg

## Usage

First create a tree (in this example from a yaml file)

`@tree_from_yaml = Nutmeg::TreeFromYaml.new({file: [Dir.pwd, "/spec/files/tree.yml"].join})`

To print a nice HTML version of this tree use the helper

`Nutmeg::TagTreeHelper.new(@tree_from_yaml.tree).print_html([1])`

The argument passed into `print_html` is an array of tags that you can use to select the right path in the tree.

Using the example from the spec directory this would output something as follows:

`<ul><li class='level_1 active'>north<ul><li class='level_2 active'>men<ul><li class='level_3 active'>collections<ul><li class='level_4 leaf'>winter 2015</li><li class='level_4 leaf'>spring 2015</li><li class='level_4 leaf active'>summer 2015</li></ul></li></ul></li><li class='level_2'>women<ul><li class='level_3'>collections<ul><li class='level_4 leaf'>winter 2015</li><li class='level_4 leaf'>spring 2015</li><li class='level_4 leaf'>summer 2015</li></ul></li></ul></li><li class='level_2'>events<ul><li class='level_3 leaf'>lowlands 2014</li><li class='level_3 leaf'>sinterklaas 2014</li></ul></li><li class='level_2'>collaborations<ul><li class='level_3 leaf'>afro jack</li><li class='level_3 leaf'>pr.co</li></ul></li></ul></li><li class='level_1'>south<ul></li></li></ul></li></ul>`

The code


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
