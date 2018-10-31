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
    @photo_3 = Photograph.new({
                id: "3",
                name: "Identical Twins, Roselle, New Jersey",
                artist_id: "3",
                year: "1967"
              })
    @photo_4 = Photograph.new({
                id: "4",
                name: "Child with Toy Hand Grenade in Central Park",
                artist_id: "3",
                year: "1962"
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
    @artist_3 = Artist.new({
                id: "3",
                name: "Diane Arbus",
                born: "1923",
                died: "1971",
                country: "United States"
              })
    @curator = Curator.new
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
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
    curator = Curator.new
    curator.add_photograph(@photo_1)
    curator.add_photograph(@photo_2)
    assert_equal [@photo_1, @photo_2], curator.photographs
  end
  
  def test_it_can_return_the_first_photograph
    curator = Curator.new
    curator.add_photograph(@photo_1)
    curator.add_photograph(@photo_2)
    assert_equal @photo_1, curator.photographs.first
  end
  
  def test_it_can_return_the_name_of_photographs
    curator = Curator.new
    curator.add_photograph(@photo_1)
    curator.add_photograph(@photo_2)
    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal expected, curator.photographs.first.name
  end
  
  def test_it_can_add_artists
    curator = Curator.new
    curator.add_artist(@artist_1)
    curator.add_artist(@artist_2)
    assert_equal [@artist_1, @artist_2], curator.artists
  end
  
  def test_it_can_return_the_first_artist
    curator = Curator.new
    curator.add_artist(@artist_1)
    curator.add_artist(@artist_2)
    assert_equal @artist_1, curator.artists.first
  end
  
  def test_it_can_return_the_name_of_artists
    curator = Curator.new
    curator.add_artist(@artist_1)
    curator.add_artist(@artist_2)
    expected = "Henri Cartier-Bresson"
    assert_equal expected, curator.artists.first.name
  end
  
  def test_it_can_find_artist_by_id
    curator = Curator.new
    curator.add_artist(@artist_1)
    curator.add_artist(@artist_2)
    assert_equal @artist_1, curator.find_artist_by_id("1")
  end
  
  def test_it_can_find_photograph_by_id
    curator = Curator.new
    curator.add_photograph(@photo_1)
    curator.add_photograph(@photo_2)
    assert_equal @photo_2, curator.find_photograph_by_id("2")
  end
  
  def test_it_can_find_photographs_by_artist
    skip
    diane_arbus = @curator.find_artist_by_id("3")
    actual = @curator.find_photographs_by_artist(diane_arbus)
    assert_equal [@photo_3, @photo_4], actual
  end
  
  def test_it_can_find_artists_with_multiple_photographs
    skip
    diane_arbus = @curator.find_artist_by_id("3")
    actual = @curator.artists_with_multiple_photographs
    assert_equal [@artist_3], actual
    assert_equal 1, @curator.artists_with_multiple_photographs.length
    assert diane_arbus == curator.artists_with_multiple_photographs.first
  end
  
  def test_it_can_find_photographs_by_artists_from_country
    skip
    expected = [@photo_2, @photo_3, @photo_4]
    actual = @curator.photographs_taken_by_artists_from("United States")
    assert_equal expected, actual
    assert_equal [], curator.photographs_taken_by_artists_from("Argentina")
  end
  
end
