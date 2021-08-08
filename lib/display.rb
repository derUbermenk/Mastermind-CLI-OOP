# Contains all methods for displaying prompts and messages
module Display

  # main Display

  def report_instructions
    puts " \n INSTRUCTIONS: sogno di volaire \n "
  end

  def report_keep_playing_prompt
    print " \n Do you want to play another game? [Yes[y] No[n]]: "
  end


  # Game Display

  def report_choose_role
    puts " \n Choose the role you want to play as: Decoder[D] Encoder[E] \n"
  end

  def report_invalid_role_input
    puts " \n Invalid role entered \n "
  end

  def report_encoder_wins
    puts " \n Encoder wins \n "
  end

  def report_decoder_wins
    puts " \n Board Full \n Decoder_wins \n "
  end

  def report_game_quit
    puts " \n Game Quit \n "
  end

  # Player Display

  def report_ask_for_code
    print " \n enter code: "
  end

  def report_invalid_code
    puts " \n Invalide code entered \n Enter another code \n "
  end

  # Board display

  # Shows formatted board rows
  # @param board [Board]
  def show_board(board)
    puts board.rows.map { |row| format_row(row) }.join("\n")
  end

  # formats a row for display
  #
  # @param row [Hash] contains row guess and accuracy
  def format_row(row)
    " #{row[:guess].join(' | ')} || #{row[:accuracy].join(' | ')} "
  end
end
