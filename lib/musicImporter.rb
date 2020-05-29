require 'pry'

class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def path
        @path
    end

    def files
        Dir.entries(@path).select do |song|
            song.end_with?(".mp3")
        end
    end

    # Imports songs into library given a file directory of "./spec/fixtures/mp3s"
    def import
        files = Dir.entries(path)
        files.slice(2, files.length).each do |file|
            # binding.pry
            Song.create_from_filename(file)
        end
    end
end

