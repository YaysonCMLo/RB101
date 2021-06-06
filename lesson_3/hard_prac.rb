# q1

# Error message - variable not found
# incorrect - the variable exists, there is no value (because it was initialized in the if block)

# q2
# greeting should == hi there as well, since informal greeting refers to it?

# Q3
# A - one is one ; two is two ; three is three
# The method creates new variables one, two and three within the scope of the method but not outside

# B - same as #A, for the same reason

# C - one is two ; two is three ; three is one
# In this case we are executing methods on the specific variable reference (gsub) which will mutate the object passed in

# Q4
# 

=begin
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break unless is_an_ip_number?(word)
  end
  return true
end

=end

# return false condition
# check size of the string

def dot_separated_ip_address?(input_string)
  
  dot_separated_words = input_string.split(".")

  return false if dot_separated_words != 4
  
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    
    if is_an_ip_number(word) == false
      return false
    end
  end
  
  return true
  
end