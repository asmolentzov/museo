require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/photograph'
require './lib/artist'
require 'pry'

class CuratorTest < Minitest::Test
  
  def setup
    @photo_1 = Photograph.new({
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              })
    @photo_2 = Photograph.new({
              id: "2",
              name: "Moonrise, Hernandez",
              artist_id: "2",
              year: "1941"
            })
    @artist_1 = Artist.new({
                id: "1",
                name: "Henri Cartier-Bresson",      
                born: "1908",      
                died: "2004",      
                country: "France"      
              })      
    @artist_2 = Artist.new({
                id: "2",      
                name: "Ansel Adams",      
                born: "1902",      
                died: "1984",      
                country: "United States"      
              })
    @curator = Curator.new
  end
  
  def test_it_exists
    curator = Curator.new
    assert_instance_of Curator, curator
  end
  
  def test_its_artists_start_empty
    curator = Curator.new
    assert_equal [], curator.artists
  end
  
  def test_its_photographs_start_empty
    curator = Curator.new
    assert_equal [], curator.photographs
  end
  
  def test_it_can_add_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal [@photo_1, @photo_2], @curator.photographs
  end
  
  def test_it_can_return_the_first_photograph
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @photo_1, @curator.photographs.first
  end
  
  def test_it_can_return_the_name_of_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal expected, @curator.photographs.first.name
  end
  
  def test_it_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal [@artist_1, @artist_2], @curator.artists
  end
  
  def test_it_can_return_the_first_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @artist_1, @curator.artists.first
  end
  
  def test_it_can_return_the_name_of_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    expected = "Henri Cartier-Bresson"
    assert_equal expected, @curator.artists.first.name
  end
  
  def test_it_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end
  
  def test_it_can_find_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end
  
end
