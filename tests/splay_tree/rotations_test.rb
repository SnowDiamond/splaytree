require_relative '../test_helper.rb'

class SplayTree::RotationsTest < MiniTest::Test

  def setup
    @tree = SplayTree.new
    @numbers = (10..90).to_a.shuffle
    @numbers.each { |n| @tree[n] = n.to_s }
  end

  def test_zig_left
    @tree[50]
    parent = @tree.root
    child = parent.left
    @tree[child.key]
    assert child.key == @tree.root.key
    assert child.right == parent
    assert parent.parent == child
    assert child.root? == true
  end

  def test_zig_right
    @tree[50]
    parent = @tree.root
    child = parent.right
    @tree[child.key]
    assert child.key == @tree.root.key
    assert child.left == parent
    assert parent.parent == child
    assert child.root? == true
  end

  def test_zigzig_left
    gparent = parent = child = nil
    loop do
      @tree[@numbers.shuffle.first]
      gparent = @tree.root
      parent = gparent.left
      next unless parent
      child = parent.left
      break if child
    end

    child_left = child.left
    child_right = child.right
    parent_right = parent.right
    gparent_right = gparent.right

    @tree[child.key]

    assert child.key == @tree.root.key
    assert child.root? == true
    assert child.right == parent
    assert child.left == child_left
    assert parent.parent == child
    assert gparent.gparent == child
    assert gparent.parent == parent
    assert parent.right == gparent

    assert child_right == parent.left
    assert parent_right == gparent.left
    assert gparent_right == gparent.right
  end

  def test_zigzig_right
    gparent = parent = child = nil
    loop do
      @tree[@numbers.shuffle.first]
      gparent = @tree.root
      parent = gparent.right
      next unless parent
      child = parent.right
      break if child
    end

    child_left = child.left
    child_right = child.right
    parent_left = parent.left
    gparent_left = gparent.left

    @tree[child.key]

    assert child.key == @tree.root.key
    assert child.root? == true
    assert child.left == parent
    assert child_right == child.right
    assert parent.parent == child
    assert gparent.gparent == child
    assert gparent.parent == parent
    assert parent.left == gparent

    assert child_left == parent.right
    assert parent_left == gparent.right
    assert gparent_left == gparent.left
  end

  def test_zigzag_left
    gparent = parent = child = nil
    loop do
      @tree[@numbers.shuffle.first]
      gparent = @tree.root
      parent = gparent.left
      next unless parent
      child = parent.right
      break if child
    end

    child_left = child.left
    child_right = child.right
    parent_left = parent.left
    gparent_right = gparent.right

    @tree[child.key]

    assert child.key == @tree.root.key
    assert child.root? == true
    assert child.left == parent
    assert child.right == gparent
    assert parent.parent == child
    assert gparent.parent == child

    assert child_left == parent.right
    assert child_right == gparent.left
    assert parent_left == parent.left
    assert gparent_right == gparent.right
  end

  def test_zigzag_right
    gparent = parent = child = nil
    loop do
      @tree[@numbers.shuffle.first]
      gparent = @tree.root
      parent = gparent.right
      next unless parent
      child = parent.left
      break if child
    end

    child_left = child.left
    child_right = child.right
    parent_right = parent.right
    gparent_left = gparent.left

    @tree[child.key]

    assert child.key == @tree.root.key
    assert child.root? == true
    assert child.left == gparent
    assert child.right == parent
    assert parent.parent == child
    assert gparent.parent == child

    assert child_left == gparent.right
    assert child_right == parent.left
    assert parent_right == parent.right
    assert gparent_left == gparent.left
  end

end
