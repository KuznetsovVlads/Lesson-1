# Заполнить массив числами  Фибоначчи до 100
# Последовательность чисел Фибоначчи определяется формулой Fn = Fn-1 + Fn-2 

fibonacci = [0, 1] # начальные числа Фибоначчи
i = 1

while fibonacci[i] < 100
  i += 1
  fibonacci[i] = fibonacci[i-1] + fibonacci[i-2]
end
