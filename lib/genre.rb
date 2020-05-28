class Genre

    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        @name = name
        @@all << self
        @songs = []
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

    def self.create(name)
        genre = self.new(name)
        genre.save
        genre
    end

    def add_song(song)
        if song.genre == nil
            song.genre = self
        end
        if !@songs.include?(song)
            @songs << song
        end
    end

    def artists
        artists = [] 
        @songs.each do |song|
            if !artists.include?(song.artist)
                artists << song.artist
            end
        end
        artists
    end
end