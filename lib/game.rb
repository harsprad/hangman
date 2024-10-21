class Game

  def initialize(list_file)
    @word_list = file_to_list(list_file)
    @guesses = []
    @correct_guesses = []
  end

  def play
    puts 'Hangman game started!'
    puts 'You have 10 attempts to guess all the letters of a hidden word.\n'

    @secret = @word_list.sample.downcase.split('')
    @display = @secret.map{ "_" }

    (1..10).each do |i|
      puts "\nTurn #{i}"
      guess = get_guess
      check_guess(guess)
      show_correct_letters
      break if win?
    end
    
    puts "\nGame over, did you win? Winning word: #{@secret.join('')}"
  end

  def file_to_list(file)
    list = []
    if File.exist? file
      File.readlines(file).each do |line|
        list << line.chomp
      end
    end
    list
  end

  def ask_guess
    valid_guess = false
    unless valid_guess
      puts 'Make a new single letter guess:'
      guess = gets.chomp.downcase
      valid_guess = true if guess.length == 1
    end
    guess
  end

  def get_guess
    guess = ''
    unless @guesses.include?(guess)
      guess = ask_guess
    end
  end

  def show_correct_letters
    puts @display.join(' ')
  end

  def win?
    @display.join('') == @secret.join('')
  end

  def check_guess(guess)
    if @secret.include?(guess)
      @correct_guesses << guess
      @display = @secret.map do |letter|
        @correct_guesses.include?(letter) ? letter : '_'
      end
    end
  end

end
