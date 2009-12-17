class OrganizedStudents
  
  @@dim_w = 10
  @@notas = 48
  @@n_entradas = 25
  @@n_epocas = 100
  @@range_inicial = 10
  @@range_final = 2
  
  @@w = Array.new(@@dim_w) {Array.new(@@dim_w) {Array.new(@@notas)} }
  @@entradas = Array.new(@@n_entradas) {Array.new(@@notas)}
  @@dist = Array.new(@@dim_w) {Array.new(@@dim_w)}
  
  def execute
    cria_mat_pesos
    cria_entradas
    treinar
  end
  
  
  def cria_mat_pesos
    nota_maxima = 10
    nota_minima = 5
    
    @@w.each { |a|
      p @@w.index(a)
      melhoria = @@w.index(a)/@@dim_w * (nota_maxima-nota_minima)
      a.each{ |b|
        b.each_index{ |c| 
          @@w[@@w.index(a)][a.index(b)][c] = nota_minima + melhoria + rand(nota_maxima-nota_minima) 
        }
      }
    }
  end
  
  def cria_entradas
    students = Student.all
    
    @@entradas.each_index{ |a|
      student = students[a]
      @@notas.times { |b|
        @@entradas[a][b] = student.notes[b].note
      }
    }
  end
  
  
  @@d_min = 99999.9

  @@l_min = 0
  @@minimo_l = 0
  @@maximo_l = 0

  @@c_min = 0
  @@minimo_c = 0
  @@maximo_c = 0
  
  
  def treinar
    range = @@range_inicial
    alfa = 0.05
    @@n_epocas.times{ |epoca|
      alfa = alfa*0.9999
      puts "\n Época "+epoca.to_s
      
      if epoca%1000==0 || epoca==@@n_epocas-1
        puts "\n\n =================================== epoca="+epoca.to_s+"==================================="
      end
      
      @@n_entradas.times { |ii| 
        i = 0;
        if epoca%1000==0 || epoca==@@n_epocas-1
          i = ii
        else
          i = rand(@@n_entradas-1)
        end
        
        buscar_mais_proximo(i)
        
        if epoca%1000==0 || epoca==@@n_epocas-1
          puts " passo: "+(i+1).to_s+
						"	range: "+range.to_s+
						"	entrada["+i.to_s+"]: "+
						"	mais próximo: w["+@@l_min.to_s+","+@@c_min.to_s+"]" + 
						"	distância: "+@@d_min.to_s+
						"	alfa: "+alfa.to_s+
						"\n"						
        end

        ajusta_limites(@@l_min, range, "l")
        ajusta_limites(@@c_min, range, "c")

        proximidade = epoca/@@n_epocas
        range = @@range_inicial - (@@range_inicial-@@range_final)*proximidade

        (@@minimo_l..@@maximo_l).each{ |l|
          (@@minimo_c..@@maximo_c).each { |c|
            chapeu = (@@l_min-1).abs + (@@c_min-c).abs
            if chapeu==0
              chapeu = l
            end

            @@notas.times { |nota|
              @@w[l][c][nota] = @@w[l][c][nota]+alfa / chapeu*(@@entradas[i][nota]-@@w[l][c][nota])
            }

          }
        }
      }
    }
  end
  
  def buscar_mais_proximo(i)
    @@l_min = 0
    @@c_min = 0;
    @@d_min = 99999.9
    
    @@dim_w.times{ |l|
      @@dim_w.times{ |c|
        @@dist[l][c]=distancia(l, c, i)
        if @@dist[l][c].abs < @@d_min.abs
          @@l_min = l
          @@c_min = c
          @@d_min = @@dist[l][c]
        end
      }
    }
  end
  
  def distancia(l, c, i)
    soma_dif = 0
    @@notas.times{ |nota|
      dif = @@w[l][c][nota] - @@entradas[i][nota]
      if dif<0
        dig = -dif
      end
      soma_dif = soma_dif + dif
    }
    soma_dif
  end
  
  def ajusta_limites(vencedor, range, tipo)
    min = 0
    max = 0
    
    if(vencedor-range<0)
      min = 0
    else
      min = vencedor-range
    end
    
    if vencedor+range>=@@dim_w
      max = @@dim_w-1
    else
      max = vencedor+range
    end
    
    if tipo=="l"
      @@minimo_l = min
      @@maximo_l = max
    else
      @@minimo_c = min
      @@maximo_c = min
    end
    
  end
  
  
  WIDTH, HEIGHT = 32, 32
  SIDE = (WIDTH + HEIGHT)>>1
  SQUARE_SIZE = (128 / SIDE).round
  
  def teste
    #EXAMPLE
    require 'tk'
    
    samples = cria_entradas
    #samples = Array.new
    #3.times {|r| 3.times {|g| 3.times {|b| samples << [r-1,g-1,b-1] } } }
    
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
=begin
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
=end
    	puts 'Iteration: '+som.iteration.to_s
    }
    puts 'Completed'
    Tk.mainloop
  end
  
  
  
end