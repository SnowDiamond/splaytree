require 'test_helper'

class SplaytreeTest < Minitest::Test
  def setup
    @tree = Splaytree.new
  end

  def test_that_it_has_a_version_number
    refute_nil ::Splaytree::VERSION
  end

  def test_new_tree_size
    assert_equal @tree.length, 0
  end

  def test_new_tree_empty
    assert_equal @tree.empty?, true
  end
end
