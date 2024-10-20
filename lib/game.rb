class Game

  def init(word_list_file_name)
    if File.exist? world_list_file_name
      File.readlines(world_list_file_name).each do |line|
        @world_list << line.chomp
      end
    end

  def play
    puts 'Hangman game started!'

  end
end
