#Идеальный вес
puts "Расчитаем ваш идеальный вес"
puts "Введите ваше имя"
name = gets.chomp
puts "Введите ваш рост в сантиметрах"
height = gets.to_f
ideal = (height - 110) * 1.15

if ideal < 0
    puts "Ваш вес уже оптимальный"
else
    puts "#{name}, ваш идеальный вес #{ideal} килограмм"
end