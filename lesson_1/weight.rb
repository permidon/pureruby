puts "Введите ваше имя:"
user_name = gets.chomp
puts "Введите свой рост:"
user_height = gets.to_i
ideal_weight = user_height - 110

if ideal_weight >= 0
	puts "#{user_name}, ваш оптимальный вес #{ideal_weight} кг."
else
    puts "#{user_name}, ваш вес уже оптимальный"
end
