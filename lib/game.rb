class Game

  def initialize(list_file)
    @word_list = file_to_list(list_file)
    @guesses = []
    @correct_guesses = []
  end

  def play
    puts 'Hangman game started!'
    puts 'You have 10 lives to guess all the letters of a hidden word.'

    make_secret
    
    i = 10
    until i==0
      puts "\n#{i} lives left"
      guess = get_guess
      i -= 1 unless check_guess?(guess)
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

  def make_secret
    @secret = @word_list.filter do |word|
      word.length >= 5
    end.sample.downcase.split('')
    @display = @secret.map{ "_" }
  end

  def get_guess
    guess = ''
    loop do
      puts 'Make a new single letter guess:'
      guess = gets.chomp.downcase
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

end
