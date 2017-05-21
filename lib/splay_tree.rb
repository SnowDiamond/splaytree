require_relative 'splay_tree/node'
require 'pry'

class MySplayTree
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
    return false unless node.valid?
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
    stack = [@root]
    loop do
      node = stack.pop
      break unless node
      node.right && stack.push(node.right)
      node.left && stack.push(node.left)
      node.duplicates.each do |value|
        stack.push(Node.new(node.key, value, node))
      end
      yield(node)
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
        gparent = node.gparent
        if parent.root?
          rotate(node, parent)
        elsif zigzig?(node)
          rotate(parent, gparent)
          rotate(node, parent)
        else
          rotate(node, parent)
          rotate(node, gparent)
        end
      end
      @root = node
    end

    def zigzig?(node)
      parent = node.parent
      return unless parent
      (node.is_left_child? && parent.is_left_child?) ||
        (node.is_right_child? && parent.is_right_child?)
    end

    def rotate(child, parent)
      gparent = child.gparent
      if gparent
        if parent.object_id == gparent.left.object_id
          gparent.set_left(child)
        else
          gparent.set_right(child)
        end
      else
        child.parent = nil
      end

      if child.object_id == parent.left.object_id
        parent.set_left(child.right)
        child.set_right(parent)
      else
        parent.set_right(child.left)
        child.set_left(parent)
      end
    end

end
