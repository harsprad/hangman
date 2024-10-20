class Game

  def initialize(list_file)
    @word_list = file_to_list(list_file)
  end

  def play
    puts 'Hangman game started!'
    puts 'You have 10 attempts to guess all the letters of a hidden word.'

    @secret = @word_list.sample

    # user guess
    # check if correct
    # update dislay
    # if correct win
    # if no more guesses lose
    # else loop
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
    
end
