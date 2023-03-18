#Прямоугольный треугольник - определяет, является ли треугольник прямоугольным, равнобедренным или равносторонним
puts "Введите размер первой стороны треугольника"
a = gets.to_f
puts "Введите размер второй стороны треугольника"
b = gets.to_f
puts "Введите размер третьей стороны треугольника"
c = gets.to_f
    
abort("Треугольник не существует") if a + b < c || a + c < b || b + c < a
    max = [a, b, c].sort

puts "Треугольник равносторонний" if a == b && b == c

puts "Треугольник и равнобедренный и прямоугольный" if max[2] ** 2 == max[0] ** 2 + max[1] ** 2 && (a == b && a != c || a == c && a != b || b == c && b != a)

puts "Треугольник равнобедренный" if a == b && a != c || a == c && a != b || b == c && b != a

puts "Треугольник прямоугольный" if max[2] ** 2 == max[0] ** 2 + max[1] ** 2