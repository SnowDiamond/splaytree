class SplayTree
  class Node
    include Comparable

    attr_reader :key, :value
    attr_accessor :left, :right, :parent

    def initialize(key, value, parent = nil, left = nil, right = nil)
      @key = key
      @value = value
      @parent = parent
      @left = left
      @right = right
    end

    def left_empty?
      left.nil?
    end

    def right_empty?
      right.nil?
    end

    def root?
      parent.empty?
    end

    def parent_root?
      parent && parent.root?
    end

    def insert(node)
      if node < self
        @left ? @left.insert(node) : set_left(node)
      else
        @right ? @right.insert(node) : set_right(node)
      end
    end

    def set_left(node)
      @left = node
      node.parent = @left
    end

    def set_right(node)
      @right = node
      node.parent = @right
    end

    def <=>(node)
      self.value <=> node.value
    end

  end
end
