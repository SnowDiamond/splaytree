require_relative 'lib/splay_tree'
require 'benchmark'

max = 10**5
$count = 1000

# Random numbers for test cases
$numbers = (1..$count).to_a.shuffle
# Prepare array
$list = (1..max).to_a.shuffle
# Prepare tree
$tree = SplayTree.new
$list.each { |n| $tree[n] = n.to_s }


def test_list
end

def test_tree
  # $count.times { $tree[33] }
  $numbers.each_with_index { |n| $tree[n] }
end

Benchmark.bmbm do |x|
  x.report('list') { test_list }
  x.report('tree') { test_tree }
end
