VALID_CHOICES = %w(rock paper scissors lizard spock)
VALID_CHOICES_SHORT = %w(r p sc l sp)

def prompt(message)
  puts "==> #{message}"
end

def player_choice
  prompt("Choose one: #{VALID_CHOICES.join(', ')}")
  choice = nil
  loop do
    choice = gets.chomp
    if VALID_CHOICES_SHORT.include?(choice)
      choice = choice_convert(choice)
    end
    if valid_choice?(choice)
      return choice
    else
      prompt('Invalid choice, please try again')
    end
  end
end

def valid_choice?(choice)
  VALID_CHOICES.include?(choice)
end

def choice_convert(choice)
  case choice
  when 'r' then 'rock'
  when 'p' then 'paper'
  when 'sc' then 'scissors'
  when 'l' then 'lizard'
  when 'sp' then 'spock'
  end
end

def computer_choice
  VALID_CHOICES.sample
end

def report_choices(user, computer)
  prompt("You chose #{user}")
  prompt("Computer chose #{computer}")
end

def win_2?(p1, p2)
  win_hash = {
    scissors: %w(paper lizard),
    paper: %w(rock spock),
    rock: %w(lizard scissors),
    lizard: %w(spock paper),
    spock: %w(scissors rock)
  }

  win_hash[p1.to_sym].include?(p2)
end

=begin This is the old win_check that fails rubocop
def win?(p1, p2)
  (p1 == 'scissors' && (p2 == 'paper' || p2 == 'lizard')) ||
    (p1 == 'paper' && (p2 == 'rock' || p2 == 'spock')) ||
    (p1 == 'rock' && (p2 == 'lizard' || p2 == 'scissors')) ||
    (p1 == 'lizard' && (p2 == 'spock' || p2 == 'paper')) ||
    (p1 == 'spock' && (p2 == 'scissors' || p2 == 'rock'))
end
=end

def game_results(player, computer)
  if win_2?(player, computer)
    'P1'
  elsif win_2?(computer, player)
    'P2'
  else
    'Tie'
  end
end

def report_results(winner)
  case winner
  when 'P1' then 'Player wins'
  when 'P2' then 'Computer wins'
  when 'Tie' then 'Tie game, try again!'
  end
end

loop do
  p1_score = 0
  comp_score = 0

  until p1_score == 3 || comp_score == 3

    player = player_choice()
    comp = computer_choice()

    report_choices(player, comp)
    winner = game_results(player, comp)
    prompt(report_results(winner))

    case winner
    when 'P1' then p1_score += 1
    when 'P2' then comp_score += 1
    end

    prompt('The score is...')
    prompt("Player: #{p1_score} ---- Computer: #{comp_score}")
  end

  # ask if they want to play again
  prompt('Play again? Y for yes')
  replay_choice = gets.chomp
  break unless replay_choice.downcase.start_with?('y')
end
