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




## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SnowDiamond/splaytree. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

