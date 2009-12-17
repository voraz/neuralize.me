class SOM
	attr_reader :map, :iteration, :width, :height, :input_size, :volume, :area, :distances
	attr_accessor :neighborhood_function, :learning_restraint_function, :samples
	def initialize(input_size, width, height, samples = [], neighborhood_function = SOM.method('neighborhood_bubble'), learning_restraint_function = SOM.method('learning_gaussian'))
		@samples, @neighborhood_function, @learning_restraint_function = samples, neighborhood_function, learning_restraint_function
		@height, @width, @input_size = height, width, input_size
		@iteration = 0
		if (@samples.size == 0)
			@map = Array.new(@height).collect { Array.new(@width).collect { Array.new(@input_size).collect { rand - 0.5 } } }	#Random Initialization
		else
			@map = Array.new(@height).collect { Array.new(@width).collect { samples[(rand*(samples.size-1)).round].clone } }	#Sample Initialization
		end
		@area = (@width * @height).to_f
		@volume = @area * @input_size
	end
	
	def run(n=1)
		return if @samples.empty?
		n.times {
			input(@samples[(rand*(@samples.size-1)).round])
		}
	end
	
	def input(input_values)
		@iteration += 1
		x = y = line = nil
		i = j = k = d = factor = neighbor = unit = 0
		@distances = @map.collect {|x|
			x.collect {|y|
				d = 0
				y.each_index {|i|
					d += (y[i] - input_values[i]).abs
				}
				d
			}
		}
		min = winner_pos = nil
		@distances.each_index {|i|
			line = @distances[i]
			line.each_index {|j|
				unit = line[j]
				if (min == nil || unit < min)
					min = unit
					winner_pos = [i,j]
				end
			}
		}
		winner_vector = @map[winner_pos[0]][winner_pos[1]]
		lambda = @learning_restraint_function.call(self)
		@map.each_index {|i|
			line = @map[i]
			line.each_index {|j|
				unit = line[j]
				neighbor = @neighborhood_function.call(self,winner_pos[0],winner_pos[1],i,j)
				factor = lambda * neighbor
				unit.each_index {|k|
					unit[k] += factor * (input_values[k] - unit[k])
				}
			}
		}
		winner_vector
	end
	
	def SOM.neighborhood_bubble(som,x1,y1,x2,y2)
		dist = (x1 - x2).abs + (y1 - y2).abs	#Manhatan Distance
		return 1 if (dist == 0)
		return 0.9 if (dist < som.area/som.iteration)
		0
	end

	def SOM.neighborhood_gaussian(som,x1,y1,x2,y2)
		dist = (x1 - x2)**2 + (y1 - y2)**2		#Euclidean Distance²
		Math.exp(-som.iteration*dist/(som.area*2))
	end

	def SOM.learning_gaussian(som)
		Math.exp(-som.iteration/som.volume)
	end
	
end
=begin
#EXAMPLE
require 'tk'
WIDTH, HEIGHT = 32, 32
SIDE = (WIDTH + HEIGHT)>>1
SQUARE_SIZE = (128 / SIDE).round
samples = Array.new
3.times {|r| 3.times {|g| 3.times {|b| samples << [r-1,g-1,b-1] } } }
som = SOM.new(3,WIDTH,HEIGHT,samples)
som.neighborhood_function = SOM.method('neighborhood_gaussian')
root = TkRoot.new { title 'SOM'}
canvas = TkCanvas.new(root)
canvas.pack
canvas.height, canvas.width = HEIGHT * SQUARE_SIZE - 1, WIDTH * SQUARE_SIZE-1
canvas.background = 'black'
x = t = pos_i1 = pos_i2 = pos_j1 = pos_j2 = 0
line = mapline = unit = nil
point = som.map.clone.collect {|x| x.collect { nil } }
(samples.size).times {|t|
	som.run(SIDE>>1)
#=begin
#Graphical Output
	som.map.each_index {|i|
		pos_i1 = i*SQUARE_SIZE+1
		pos_i2 = pos_i1 + SQUARE_SIZE.succ
		line = point[i]
		mapline = som.map[i]
		mapline.each_index {|j|
			pos_j1 = j*SQUARE_SIZE+1
			pos_j2 = pos_j1 + SQUARE_SIZE.succ
			line[j].delete if (line[j] != nil)
			unit = mapline[j]
			line[j] = TkcRectangle.new(canvas, pos_j1,pos_i1,pos_j2,pos_i2,'outline' => '','fill' => sprintf('#%02x%02x%02x',((unit[0]+1)*127.5).round,((unit[1]+1)*127.5).round,((unit[2]+1)*127.5).round))
		}
	}
	Tk.update
#=end
	puts 'Iteration: '+som.iteration.to_s
}
puts 'Completed'
Tk.mainloop
=end