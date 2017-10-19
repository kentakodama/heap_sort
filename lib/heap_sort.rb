require_relative "heap"

class Array
  def heap_sort!

    heap = BinaryMinHeap.new
    self.each do |num|
      heap.push(num)
    end

    heap.count.times do |i|
      self[i] = heap.extract
    end
    self
  end
end
