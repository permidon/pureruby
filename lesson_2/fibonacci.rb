fibonacci = []

while fibonacci.length < 2 || ( fibonacci.last + fibonacci[-2]) < 100
  if fibonacci.length == 0
    fibonacci << 0
  elsif fibonacci.length == 1
    fibonacci << 1
  else
    fibonacci << ( fibonacci.last + fibonacci[-2])
  end
end

puts fibonacci
