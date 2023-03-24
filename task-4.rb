# Заполнить хеш гласными буквами, где значением будет являтся 
# порядковый номер буквы в алфавите (a - 1)

# для латиницы
hash = {}
array_letters = ("a".."z").to_a
letter = ['a','e','y','u','i','o']
array_letters.each_index do |i|
    letter.each_index do |e|
        if array_letters[i] == letter[e]
            hash[array_letters[i]] = i + 1
        end
    end
end
puts hash
# для киррилицы
hash_rus = {}
array_letters_rus = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'.chars
letter_rus = ['а', 'я', 'у', 'ю', 'о', 'е', 'ё', 'э', 'и', 'ы']
array_letters_rus.each_index do |i|
    letter_rus.each_index do |e|
        if array_letters_rus[i] == letter_rus[e]
            hash_rus[array_letters_rus[i]] = i + 1
        end
    end
end
puts hash_rus


