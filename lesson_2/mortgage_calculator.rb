# collect information from the user
# validate numbers / time frames that they've provided
# calculate deliverables - 1) Monthly rate 2) Month duration 3) monthly payment

# collect inputs

def prompt(string)
  puts "==> #{string}"
end

def num_check(message) # This will fail if we receive a float
  prompt("What is the #{message}")
  valid = false
  until valid
    x = gets.chomp
    if x.to_i.to_s == x
      valid = true
      return x
    end
  prompt('Invalid number, please try again')
  end
end

# need to validate these numbers
loan_amt = num_check("Loan Amount").to_i
interest_year = num_check('Annual Percentage Rate').to_f/100
duration_year = num_check('Loan duration (full years)').to_i

prompt("Are there any additional months (i.e. partial years). Y if yes")
months_add = gets.chomp
months_add.downcase == 'y' ? duration_month = num_check('Loan duration (months in partial year)').to_i : duration_month = 0

# calculate the inputs to the mortgage rate

interest_month = interest_year / 12
duration_month += duration_year * 12
payment_month  = loan_amt * (interest_month / (1 - (1 + interest_month)**(-duration_month)))

invoice = <<-MSG
==> Your monthly payment is $#{format('%.2f',payment_month.round(2))}
==> Total cost of the loan is $#{format('%.2f',payment_month * duration_month)}
==> You are paying $#{format('%.2f',payment_month * duration_month - loan_amt)} in interest!
MSG

puts invoice
