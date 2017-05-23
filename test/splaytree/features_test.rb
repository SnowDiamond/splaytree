require_relative '../test_helper.rb'

class Splaytree::FeaturesTest < MiniTest::Test
  def setup
    @tree = Splaytree.new
    NODES.each { |node| @tree.insert(node[0], node[1]) }
    @duplicate_tree = Splaytree.new
    DUPLICATE_NODES.each { |node| @duplicate_tree.insert(node[0], node[1]) }
  end

  def test_update_value
    updated = @tree.update(1000, 'new value')
    assert_equal updated, true
    assert_equal @tree.root.value, 'new value'

    updated = @tree.update(2000, 'new value')
    assert_equal updated, false
  end

  def test_has_key
    assert_equal @tree.key?(1000), true
    assert_equal @tree.key?(2000), false
  end

  def test_get_max
    node = @tree.max
    assert_equal node, 1000 => '1000'
    assert_equal @tree.root.key, 1000

    node = @duplicate_tree.max
    assert_equal node, 90 => '90'
    assert_equal @duplicate_tree.root.key, 90
  end

  def test_get_min
    node = @tree.min
    assert_equal node, 1 => '1'
    assert_equal @tree.root.key, 1

    node = @duplicate_tree.min
    assert_equal node, 10 => '10'
    assert_equal @duplicate_tree.root.key, 10
  end

  def test_find_higher
    node = @tree.higher(900)
    assert_equal node, 901 => '901'
    assert_equal @tree.root.key, 901

    node = @tree.higher(900.5)
    assert_equal node, 901 => '901'
    assert_equal @tree.root.key, 901

    node = @tree.higher(1000)
    assert_nil node

    node = @duplicate_tree.higher(20)
    assert_equal node, 70 => '70'
    assert_equal @duplicate_tree.root.key, 70
  end

  def test_find_lower
    node = @tree.lower(900)
    assert_equal node, 899 => '899'
    assert_equal @tree.root.key, 899

    node = @tree.lower(900.5)
    assert_equal node, 900 => '900'
    assert_equal @tree.root.key, 900

    node = @tree.lower(1)
    assert_nil node

    node = @duplicate_tree.lower(20)
    assert_equal node, 10 => '10'
    assert_equal @duplicate_tree.root.key, 10
  end

  def test_find_ceiling
    node = @tree.ceiling(900.5)
    assert_equal node, 901 => '901'
    assert_equal @tree.root.key, 901

    node = @tree.ceiling(1000)
    assert_equal node, 1000 => '1000'

    node = @tree.ceiling(1001)
    assert_nil node

    node = @duplicate_tree.ceiling(20)
    assert_equal node, 20 => '20.5'
    assert_equal @duplicate_tree.root.key, 20
  end

  def test_find_floor
    node = @tree.floor(900.5)
    assert_equal node, 900 => '900'
    assert_equal @tree.root.key, 900

    node = @tree.floor(0)
    assert_nil node

    node = @tree.floor(1)
    assert_equal node, 1 => '1'

    node = @duplicate_tree.floor(20)
    assert_equal node, 20 => '20.5'
    assert_equal @duplicate_tree.root.key, 20
  end
end
