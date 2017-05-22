$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'splaytree'

require 'minitest/autorun'
require "minitest/reporters"

Minitest::Reporters.use!

NODES = (1..1000).to_a.shuffle.map { |n| [n, n.to_s] }
NODES_KEYS = NODES.map { |i| i[0] }.sort
NODES_VALUES = NODES.map { |i| i[1] }.sort
STRUCTURED_NODES = [10, 50, 40, 20, 30, 35, 25, 20, 20, 45, 60, 75, 55, 42, 47, 32].to_a.map { |n| [n, n.to_s] }
STRUCTURED_NODES_KEYS = STRUCTURED_NODES.map { |i| i[0] }.sort
STRUCTURED_NODES_VALUES = STRUCTURED_NODES.map { |i| i[1] }.sort

DUPLICATE_NODES = [
  [10, '10'],
  [20, '20.1'],
  [20, '20.2'],
  [20, '20.3'],
  [20, '20.4'],
  [20, '20.5'],
  [70, '70'],
  [80, '80'],
  [90, '90']
]

DUPLICATE_NODES_KEYS = DUPLICATE_NODES.map { |i| i[0] }.sort
DUPLICATE_NODES_VALUES = DUPLICATE_NODES.map { |i| i[1] }.sort
