# Splay Tree
Ruby implementation of [splay tree](https://en.wikipedia.org/wiki/Splay_tree).

Splay trees are designed to give especially fast access to entries that have been accessed recently, so they really excel in applications where a small fraction of the entries are the targets of most of the find operations.

## Installation

Install from RubyGems by adding it to your Gemfile, then bundling.

```ruby
# Gemfile
gem 'splaytree'
```

```
$ bundle install
```

## Getting Started

Before any actions initialize your splay tree:

```ruby
tree = Splaytree.new
```

### Insert items

You can insert any objects untill they are comparable.

```ruby
tree.insert(10, '10')
# or
tree[50] = '50'
tree.size # => 2
tree.empty? # => false

items = [40, 20, 30, 35, 25, 20, 20, 45, 60, 75, 55, 42, 47, 32]
items.each { |i| tree[i] = i.to_s }
tree.size # => 16
tree.keys # => [10, 20, 20, 20, 25, 30, 32, 35, 40, 42, 45, 47, 50, 55, 60, 75]
tree.values # => ['10', '20', '20', '20', '25', '30', '32', '35', '40', '42', '45', '47', '50', '55', '60', '75']
```

`Splaytree` class includes `Enumerable` module, so you can use all enumerable methods on tree instance.

Update inserted item:

```ruby
# WRONG
# tree[10] = 'ten' # inserted duplicated item with key 10
# tree.duplicates(10) # => ['10', 'ten']

# CORRECT
tree.update(10, 'ten') # => true
tree[10] # => 'ten'
```

### Get item

```ruby
tree.get(30) # => '30'
# or
tree[50]  # => '50'
tree[1000]  # => nil

tree.key?(60) # => true
tree.key?(0) # => false

# Get all values for duplicate items
tree.duplicates(20) => # ['20', '20', '20']
```

Note that after each query tree will change it's structure and last accessed node become root:

```ruby
tree[10]
tree.root.key # => 10

tree[75]
tree.root.key # => 75

# Even if key not found
tree[17]
tree.root.key # => 20
```

This is true also for other splay tree actions (insert, remove, max, min, etc).

### Remove item

```ruby
tree.size # => 16
tree.remove(30) # => '30'
tree.size # => 15
tree.key?(30) # => false
```

### Min and max

```ruby
tree.min # => 'ten'
tree.max # => '75'
```

Splay tree like others binary search trees especially good for fast queries:

```ruby
require 'benchmark'

list = (1..10**6).to_a.shuffle
tree = Splaytree.new
list.each { |n| tree[n] = n.to_s }

Benchmark.bmbm do |x|
  x.report('list_min') { list.min }
  x.report('tree_min') { tree.min }
  x.report('list_max') { list.max }
  x.report('tree_max') { tree.max }
end

# Rehearsal --------------------------------------------
# list_min   0.070000   0.000000   0.070000 (  0.069333)
# tree_min   0.000000   0.000000   0.000000 (  0.000049)
# list_max   0.060000   0.000000   0.060000 (  0.057221)
# tree_max   0.000000   0.000000   0.000000 (  0.000038)
# ----------------------------------- total: 0.130000sec
#
#                user     system      total        real
# list_min   0.060000   0.000000   0.060000 (  0.059667)
# tree_min   0.000000   0.000000   0.000000 (  0.000020)
# list_max   0.060000   0.000000   0.060000 (  0.055789)
# tree_max   0.000000   0.000000   0.000000 (  0.000020)
```

Of course, on your local machine scores will be different, but ratio will be same.
Note: this is also true for all listed below methods (`higher`, `lower`, `ceiling`, `floor`).

### Higher

Returns a key-value pairs associated with the least key strictly greater than the given key, or null if there is no such key:

```ruby
list = (1..1000).to_a.shuffle
tree = Splaytree.new
list.each { |n| tree[n] = n.to_s }

tree.higher(200) # => 201
tree.higher(200.5) # => 201
tree.higher(1000) # => nil
```

### Lower

Returns a key-value pairs associated with the greatest key strictly less than the given key, or null if there is no such key:

```ruby
# tree includes 1..1000 keys
tree.lower(200) # => 199
tree.lower(200.5) # => 200
tree.lower(1) # => nil
```

### Ceiling

Returns a key-value pairs associated with the least key greater than or equal to the given key, or null if there is no such key:

```ruby
# tree includes 1..1000 keys
tree.ceiling(200) # => 200
tree.ceiling(200.5) # => 201
tree.ceiling(1000) # => 1000
tree.ceiling(1001) # => nil
```

### Floor

Returns a key-value pairs associated with the greatest key less than or equal to the given key, or null if there is no such key:

```ruby
# tree includes 1..1000 keys
tree.floor(200) # => 200
tree.floor(200.5) # => 200
tree.floor(1) # => 1
tree.floor(0) # => nil
```

### Review tree structure

You can iterate all nodes in tree and build any data representation, however several methods already included:

```ruby
numbers = [1, 2, 3, 5, 6, 7, 4]
numbers.each { |n| tree[n] = n.to_s }

tree.report
# => [
#  {:node=>1, :parent=>2, :left=>nil, :right=>nil}
#  {:node=>2, :parent=>3, :left=>1, :right=>nil}
#  {:node=>3, :parent=>4, :left=>2, :right=>nil}
#  {:node=>4, :parent=>nil, :left=>3, :right=>6}
#  {:node=>5, :parent=>6, :left=>nil, :right=>nil}
#  {:node=>6, :parent=>4, :left=>5, :right=>7}
#  {:node=>7, :parent=>6, :left=>nil, :right=>nil}
#]

# Diplay turned tree structure:
tree.display
# =>
#
#          7
#     6
#          5
# 4
#     3
#          2
#               1

tree.height # => 4
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SnowDiamond/splaytree. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

