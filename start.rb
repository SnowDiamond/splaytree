require_relative 'lib/splay_tree'
require 'benchmark'
require 'splay_tree'
require 'pry'
require 'algorithms'

max = 10**5

$list = (1..max).to_a.shuffle
# $list = [10, 50, 40, 20, 30, 35, 25, 45, 60, 75, 55, 42, 47, 32]
$his_tree = Containers::SplayTreeMap.new
$my_tree = MySplayTree.new

$list.each { |n| $his_tree[n] = n.to_s }
$list.each { |n| $my_tree[n] = n.to_s }

$count = 1000
$numbers = (1..$count).to_a.shuffle

def test_tree
  # $count.times { $his_tree[33] }
  $numbers.each_with_index { |n| $his_tree[n] }
end


def test_my_tree
  # $count.times { $my_tree[33] }
  $numbers.each_with_index { |n| $my_tree[n] }
end

Benchmark.bmbm do |x|
  x.report('tree') { test_tree }
  x.report('my_tree') { test_my_tree }
end
