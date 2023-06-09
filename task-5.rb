# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть высокосным.

# массив дней в месяцах. По умолчанию считаем, что год высокосный
days_in_month = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "введите число от 1 до 31"
day = gets.to_i
abort "Такого числа не существует" if day < 1 || day > 31

puts "введите месяц (например 11)"
month = gets.to_i
abort "Такого месяца не существует" if month <= 0 || month > 12
abort "Число больше чем количество дней в этом месяце" if day > days_in_month[month]

puts "введите год (например 2023)"
year = gets.to_i
abort "Такого года не существует" if year < 1
# проверка на высокосность
full_year =  year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)

# проверка на количество дней февраля в этом году
abort "В этом году в феврале всего 28 дней" if month == 2 && day == 29 && !full_year

ordinal_date = day + days_in_month.take(month).sum if full_year || month < 3
ordinal_date = day + days_in_month.take(month).sum - 1 if month >= 3  && !full_year
puts
puts "порядковый номер даты: #{ordinal_date}"
