require_relative 'splay_tree/node'

class SplayTree
  def initialize
    @size = 0
  end

  def size
    @size
  end
  alias_method :length, :size

  def root
    @root
  end

  def empty?
    @root.nil?
  end

  def find(key)
    splay(key)
  end

  def insert(key, value)
    node = Node.new(key, value)
    unless self.empty?
      # validate(node) if key already exists
      @root.insert(node)
      splay(node)
    end
    @root = node
    @size += 1
    return true
  end

  def remove(key)
  end

  def splay(node)
  end

end

tree = SplayTree.new
p tree
tree.insert('my-key', 12)
p tree
p tree.root
pry binding
