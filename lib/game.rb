class Game
  def self.play
    if File.exist? 'google-10000-english-no-swears.txt'
      File.readlines('google-10000-english-no-swears.txt').each do |line|
        p line.chomp
      end
    end
  end
end
