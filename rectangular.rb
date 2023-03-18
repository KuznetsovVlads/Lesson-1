#Прямоугольный треугольник - определяет, является ли треугольник прямоугольным, равнобедренным или равносторонним
puts "Введите размер первой стороны треугольника"
a = gets.to_f
puts "Введите размер второй стороны треугольника"
b = gets.to_f
puts "Введите размер третьей стороны треугольника"
c = gets.to_f
if a + b > c && a + c > b && b + c > a
    
    right = a == b && b == c
    
    max = [a, b, c].sort

    rectangle = max[2] ** 2 == max[0] ** 2 + max[1] ** 2
    
    isosceles = a == b && a != c || a == c && a != b || b == c && b != a
    
    both = false

    if rectangle && isosceles
        if a == b || b == c || c == a
            both = true
        end
    end

    case 
        when both
            puts "Треугольник и равнобедренный и прямоугольный"
        when right 
            puts "Треугольник равносторонний"
        when isosceles
            puts "Треугольник равнобедренный"
        when rectangle
            puts "Треугольник прямоугольный"
        else
            puts "Это обычный треугольник"
    end
    
else
    puts "Треугольник не существует"

end
