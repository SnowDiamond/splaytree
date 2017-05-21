require_relative '../test_helper.rb'

class SplayTree::RemovesTest < MiniTest::Test

  def setup
    @tree = SplayTree.new
    STRUCTURED_NODES.each { |node| @tree.insert(node[0], node[1]) }
  end

  def test_remove_simple
    @tree.remove(50)
    assert_equal @tree.length, 15
    refute_includes @tree.keys, 50
  end

  def test_remove_duplicate
    @tree.remove(20)
    keys = STRUCTURED_NODES_KEYS
    keys.slice!(keys.index(20))
    assert_equal @tree.length, 15
    assert_equal keys.sort, @tree.keys.sort
  end

  def test_remove_leaf
    @tree.remove(45)
    structure = [
      { node: 10, parent: 20, left: nil, right: nil },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 20, parent: 32, left: 10, right: 30 },
      { node: 25, parent: 30, left: nil, right: nil },
      { node: 30, parent: 20, left: 25, right: nil },
      { node: 32, parent: 42, left: 20, right: 35 },
      { node: 35, parent: 32, left: nil, right: 40 },
      { node: 40, parent: 35, left: nil, right: nil },
      { node: 42, parent: nil, left: 32, right: 47 },
      { node: 47, parent: 42, left: nil, right: 50 },
      { node: 50, parent: 47, left: nil, right: 55 },
      { node: 55, parent: 50, left: nil, right: 75 },
      { node: 60, parent: 75, left: nil, right: nil },
      { node: 75, parent: 55, left: 60, right: nil },
    ]
    assert_equal @tree.report, structure
    assert_equal @tree.root.key, 42
    assert_equal @tree.size, 15
  end

  def test_remove_node_with_one_child
    @tree.remove(50)
    structure = [
      { node: 10, parent: 20, left: nil, right: nil },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 20, parent: 32, left: 10, right: 30 },
      { node: 25, parent: 30, left: nil, right: nil },
      { node: 30, parent: 20, left: 25, right: nil },
      { node: 32, parent: 47, left: 20, right: 42 },
      { node: 35, parent: 42, left: nil, right: 40 },
      { node: 40, parent: 35, left: nil, right: nil },
      { node: 42, parent: 32, left: 35, right: 45 },
      { node: 45, parent: 42, left: nil, right: nil },
      { node: 47, parent: nil, left: 32, right: 55 },
      { node: 55, parent: 47, left: nil, right: 75 },
      { node: 60, parent: 75, left: nil, right: nil },
      { node: 75, parent: 55, left: 60, right: nil },
    ]
    assert_equal @tree.report, structure
    assert_equal @tree.root.key, 47
    assert_equal @tree.size, 15
  end

  def test_remove_node_with_two_child
    @tree.remove(47)
    structure = [
      { node: 10, parent: 20, left: nil, right: nil },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 20, parent: 32, left: 10, right: 30 },
      { node: 25, parent: 30, left: nil, right: nil },
      { node: 30, parent: 20, left: 25, right: nil },
      { node: 32, parent: 42, left: 20, right: 35 },
      { node: 35, parent: 32, left: nil, right: 40 },
      { node: 40, parent: 35, left: nil, right: nil },
      { node: 42, parent: 45, left: 32, right: nil },
      { node: 45, parent: nil, left: 42, right: 50 },
      { node: 50, parent: 45, left: nil, right: 55 },
      { node: 55, parent: 50, left: nil, right: 75 },
      { node: 60, parent: 75, left: nil, right: nil },
      { node: 75, parent: 55, left: 60, right: nil },
    ]
    assert_equal @tree.report, structure
    assert_equal @tree.root.key, 45
    assert_equal @tree.size, 15
  end
end
