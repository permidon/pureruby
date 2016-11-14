cart = {} # Корзина
tot = 0 # Итог

loop do
  prch = {} # Пара цена-количество

  puts "Enter product name ('stop' to exit):"
  prodct = gets.chomp

  break if prodct.downcase == 'stop'

  puts "Enter item price ($):"
  price = gets.to_f
  puts "Enter quantity:"
  qty = gets.to_f

  prch[price] = qty
  cart[prodct] = prch
end

if cart == {} # Проверка на пустую корзину
  puts "Your cart is empty!"
  exit
end

puts
puts "That's how your cart looks now:"
puts cart
puts
puts "Products price: "

cart.each do | prd, pair|
  pair.each do |cost, q|
    puts "#{prd} costs $#{cost * q}"
    tot += cost * q
  end
end

puts
puts "Total: $#{tot}"
