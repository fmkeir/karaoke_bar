class Guest
  attr_reader :name
  attr_accessor :wallet

  def initialize(name, age, wallet, favourite_song)
    @name = name
    @age = age
    @wallet = wallet
    @favourite_song = favourite_song
  end
end
