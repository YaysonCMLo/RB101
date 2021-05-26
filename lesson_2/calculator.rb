#get numbers from user 

puts "Enter first number"
a = gets.chomp.to_i

puts "Enter second number"
b = gets.chomp.to_i

#get operation from user

puts "Which operation would you like to do?"
o = gets.chomp

#do what the user asks

case o
  when "+" then r = a+b
  when "-" then r = a-b
  when "*" then r = a*b
  when "/" then r = a.to_f/b.to_f
  else r = "Error!"
end

#return the result

puts "#{a} #{o} #{b} = #{r}"