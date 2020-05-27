class Song

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        @@all << self
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
end