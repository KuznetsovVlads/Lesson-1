# Заполнить хеш гласными буквами, где значением будет являтся 
# порядковый номер буквы в алфавите (a - 1)

# для латиницы
hash = {}
array_letters = ("a".."z").to_a
letter = ['a','e','y','u','i','o']
array_letters.each_index do |i|
    if letter.include?(array_letters[i]) #проверяю есть ли буква в массиве гласных 
        hash[array_letters[i]] = i + 1
    end
end
puts hash
# для киррилицы
hash_rus = {}
array_letters_rus = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'.chars
letter_rus = ['а', 'я', 'у', 'ю', 'о', 'е', 'ё', 'э', 'и', 'ы']
array_letters_rus.each_index do |i|
    if letter_rus.include?(array_letters_rus[i])
        hash_rus[array_letters_rus[i]] = i + 1
    end
end
puts hash_rus


