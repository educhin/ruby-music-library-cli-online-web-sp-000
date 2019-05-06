class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    files = Dir.entries(@path)
    files.select{|file| file.include?(".mp3")}
  end

  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end
end
