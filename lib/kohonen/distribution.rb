module Distribution
  
  def distribute(start_value, end_value, array_size, want_ints)
    diff = 1.0 * (end_value - start_value)
    n = [array_size-1, 1].max
    
    (0..(array_size-1)).map { |i|
        v = start_value + i * diff / n
        want_ints ? v.round : v
    }    
  end
  
  
  @@start_alpha = 999999999
  @@end_alpha = 1
  @@max_times = 1000000

  def test_array
    a = distribute( @@start_alpha, @@end_alpha, @@max_times, true )
    @@max_times.times do |r|
      a[r]
    end
  end

  def test_runtime
    diff = 1.0 * (@@end_alpha - @@start_alpha)
    n = [@@max_times-1, 1].max
    want_ints = true
    
    @@max_times.times do |i|
      v = @@start_alpha + i * diff / n
      want_ints ? v.round : v
    end
  end
  
end
