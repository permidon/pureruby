puts "Введите длину стороны A треугольника:"
a = gets.to_f
puts "Введите длину стороны B треугольника:"
b = gets.to_f
puts "Введите длину стороны C треугольника:"
c = gets.to_f

sides = [a, b, c].sort

if ( sides[0] ** 2 + sides[1] ** 2 ) == ( sides[2] ** 2 ) && ( sides[0] == sides[1] && sides[1] != sides[2] )
    puts "Ваш треугольник - прямоугольный и равнобедренный"
elsif ( sides[0] ** 2 + sides[1] ** 2 ) == ( sides[2] ** 2 )
    puts "Ваш треугольник - прямоугольный"
elsif sides[0] == sides[1] && sides[1] == sides[2]
    puts "Ваш треугольник - равносторонний"
elsif sides[0] == sides[1] && sides[1] != sides[2]
    puts "Ваш треугольник - равнобедренный"
else puts "Ваш треугольник - обычный"
end
