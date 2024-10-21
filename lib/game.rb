require 'yaml'

class Game

  def initialize(list_file)
    make_secret(file_to_list(list_file))
    @guesses = []
    @correct_guesses = []
    @lives = 10
  end

  def play
    puts "\nHangman game started!"
    puts "You have #{@lives} lives to guess all the letters."
    puts 'Type save to save game state'
    
    until @lives==0
      puts "\n#{@lives} lives left"
      guess = get_guess
      @lives -= 1 unless check_guess?(guess)
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

  def make_secret(word_list)
    @secret = word_list.filter do |word|
      word.length >= 5
    end.sample.downcase.split('')
    @display = @secret.map{ '_' }
  end

  def get_guess
    guess = ''
    loop do
      puts 'Make a new single letter guess:'
      guess = gets.chomp.downcase
      save_game_state if guess == 'save'
      break if guess.length == 1 && !@guesses.include?(guess)
    end
    @guesses << guess
    guess
  end

  def show_correct_letters
    puts @display.join(' ')
  end

  def win?
    @display.join('') == @secret.join('')
  end

  def check_guess?(guess)
    if @secret.include?(guess)
      @correct_guesses << guess
      @display = @secret.map do |letter|
        @correct_guesses.include?(letter) ? letter : '_'
      end
      true
    else
      false
    end
  end

  def save_game_state
    Dir.mkdir('saves') unless Dir.exist?('saves')

    file_name = make_file_name('yaml')

    File.open(file_name, 'w') do |file|
      file.write YAML::dump(self)
    end

    puts "GAME SAVED!"
  end

  def make_file_name(extension)
    "saves/#{@display.join('')}-#{Time.now.to_i.to_s}.#{extension}"
  end
end
