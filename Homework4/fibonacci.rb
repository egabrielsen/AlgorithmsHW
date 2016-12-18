def fib_rec(n)
  n <= 1 ? 1 :  fib_rec( n - 1 ) + fib_rec( n - 2 )
end

def fib_it(n, sequence=[1])
  n.times do
    current_number, last_number = sequence.last(2)
    sequence << current_number + (last_number or 0)
  end

  sequence.last
end

fib = Hash.new do |f, n|
  f[n] = if n <= -2
           (-1)**(n + 1) * f[n.abs]
         elsif n <= 1
           1
         else
           f[n - 1] + f[n - 2]
         end
end

nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 30]

nums.each do |n|
  start_time = Time.now
  fib_rec(n)
  end_time = Time.now
  # puts n

  start_time = Time.now
  # fib_it(n)
  puts fib[10]
  end_time = Time.now
  # puts end_time - start_time
end
