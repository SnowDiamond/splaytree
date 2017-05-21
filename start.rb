require_relative 'lib/splay_tree'
require 'benchmark'
require 'splay_tree'
require 'pry'

max = 10**5

$list = (1..max).to_a.shuffle
$his_tree = SplayTree.new
$my_tree = MySplayTree.new

$list.each { |n| $his_tree[n] = n.to_s }
$list.each { |n| $my_tree[n] = n.to_s }

$count = 100
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
