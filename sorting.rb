#! /usr/bin/ruby

class Array
  # implementation based on https://rosettacode.org/wiki/Sorting_algorithms/Radix_sort
  def radix_sort(base=10)
    ary = dup
    rounds = (Math.log(ary.minmax.map(&:abs).max)/Math.log(base)).floor + 1
    rounds.times do |i|
      buckets = Array.new(2*base){[]}
      base_i = base**i
      ary.each do |n|
        digit = (n/base_i) % base
        digit += base if 0<=n
        buckets[digit] << n
      end
      ary = buckets.flatten
      p [i, ary] if $DEBUG
    end
    ary
  end
  def radix_sort!(base=10)
    replace radix_sort(base)
  end
end

def bubble_sort(array)
  n = array.length
  loop do
    swapped = false

    (n-1).times do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        swapped = true
      end
    end

    break if not swapped
  end

  array
end

#implementation based from https://www.sitepoint.com/sorting-algorithms-ruby/
def mergesort(array)
  def merge(left_sorted, right_sorted)
    res = []
    l = 0
    r = 0

    loop do
      break if r >= right_sorted.length and l >= left_sorted.length

      if r >= right_sorted.length or (l < left_sorted.length and left_sorted[l] < right_sorted[r])
        res << left_sorted[l]
        l += 1
      else
        res << right_sorted[r]
        r += 1
      end
    end

    return res
  end

  def mergesort_iter(array_sliced)
    return array_sliced if array_sliced.length <= 1

    mid = array_sliced.length/2 - 1
    left_sorted = mergesort_iter(array_sliced[0..mid])
    right_sorted = mergesort_iter(array_sliced[mid+1..-1])
    return merge(left_sorted, right_sorted)
  end

  mergesort_iter(array)
end

num = 1
numbers = []
200.times do
  num = num + 5
  numbers << num
end

file1 = File.open('./radix_sort_results.csv', 'w')
file2 = File.open('./bubble_sort.csv', 'w')
file3 = File.open('./mergesort.csv', 'w')
numbers.each do |n|
  data =* (1..(2*n))
  data.shuffle!.slice!(0, n)

  t1 = Time.now
  sorted_arr = data.radix_sort
  t2 = Time.now
  delta = t2 - t1 # in seconds
  file1.write("#{n}, #{delta}\n")

  t1 = Time.now
  sorted_arr = mergesort(data)
  t2 = Time.now
  delta = t2 - t1 # in seconds
  file3.write("#{n}, #{delta}\n")

  t1 = Time.now
  sorted_arr = bubble_sort(data)
  t2 = Time.now
  delta = t2 - t1 # in seconds
  file2.write("#{n}, #{delta}\n")
  puts n
end
