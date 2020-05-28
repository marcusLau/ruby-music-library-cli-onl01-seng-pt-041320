require 'pry'

class Song

    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        @@all << self
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

    def self.find_by_name(name) 
        @@all.detect do |song|
            song.name == name
        end
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)       
    end


end