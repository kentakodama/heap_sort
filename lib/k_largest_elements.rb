require_relative 'heap'
require_relative 'heap_sort'


def k_largest_elements(array, k)
  sorted = array.heap_sort!
  sorted[-k..-1]
end
