module Print
  include Distance

  @@console_green  = "\e[1m\e[32m"
  @@console_yellow = "\e[1m\e[33m"
  @@console_red    = "\e[1m\e[31m"
  @@console_pur    = "\e[1m\e[35m"
  def colorize(text, color_code) "#{color_code}#{text}\e[0m"; end

  def array_out(array, decimal=2, tabs=0)
    st = ""
    array.each do |i|
      if i.class==Array
        #st += "\t"*tabs+array_out(i, decimal,tabs)
        st += "  |  "+array_out(i, decimal,tabs)
      else
        st += "%0.#{decimal}f " % i rescue st+=i+"\t"
      end
    end
    st
  end

  def matrix_out(array, decimal=2, tabs=0)
    st = ""
    array.each do |i|
      if i[0].class == Array
        i.each { |j| st += array_out(j, decimal, tabs) }
      else
        st += array_out(i, decimal, tabs)
      end
      st += "\n"
    end
    st
  end

  def colorized_array_out(color, array)
    colorize(array_out(array),color)
  end

  def colorized(array, closer, range)
    st = ""

    array.each_index do |i|
      array[i].each_index do |j|

        color=""
        p = [i,j]

        distance = index_distance(closer, p)
        if in_range(p, closer, range)
          distance==0 ? color=@@console_green : color=@@console_yellow
        elsif distance==range+1
          color = @@console_pur
        end

        st += colorized_array_out(color, array[i][j])+"\t"
      end
      st +="\n"
    end

    puts st
  end

  def step(time, input, range, alpha)
    puts colorize("\n #####passo: #{time} \t\t x: #{array_out(input)} \t\t vizinhanca: #{range} \t\t alpha: #{alpha}", @@console_red)
  end


  def positions(positions, weights)

    array = Array.new(weights.size){Array.new(weights[0].size){0}}

    positions.sort_by{ |a,b| [a.point.x,a.point.y] }.each do |i|
      puts "#{i.point.x},#{i.point.y}     #{array_out(i.vo,0)}    "
      array[i.point.x][i.point.y] = array_out(i.vo,0)
    end

    puts matrix_out(array, 0)
  end


end

#puts Print.array_out( Array.new(10){rand(10)}, 2, 1 )

