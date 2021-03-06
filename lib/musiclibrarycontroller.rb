

class MusicLibraryController

  attr_reader :path

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(@path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = gets.strip
    case input
    when "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
      play_song
    when "exit"
      return
    else
      call
    end
  end

  def list_songs
    array = Song.all.sort_by(&:name)
    array.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
    array
  end

  def list_artists
    array = Artist.all.sort_by(&:name).uniq
    array.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end

    # array = Song.all.collect do |song|
    #   song.artist
    # end
    # artists = array.sort_by(&:name).uniq
    # artists.each_with_index do |artist, index|
    #   puts "#{index + 1}. #{artist.name}"
    # end
  end

  def list_genres
    array = Genre.all.sort_by(&:name).uniq
    array.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end

    # array = Song.all.collect do |song|
    #   song.genre
    # end
    # genres = array.sort_by(&:name).uniq
    # genres.each_with_index do |genre, index|
    #   puts "#{index + 1}. #{genre.name}"
    # end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    artist = Artist.all.detect {|artist| artist.name == input}

    if artist != nil
      songs = Song.all.select {|song| song.artist == artist}.sort_by(&:name).uniq
      songs.each_with_index do |song, index|
        puts "#{index + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    genre = Genre.all.detect {|genre| genre.name == input}

    if genre != nil
      songs = Song.all.select {|song| song.genre == genre}.sort_by(&:name).uniq
      songs.each_with_index do |song, index|
        puts "#{index + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    songs = Song.all.sort_by(&:name)

    if input > 0 && input <= songs.length
      song = songs[input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
