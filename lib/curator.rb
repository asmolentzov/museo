class Curator
  
  attr_reader :artists, :photographs
  
  def initialize
    @artists = []
    @photographs = []
  end
  
  def add_photograph(photo)
    @photographs << photo
  end
  
end