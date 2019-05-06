
class Song
  extend Concerns::Findable
  include Concerns::Findable::InstanceMethods

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil
      self.artist=(artist)
    end
    if genre != nil
      self.genre=(genre)
    end
  end

  def self.all
    @@all
  end

  def self.new_from_filename(file)
  data = file.split(" - ")
  name = data[1]
  genre = data[2].split(".")[0]
  song = Song.new(name)

  song.artist = Artist.find_or_create_by_name(data[0])
  song.artist.songs << song
  song.genre = Genre.find_or_create_by_name(genre)
  song.genre.songs << song
  song
  end

  def self.create_from_filename(file)
    song = self.new_from_filename(file)
    song.save
  end




  # def self.find_by_name(name)
  #   self.all.detect {|a| a.name == name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   song = self.find_by_name(name)
  #   if song == nil
  #     self.create(name)
  #   else
  #     song
  #   end
  # end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def artist_name
    self.artist == nil ? nil : self.artist
  end

  def genre=(genre)
    @genre = genre
    @genre.add_song(self)
  end


end
