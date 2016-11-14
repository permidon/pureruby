vowels = [ 'a', 'e', 'i', 'o', 'u', 'y'] #Согласно Википедии, Y - одновременно и гласный и согласный звук
alphabet = ('a'..'z').to_a
letters = {}

vowels.each do |key|
  if alphabet.include?(key)
    letters[key] = alphabet.index(key) + 1
  end
end

puts letters
