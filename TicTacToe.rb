#Tic Tac Toe application
#Created 9-3-2015 
#George Albrecht

#To Do
#Work on smart AI?

require 'pry'

#constant of winning lines
WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [7,5,3], [1,5,9]]

#create board hash
def create_board_hash

  board = {}
  (1..9).each {|number| board[number] = ' '}
  board

end

#method to visually draw the board
def draw_board(board)
  puts "#{board[1]}|#{board[2]}|#{board[3]}"
  puts "-----"
  puts "#{board[4]}|#{board[5]}|#{board[6]}"
  puts "-----"
  puts "#{board[7]}|#{board[8]}|#{board[9]}"
end

#method to set icons
def set_player_icon

  puts "Welcome to Tic Tac Toe! Do you want to be X's or O's? (x/o)"
  player_icon = gets.chomp.upcase!
  if player_icon == 'X' || player_icon == 'O'
    puts "Great your icons will be #{player_icon}s."
    player_icon
  else 
    puts "Please choose either X or O!"
  end 

end 

#method to set comp icon
def set_comp_icon player_icon

  if player_icon == 'X'
    computer_icon = 'O'
  else 
    computer_icon = 'X'
  end 

  computer_icon

end

def find_empty_spaces board

  board.select {|k,v| v == ' '}

end 

#method to output help
def print_help
  puts "\nBelow is the board grid. \nSelect the appropriate number for the position you want.\n\n"
  puts "1|2|3"
  puts "-----"
  puts "4|5|6"
  puts "-----"
  puts "7|8|9\n\n"
end

#method for player picking
def player_picks player_icon, board

  puts "Please select a square (1-9). 1 corresponds to top left, 9 for bottom right.\nType \'help\' for more details."
  player_input = gets.chomp
  if player_input == 'help'
    print_help
  else 
    player_input = player_input.to_i
    #check to make sure space is available
    empty_spaces = find_empty_spaces(board)
    if empty_spaces.keys.include?(player_input) 
      board[player_input] = player_icon
    else 
      puts "Spot is taken, these are the available spots: #{empty_spaces.keys}"
    end 
  end

end

def computer_picks board, computer_icon, player_icon

  #turn this into smart AI
  #Look at all the winning lines
  #See if any have two
  #For the ones that have 2, make the pick there
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(player_icon) == 2
      line.each do |item|
        computer_pick = board.select{|k,v|k == item and v == ' '}.keys.first
        board[computer_pick] = computer_icon
        return board
      end 
    end 
  end 
  computer_pick = find_empty_spaces(board).keys.sample.to_i
  board[computer_pick] = computer_icon

end

#method to check for a winner. Modeled after solution video. 
def check_for_winner board, player_icon, computer_icon
  
  WINNING_LINES.each do |line|
    return 'Player' if board.values_at(*line).count(player_icon) == 3
    return 'Computer' if board.values_at(*line).count(computer_icon) == 3
  end 
  nil

end

#Start game with welcome message and determine what the player wants to use. Regex input to make sure its x or o
begin

  board = create_board_hash

  #each time theres a new game reset the icons
  begin 
    player_icon = set_player_icon
    if player_icon != nil
      computer_icon = set_comp_icon(player_icon)
    end 
  end until player_icon and computer_icon

  begin 
    #Get player input. Create a quick help method too. Also regex here. 

    player_pick = player_picks(player_icon, board)
    #check if the player entered help or entered an already taken spot
    if player_pick 
      computer_picks(board, computer_icon, player_icon)
      draw_board(board)
    end 
    #check for a winner
    winner = check_for_winner(board, player_icon, computer_icon)

  end until find_empty_spaces(board).empty? or winner

  if winner 
    puts "#{winner} won!"
  else 
    puts "Tie!"
  end 

  puts "Do you want to play again? Type \'y'\ to go again."
  play_again = gets.chomp

end until play_again != 'y'
puts "Thanks for playing."


