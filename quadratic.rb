#Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
#Если D > 0, то выводим дискриминант и 2 корня
#Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#Если D < 0, то выводим дискриминант и сообщение "Корней нет"
puts "Введите коэффициент А"
a = gets.to_f
puts "Введите коэффициент B"
b = gets.to_f
puts "Введите коэффициент C"
c = gets.to_f

d = b**2 - 4 * a * c # вычисляем дискриминант

if d > 0 
    x1 = (-b + Math.sqrt(d))/(2 * a)
    x2 = (-b - Math.sqrt(d))/(2 * a)
    puts "Корень X1 = #{x1.round(2)}, корень X2 = #{x2.round(2)}"
    puts "Дискриминант равен #{d}"

elsif d == 0
    puts "Дискриминант равен #{d}"
    x = -b / (2 * a)
    puts "Корень равен #{x}"
    puts "Дискриминант равен #{d}"
else
    puts "Корней нет"
end