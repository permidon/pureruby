vowels = [ 'a', 'e', 'i', 'o', 'u', 'y'] # Согласно Википедии, Y - одновременно и гласный и согласный звук
alphabet = ('a'..'z')
letters = {}

# Если все же оставить преобразование range в array, то решение такое:
# alphabet = ('a'..'z').to_a
# vowels.each { |key| letters[key] = alphabet.index(key) + 1 }
# puts letters


# Если оставить range как есть, то не нашел ничего лучше этого:
alphabet.each_with_index { | key, ind | letters[key] = ind + 1 if vowels.include?(key) }

puts letters
