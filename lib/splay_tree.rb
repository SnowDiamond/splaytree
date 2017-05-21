require_relative 'splay_tree/node'
require 'pry'

class SplayTree
  include Enumerable

  attr_reader :root

  def initialize
    @root = nil
    @size = 0

  end

  def size
    @size
  end
  alias_method :length, :size

  def empty?
    @root.nil?
  end

  def has_key?(key)
    !!get(key)
  end

  def higher(key)
    return if empty?
    get(key)
    return if @root.key != key || @root.right.nil?
    node = @root.right
    while node.left do
      if node.left
        node = node.left
      end
    end
    splay(node)
    node.to_h
  end

  def lower(key)
    return if empty?
    get(key)
    return if @root.key != key || @root.left.nil?
    node = @root.left
    while node.right do
      node = node.right
    end
    splay(node)
    node.to_h
  end

  def ceiling(key)
    return if empty?
    get(key)
    return @root.to_h if @root.key >= key
    return if @root.right.nil?
    node = @root.right
    while node.left do
      node = node.left
    end
    splay(node)
    @root.to_h
  end

  def floor(key)
    return if empty?
    get(key)
    return @root.to_h if @root.key <= key
    return if @root.left.nil?
    node = @root.left
    while node.right do
      node = node.right
    end
    splay(node)
    @root.to_h
  end

  def min
    return if empty?
    node = @root
    while node.left
      node = node.left
    end
    splay(node)
    node.to_h
  end

  def max
    return if empty?
    node = @root
    while node.right
      node = node.right
    end
    splay(node)
    node.to_h
  end

  def height
    height_recursive(@root)
  end

  def height_recursive(node)
    return 0 unless node

    left_height   = 1 + height_recursive(node.left)
    right_height  = 1 + height_recursive(node.right)
    left_height > right_height ? left_height : right_height
  end

  def get_with_duplicates(key)
    return if empty?
    get(key)
    return if @root.key != key
    @root.duplicates + [@root.value]
  end

  def get(key)
    return if empty?
    node = @root
    value = nil
    loop do
      case key <=> node.key
      when 0
        value = node.value
        break
      when -1
        break if node.left.nil?
        node = node.left
      when 1
        break if node.right.nil?
        node = node.right
      else
        fail
      end
    end
    splay(node)
    value
  end
  alias_method :[], :get

  def insert(key, value)
    node = Node.new(key, value)
    if @root
      current = @root
      loop do
        case key <=> current.key
        when 0
          node = current
          node.add_duplicate!(value)
          break
        when -1
          if !current.left
            current.set_left(node)
            break
          end
          current = current.left
        when 1
          if !current.right
            current.set_right(node)
            break
          end
          current = current.right
        else
          fail
        end
      end
    end
    splay(node)
    @size += 1
    return true
  end
  alias_method :[]=, :insert

  def update(key, value)
    return false if empty?
    get(key)
    return false if @root.key != key
    @root.value = value
    return true
  end

  def remove(key)
    return if empty?
    get(key)
    return if @root.key != key
    if @root.has_duplicates?
      deleted = @root.remove_duplicate!
    else
      deleted = @root.value
      if @root.left.nil?
        @root = @root.right
        @root.parent = nil
      else
        right = @root.right
        @root = @root.left
        @root.parent = nil
        get(key)
        @root.set_right(right)
      end
    end
    @size -= 1
    deleted
  end

  def clear
    @root = nil
  end

  def each
    return if self.empty?
    stack = []
    node = @root
    loop do
      if node
        stack.push(node)
        node.duplicates.each do |value|
          stack.push(Node.new(node.key, value, node))
        end
        node = node.left
      else
        break if stack.empty?
        node = stack.pop
        yield(node)
        node = node.right
      end
    end
  end

  def each_key(&block)
    each { |node| yield node.key }
  end

  def each_value(&block)
    each { |node| yield node.value }
  end

  def keys
    to_enum(:each_key).to_a
  end

  def values
    to_enum(:each_value).to_a
  end

  def report
    return if empty?
    result = []
    each_with_index do |node, index|
      result << { node: node.key, parent: node.parent&.key, left: node.left&.key, right: node.right&.key }
    end
    result
  end

  private

    def splay(node)
      while !node.root? do
        parent = node.parent
        if parent.root?
          node.rotate
        elsif node.zigzig?
          parent.rotate
          node.rotate
        else
          node.rotate
          node.rotate
        end
      end
      @root = node
    end

end
