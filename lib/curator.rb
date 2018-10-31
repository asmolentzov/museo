require './lib/file_io'

class Curator
  
  attr_reader :artists, :photographs
  
  def initialize
    @artists = []
    @photographs = []
  end
  
  def add_photograph(photo)
    @photographs << photo
  end
  
  def add_artist(artist)
    @artists << artist
  end
  
  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end
  
  def find_photograph_by_id(id)
    @photographs.find do |photo|
      photo.id == id
    end
  end
  
  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end
  
  def artists_with_multiple_photographs
    photo_count = Hash.new(0)
    @photographs.each do |photo|
      photo_count[photo.artist_id] += 1
    end
    
    artists = []
    photo_count.each do |artist_id, count|
      artists << find_artist_by_id(artist_id) if count > 1
    end
    artists
  end
  
  def photographs_taken_by_artists_from(country)    
    country_artists = @artists.find_all do |a|
      a.country == country
    end
    
    country_artists.map do |a|
      find_photographs_by_artist(a)
    end.flatten
  end
  
  def load_artists(file_path)
    artists = FileIO.load_artists(file_path)
    artists.each do |artist|
      add_artist(Artist.new(artist))
    end
  end
  
  def load_photographs(file_path)
    photos = FileIO.load_photographs(file_path)
    photos.each do |photo|
      add_photograph(Photograph.new(photo))
    end
  end
  
  def photographs_taken_between(years)
    photos = []
    years.each do |year|
      photos << @photographs.find_all do |photo|
        photo.year == year.to_s
      end
    end
    photos.flatten
  end
  
  def artists_photographs_by_age(artist)
    photos = find_photographs_by_artist(artist)    
    result = {}
    photos.each do |photo|
      age = photo.year.to_i - artist.born.to_i
      result[age] = photo.name
    end
    result
  end
end