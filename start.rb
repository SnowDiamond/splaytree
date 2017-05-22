require_relative 'lib/splay_tree'
require 'pry'
require 'benchmark'

# [10, 50, 40, 20, 30, 35, 25, 20, 20, 45, 60, 75, 55, 42, 47, 32]

pry binding

max = 10**5
$count = 100

# Random numbers for test cases
$numbers = (1..$count).to_a.shuffle
# Prepare array
$list = (1..max).to_a.shuffle
# Prepare tree
$tree = SplayTree.new
$list.each { |n| $tree[n] = n.to_s }


def test_list
  # find random 100 element
  # find same element 100 times
  # insert 100 elements to the end
  # insert 100 elements to random indices
  # remove elements at 100 random indices
  # find max 1 time
  # find max 100 times
  # find greater than 100 random elements
  # find floor of 100 random elements
end

def test_tree
  # find random 100 element
  # find same element 100 times
  # insert 100 elements
  # remove 100 random elements
  # find max 1 time
  # find max 100 times
  # find greater than 100 random elements
  # find floor of 100 random elements
end

Benchmark.bmbm do |x|
  x.report('list') { test_list }
  x.report('tree') { test_tree }
end
