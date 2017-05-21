class MySplayTree
  class Node
    include Comparable

    attr_reader :key
    attr_accessor :value, :left, :right, :parent, :duplicates

    def initialize(key, value = nil, parent = nil, left = nil, right = nil)
      @key = key
      @value = value
      @parent = parent
      @left = left
      @right = right
      @duplicates = []
    end

    def add_duplicate!(value)
      @duplicates.push(@value)
      @value = value
    end

    def remove_duplicate!
      return if @duplicates.empty?
      deleted = @value
      @value = @duplicates.pop
      deleted
    end

    def has_duplicates?
      @duplicates.length > 0
    end

    def root?
      parent.nil?
    end

    def parent_root?
      parent && parent.root?
    end

    def is_left_child?
      parent && parent.left.object_id == self.object_id
    end

    def is_right_child?
      parent && parent.right.object_id == self.object_id
    end

    def gparent
      parent && parent.parent
    end

    def set_left(node)
      @left = node
      return unless node
      node.parent = self
    end

    def set_right(node)
      @right = node
      return unless node
      node.parent = self
    end

    # def rotate(node)
    #   if gparent
    #     if gparent.left == node
    #       gparent.set_left(self)
    #     else
    #       gparent.set_right(self)
    #     end
    #   else
    #     self.parent = nil
    #   end
    #   if node.left == self
    #     node.set_left(self.right)
    #     self.set_right(node)
    #   else
    #     node.set_right(self.left)
    #     self.set_left(node)
    #   end
    # end

    # def zigzig?
    #   (is_left_child? && parent.is_left_child?) || (is_right_child? && parent.is_right_child?)
    # end

    def to_s
      # { key: key, value: value }.to_s
      key.to_s
    end

    def to_h
      { key => value }
    end
    alias_method :to_hash, :to_h

    def to_a
      [key, value]
    end

    def <=>(node)
      return unless node
      self.key <=> node.key
    end

    def valid?
      # Add validation for comparable
      true
    end

  end
end
