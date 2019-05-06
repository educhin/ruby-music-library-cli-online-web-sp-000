class Artist
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
    if song.artist == nil
      song.artist = self
    end
  end

  def genres
    genres = @songs.collect do |song|
      song.genre
    end
    genres.uniq
  end
end
