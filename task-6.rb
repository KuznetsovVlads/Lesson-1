# Сумма покупок. Пользователь вводит поочередно название товара, 
# цену за единицу и кол-во купленного товара (может быть нецелым числом). 
# Пользователь может ввести произвольное кол-во товаров до тех пор, 
# пока не введет "стоп" в качестве названия товара. 
# На основе введенных данных требуется:

# 1) Заполнить и вывести на экран хеш, ключами которого являются 
# названия товаров, а значением - вложенный хеш, содержащий цену 
# за единицу товара и кол-во купленного товара. 
# Также вывести итоговую сумму за каждый товар.
# 2) Вычислить и вывести на экран итоговую сумму всех покупок в "корзине"

# example hash check = {:product => {:price => amount}, :product2 => {:price => amount}}


check = {}
loop do 
    puts "Введите название товара"
    product = gets.chomp
    break if product == "stop"

    puts "Введите цену за единицу"
    price = gets.to_f
   
    puts "Введите кол-во купленного товара"
    amount = gets.to_f

    check[product] = {price => amount}
end
puts  #для удобства чтения информации в консоли
puts check.inspect
puts

sum = 0 # переменная в которой сумма за все товары
check.each do |product, hash_sum|
    cost = 0   
    hash_sum.each do |price, amount|
        sum += price * amount
        cost = price * amount
    end
    puts "Cумма за #{product} = #{cost}"
end

puts "Итоговая сумма всех покупок #{sum}"