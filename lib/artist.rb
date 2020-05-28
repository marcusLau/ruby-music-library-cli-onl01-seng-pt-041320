class Artist
    extend Concerns::Findable


    attr_accessor :name, :songs, :genres

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        # @@all << self
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
        artist = self.new(name)
        artist.save
        artist
    end

    def add_song(song)
        if song.artist == nil 
            song.artist = self
        end
        if !@songs.include?(song) 
            @songs << song
        end
    end

    def genres
        genres = []
        @songs.each do |song|
            if !genres.include?(song.genre)
                genres << song.genre
            end
        end
        genres
    end
end