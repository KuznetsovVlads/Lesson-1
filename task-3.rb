# Заполнить массив числами  Фибоначчи до 100
# Последовательность чисел Фибоначчи определяется формулой Fn = Fn-1 + Fn-2 

fibonacci = [0, 1] # начальные числа Фибоначчи

loop do 
  fibonacci[fibonacci.size] = fibonacci[-1] + fibonacci[-2]
  break fibonacci.pop if fibonacci.last > 100
end

puts fibonacci