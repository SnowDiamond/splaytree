require_relative '../test_helper.rb'

class Splaytree::InsertsTest < MiniTest::Test
  def setup
    @tree = Splaytree.new
  end

  def test_insert_node
    @tree.insert(10, '10')
    root = @tree.root
    assert_equal root.key, 10
    assert_nil root.left
    assert_nil root.right
    assert_equal @tree.length, 1
    assert_equal @tree.empty?, false
    assert_equal @tree.keys, [10]
    assert_equal @tree.values, ['10']
  end

  def test_hash_like_insert
    @tree[10] = '10'
    root = @tree.root
    assert_equal root.key, 10
    assert_nil root.left
    assert_nil root.right
    assert_equal @tree.length, 1
    assert_equal @tree.empty?, false
    assert_equal @tree.keys, [10]
    assert_equal @tree.values, ['10']
  end

  def test_insert_duplicate_node
    @tree[10] = '10.1'
    @tree[10] = '10.2'
    root = @tree.root
    assert_equal root.key, 10
    assert_nil root.left
    assert_nil root.right
    assert_equal root.value, '10.2'
    assert_equal root.duplicates?, true
    assert_equal root.duplicates, ['10.1']
    assert_equal @tree.length, 2
    assert_equal @tree.keys, [10, 10]
    assert_equal @tree.values, ['10.1', '10.2']
  end

  def test_insert_nodes
    NODES.each_with_index do |node, index|
      @tree.insert(node[0], node[1])
      assert_equal @tree.length, index + 1
      assert_equal @tree.empty?, false
      assert_equal @tree.root.key, node[0]
      assert_equal @tree.root.value, node[1]
    end
    assert_equal @tree.keys.sort, NODES_KEYS
  end

  def test_insert_duplicate_nodes
    DUPLICATE_NODES.each_with_index do |node, index|
      @tree.insert(node[0], node[1])
      assert_equal @tree.length, index + 1
      assert_equal @tree.empty?, false
      assert_equal @tree.root.key, node[0]
      assert_equal @tree.root.value, node[1]
    end
    assert_equal @tree.keys.sort, DUPLICATE_NODES_KEYS
    assert_equal @tree.values.sort, DUPLICATE_NODES_VALUES
  end

  def test_insert_keeps_structure
    numbers = [10, 50, 40, 20, 30, 35, 25, 20, 20, 45, 60, 75, 55, 42, 47, 32]
    numbers.each { |n| @tree[n] = n.to_s }
    structure = [
      { node: 10, parent: 20, left: nil, right: nil },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 20, parent: 20, left: nil, right: nil },
      { node: 20, parent: 32, left: 10, right: 30 },
      { node: 25, parent: 30, left: nil, right: nil },
      { node: 30, parent: 20, left: 25, right: nil },
      { node: 32, parent: nil, left: 20, right: 47 },
      { node: 35, parent: 42, left: nil, right: 40 },
      { node: 40, parent: 35, left: nil, right: nil },
      { node: 42, parent: 47, left: 35, right: 45 },
      { node: 45, parent: 42, left: nil, right: nil },
      { node: 47, parent: 32, left: 42, right: 50 },
      { node: 50, parent: 47, left: nil, right: 55 },
      { node: 55, parent: 50, left: nil, right: 75 },
      { node: 60, parent: 75, left: nil, right: nil },
      { node: 75, parent: 55, left: 60, right: nil }
    ]
    assert_equal @tree.report, structure
  end

end
