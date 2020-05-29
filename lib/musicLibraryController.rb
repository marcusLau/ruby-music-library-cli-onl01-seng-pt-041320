class MusicLibraryController

    attr_accessor :path

    def initialize(path="./db/mp3s")
        imp = MusicImporter.new(path)
        imp.import
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

        running = true
        while running
            input = gets.chomp
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
                running = false
            end
        end
    end
    
    # prints all songs in music library in a numbered list alphabetized by song name
    def list_songs
        Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |x, i|
            puts "#{i+1}. #{x.artist.name} - #{x.name} - #{x.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort{|a, b| a.name <=> b.name}.each_with_index do |x, i|
            puts "#{i+1}. #{x.name}"
        end
    end

    def list_genres
        Genre.all.sort{|a, b| a.name <=> b.name}.each_with_index do |x, i|
            puts "#{i+1}. #{x.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        if artist_name = Artist.find_by_name(input)
            artist_name.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, i|
                puts "#{i+1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        if genre_name = Genre.find_by_name(input)
            genre_name.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, i|
                puts "#{i+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end


    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
        if input > 1 && input < Song.all.length
            Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |song, i|
                if input == i+1 
                    puts "Playing #{song.name} by #{song.artist.name}"
                end
            end
        end
    end

end