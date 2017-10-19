require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc


  def initialize(&prc)
    prc ||= Proc.new {|a, b| a <=> b}
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count-1] = @store[count-1], @store[0]
    last = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    last
  end

  def peek

  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count-1, count, &prc)

    # BinaryMinHeap.heapify_up(array, child_idx, len = array.length, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    first_child = (parent_index * 2) + 1
    second_child = (parent_index * 2) + 2

    return [first_child, second_child].select{|index| index < len}
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1)/2

  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)

    prc ||= Proc.new{|a, b| a <=> b}

    children_idx = BinaryMinHeap.child_indices(len, parent_idx)


    until children_idx.all? { |child_idx| prc.call(array[parent_idx], array[child_idx]) != 1}
      smaller_idx = children_idx.sort {|a, b| prc.call(array[a], array[b])}.first
      array[parent_idx], array[smaller_idx] = array[smaller_idx], array[parent_idx]
      parent_idx = smaller_idx
      children_idx = BinaryMinHeap.child_indices(len, parent_idx)
    end

    array

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)

    prc ||= Proc.new{|a, b| a <=> b}
    return array if child_idx == 0
    parent_idx = BinaryMinHeap.parent_index(child_idx)

    until prc.call(array[parent_idx], array[child_idx]) != 1 || child_idx == 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
      break if child_idx == 0
      parent_idx = BinaryMinHeap.parent_index(child_idx)

    end
    array

  end
end
