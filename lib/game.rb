class Game

  def initialize(word_list_file_name)
    @word_list = []
    if File.exist? word_list_file_name
      File.readlines(word_list_file_name).each do |line|
        @word_list << line.chomp
      end
    end
  end

  def play
    puts 'Hangman game started!'

  end
end
