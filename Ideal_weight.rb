puts "Расчитаем ваш идеальный вес"
puts "Введите ваше имя"
name = STDIN.gets.chomp
puts "Введите ваш рост в сантиметрах"
height = STDIN.gets.to_i
ideal = (height - 110) * 1.15

if ideal < 0
    puts "Ваш вес уже оптимальный"
else
    puts "#{name}, ваш идеальный вес #{ideal.round(0)} килограмм"
end