require_relative '../test_helper.rb'

class SplayTree::SearchTest < MiniTest::Test

  def setup
    @tree = SplayTree.new
    NODES.each { |node| @tree.insert(node[0], node[1]) }
  end

  def test_get
    assert_equal @tree.get(500), '500'
  end

  def test_hash_like_get
    assert_equal @tree[500], '500'
  end

  def test_get_perform_splay_to_root
    @tree[300]
    assert_equal @tree.root.key, 300

    @tree[100]
    assert_equal @tree.root.key, 100

    @tree[3]
    assert_equal @tree.root.key, 3

    @tree[900]
    assert_equal @tree.root.key, 900
  end

  def test_get_return_nil_if_not_found
    node = @tree[2000]
    assert_nil node
  end

  def test_get_with_duplicates
    tree = SplayTree.new
    STRUCTURED_NODES.each { |node| tree.insert(node[0], node[1]) }
    values = tree.get_with_duplicates(20)
    assert_equal ['20', '20', '20'], values
  end

  def test_get_keeps_structure
    tree = SplayTree.new
    STRUCTURED_NODES.each { |node| tree.insert(node[0], node[1]) }
    tree[10]
    tree[20]
    tree[40]
    structure = [
      { node: 40, parent: nil, left: 20, right: 47 },
      { node: 20, parent: 40, left: 10, right: 32 },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 10, parent: 20, left: nil, right: nil },
      { node: 32, parent: 20, left: 30, right: 35 },
      { node: 30, parent: 32, left: 25, right: nil },
      { node: 25, parent: 30, left: nil, right: nil },
      { node: 35, parent: 32, left: nil, right: nil },
      { node: 47, parent: 40, left: 42, right: 50 },
      { node: 42, parent: 47, left: nil, right: 45 },
      { node: 45, parent: 42, left: nil, right: nil },
      { node: 50, parent: 47, left: nil, right: 55 },
      { node: 55, parent: 50, left: nil, right: 75 },
      { node: 75, parent: 55, left: 60, right: nil },
      { node: 60, parent: 75, left: nil, right: nil },
    ]
    assert_equal tree.report, structure
  end

end






















