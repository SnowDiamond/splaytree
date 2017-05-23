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

## Usage

Before any actions initialize your splay tree:

```ruby
tree = Splaytree.new
```

### Insert items

Allowed any objects untill they are comprable.

```ruby
tree.insert(10, '10')
# or
tree[50] = '50'
tree.size # => 2

items = [40, 20, 30, 35, 25, 20, 20, 45, 60, 75, 55, 42, 47, 32]
items.each { |i| tree[i] = i.to_s }
tree.size # => 16
```

Each new item should comparable with already inserted items.

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

Note, that after each query tree change it's structure and last accessed node become root:

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


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SnowDiamond/splaytree. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

