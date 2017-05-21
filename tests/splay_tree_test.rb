require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative '../lib/splay_tree.rb'

class SplayTreeTest < Minitest::Test

  def setup
    @tree = SplayTree.new
  end

  def test_new_tree_size
    assert_equal @tree.length, 0
  end

  def test_new_tree_empty
    assert_equal @tree.empty?, true
  end

end
