class Genre
  extend Concerns::Findable
  include Concerns::Findable::InstanceMethods

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
    @songs = []
  end

  def self.all
    @@all
  end

  def songs
    @songs
  end

  def add_song(song)
    if !@songs.include?(song)
      @songs << song
    end
    if song.genre == nil
      song.genre = self
    end
  end

  def artists
    artists = @songs.collect do |song|
      song.artist
    end
    artists.uniq
  end
end
