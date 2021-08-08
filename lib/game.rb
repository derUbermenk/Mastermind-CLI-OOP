# frozen_string_literal: true
require_relative 'display'
require_relative 'board'
require_relative 'player'

# Contains all the logic in order to play game
class Game
  include Display

  attr_accessor :board, :code, :encoder, :decoder,
                :winner, :last_guess, :last_accuracy,
                :quit

  def initialize
    @board = Board.new
    @choices = %w[1 2 3 4 5 6] # an array of words
    @code = nil
    @encoder = nil
    @decoder = nil
    @winner = nil

    @last_guess = nil
    @last_accuracy = nil
    @quit = nil
  end

  def play
    initialize_players

    set_code
    keep_playing until stop_conditions_met

    report_end_terms
  end

  private

  <<-DOC
  use the folllowing format for defining method groups
  # METHOD GROUP: MAIN METHOD NAME
  # supporting methods
  # main method
  # END OF METHOD GROUP: MAIN METHOD NAME
  DOC

  # METHOD GROUP: initialize_player 

  # sets role chosen for human player
  def human_choose_role

    report_choose_role
    role = gets.chomp.upcase

    case role
    when 'E'
      self.encoder = Player.new
    when 'D'
      self.decoder = Player.new
    else
      report_invalid_role_input
      human_choose_role
    end
  end

  # sets role of ai
  def ai_set_role
    if self.encoder.nil?
      self.encoder = AI.new
    else
      self.decoder = AI.new
    end
  end

  # initializes players made from player choice
  def initialize_players
    human_choose_role
    ai_set_role
  end

  # END OF METHOD GROUP

  def board_full
    board.full?
  end

  def stop_conditions_met
    board_full? || decoded? || quit
  end

  def set_code
    self.code = encoder.encode(choices)
  end

  def update_board
    board.update(last_guess, last_accuracy)
  end

  def keep_playing
    ###
    player_input = decoder.decode(choices, last_guess, last_accuracy)

    if player_input == ['z']
      quit_game
    else
      update_last_guess(player_input)
      update_last_accuracy(player_input)
      update_board
      decoded?
    end
  end

  # reports the cause of why the game was ended 
  def report_end_terms
    if board_full
      # encoder wins
      report_encoder_wins
    elsif decoded 
      report_decoder_wins
    elsif game_quit
      report_game_quit
    end
  end

  # the following private methods are used to update class attributes

  def quit_game
    self.quit = true
  end

  def update_last_guess(latest_guess)
    self.last_guess = latest_guess
  end

  def update_last_accuracy(last_guess)
    self.last_accuracy = encoder.evaluate(last_guess, choices)
  end

  def decoded? 
    if last_accuracy.all?('+')
      self.winner = true 
    end
  end

  # the following private methods are used define shorter accessors

  def encoder
    self.encoder
  end

  def decoder
    self.decoder
  end

  def last_guess
    self.last_guess
  end

  def last_accuracy
    self.last_accuracy
  end

  def board
    self.board
  end

  def winner
    self.winner
  end

  def quit
    self.quit
  end

  def choices
    self.choices
  end
end
