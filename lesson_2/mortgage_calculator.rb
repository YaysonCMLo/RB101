# collect information from the user
# validate numbers / time frames that they've provided
# calculate deliverables - 1) Monthly rate 2) Month duration 3) monthly payment

# collect inputs

require 'yaml'
MESSAGES = YAML.load_file('mortgage_messages.yaml')

def prompt(string)
  puts "==> #{string}"
end

def string_check(input)
  input.empty? == false
end

def int_check(input)
  is_int = input.to_i.to_s == input
  non_zero = input.to_i != 0
  empty = input.empty? == false
  is_int && non_zero && empty
end

def float_check(input)
  non_zero = input.to_i != 0
  empty = input.empty? == false
  is_f = input.to_f.to_s == input
  is_int = input.to_i.to_s == input
  (is_f || is_int) && non_zero && empty
end

def input_check(message, check_type, lead = "What is the")
  prompt("#{lead} #{message}")
  valid = false
  until valid
    resp = gets.chomp
    case check_type
    when 'string' then valid = string_check(resp)
    when 'int' then valid = int_check(resp)
    when 'float' then valid = float_check(resp)
    end
    prompt(MESSAGES['invalid']) unless valid
  end
end

# Welcome message

user_id = input_check(MESSAGES['name?'], 'string', "")
prompt("Hello #{user_id}")

# need to validate these numbers
loan_amt = input_check(MESSAGES['loan_amt'], 'int').to_i
interest_year = input_check(MESSAGES['int_yr'], 'float').to_f / 100
duration_year = input_check(MESSAGES['dur_year'], 'int').to_i

prompt(MESSAGES['dur_yr_partial'])
months_add = gets.chomp
duration_month = 0
if months_add.downcase == 'y'
  duration_month = input_check(MESSAGES['dur_mnth'], 'string').to_i
else
  duration_month = 0
end

# calculate the inputs to the mortgage rate

interest_month = interest_year / 12
duration_month += duration_year * 12
payment_month = loan_amt * (interest_month / (1 - (1 + interest_month)**(-duration_month)))
tot_cost = payment_month * duration_month
int_load = tot_cost - loan_amt

invoice = <<-MSG
#{MESSAGES['mnth_pay']} $#{format('%.2f', payment_month)}
#{MESSAGES['tot_cost']} $#{format('%.2f', tot_cost)}
#{MESSAGES['tot_int']} $#{format('%.2f', int_load)} in interest!
MSG

puts invoice
