require 'pry'

class Song
    extend Concerns::Findable

    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        # @@all << self 
        self.artist = artist if artist != nil
        self.genre = genre if genre != nil
    end

    def self.all 
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    def save
        @@all << self
    end

    # Initializes, saves, and returns the song
    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end
    
    # Creates a new song while also updating artist/genre of the new song parameters.
    def self.new_from_filename(file)
        data = file.split(" - ")

        name = data[1] 
        artist_name = data[0]
        genre_name = data[2].split(".mp3").join

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        self.new(name, artist, genre)
    end

    # initializes from filename and saves into @@all
    def self.create_from_filename(file)
        self.new_from_filename(file).save
    end

end