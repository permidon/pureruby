puts "Enter day:"
d = gets.to_i
puts "Enter month:"
m = gets.to_i
puts "Enter year:"
y = gets.to_i

# Проверка на откровенно неправильные данные, без анализа года и числа дней в месяце
if m < 1 || m > 12 || d < 1 || d > 31 || ( m == 2 && d > 29 ) || y == 0
  puts "Invalid data! Try again, please."
  exit
end

serial = d

first_half = [1, 2, 3, 4, 5, 6, 7] # Первая часть чередующихся месяцев
second_half = [8, 9, 10, 11, 12] # Вторая часть чередующихся месяцев

first_half.each do |i|
  if i < m && i.odd?
    serial += 31
  elsif i < m && i.even?
    serial += 30
  end
end

second_half.each do |i|
  if i < m && i.even?
    serial += 31
  elsif i < m && i.odd?
    serial += 30
  end
end

# Февраль
if y % 4 == 0 && y % 100 != 0 && m > 2 || y % 400 == 0 && m > 2 # Високосный год после марта
  serial = serial - 1
elsif m > 2 # Обычный год после марта
  serial = serial - 2
end

puts "#{serial}"

