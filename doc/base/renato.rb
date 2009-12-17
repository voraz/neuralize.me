def colorize(text, color_code)
   "#{color_code}#{text}\e[0m"
end
 
def red(text); colorize(text, "\e[31m"); end
def green(text); colorize(text, "\e[32m"); end
def yellow(text); colorize(text, "\e[43m"); end
def white(text); colorize(text, "\e[37m"); end

w = Array.new(10){rand(10)} #matriz de pesos de cada neuronio
dist = Array.new(10) #distancia entre a entrada e cada neuronio
entradas = Array.new(500){rand(10)} #valores a serem apresentados
x = 0 #valor da entrada atual
dmin = 0 #menor distancia encontrada
alfa = 2 #taxa de aprendizagem
jmin = 0 #neuronio com menor distancia
range = 2 #tamanho da vizinhança
minimo = 0 #primeiro neuronio da vizinhanca a aprender
maximo = 0 #último neuronio da vizinhanca a aprender

p w
p entradas

#treinamento da rede
500.times do |i|
   x = entradas[i] #pega a entrada atual~
   jmin = 1 #primeiro peso é supostamente o mais próximo
   dmin = x-w[1] #o promeiro tem a discancia maxima
   dist[1] = dmin
   
   #pegar o mais próximo
   for j in 2..9 do
     dist[j] = x-w[j]
     if dist[j].abs < dmin.abs
       jmin = j
       dmin = dist[j]
     end
   end
   
   st = "passo: #{i}    x: #{x} \t prox: #{w[jmin].to_i} \t"
  
  
  #{mostrar vetor w, sendo verde o vencedor, amarelo seus vizinhos, 
  #magenta o limite da vizinhanca e branco os neuronios fora da vizinhanca
  for k in 1..9 do
    if (k-jmin).abs==2 && range==2  
      st += red(w[k].to_i)
    elsif (k-jmin).abs==1
      st += yellow(w[k])      
    elsif k==jmin
      st += green(w[k])      
    else
      st+=white(w[k])
    end
    st+=" | "
  end
  puts st
  
  #aprendizado: determinar minimo e maximo a aprender
  jmin-range<1  ? minimo=1  : minimo=jmin-range
  jmin+range>10 ? maximo=10 : maximo=jmin+range
  
  #aprendizado: acertar pesos
  for j in minimo..maximo-1 do
    w[j] = w[j]+alfa*dist[j] if j>=1 && j<=10
  end
  
  #diminuir a vizinhança
  if i>200
    range = 1
    alfa = 1
  end
  
end