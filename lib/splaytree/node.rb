class Splaytree
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

    def duplicates?
      !@duplicates.empty?
    end

    def root?
      parent.nil?
    end

    def parent_root?
      parent && parent.root?
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

    def rotate
      parent = self.parent
      gparent = self.gparent
      if gparent
        if parent.object_id == gparent.left.object_id
          gparent.set_left(self)
        else
          gparent.set_right(self)
        end
      else
        self.parent = nil
      end

      if object_id == parent.left.object_id
        parent.set_left(right)
        set_right(parent)
      else
        parent.set_right(left)
        set_left(parent)
      end
    end

    def zigzig?
      (object_id == parent.left.object_id && parent.object_id == gparent.left.object_id) ||
        (object_id == parent.right.object_id && parent.object_id == gparent.right.object_id)
    end

    def to_s
      key.to_s
    end

    def to_h
      { key => value }
    end
    alias_method :to_hash, :to_h

    def to_a
      [key, value]
    end

    def <=>(other)
      return unless other
      key <=> other.key
    end

  end
end
