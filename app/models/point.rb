class Point
  attr_accessor :longitude, :latitude
  @longitude = nil
  @latitude = nil

  def initialize(longitude, latitude)
    @longitude = longitude
    @latitude = latitude
  end

  def mongoize
    {type: 'Point', coordinates:[longitude,latitude]}
  end

  def Point.mongoize(point_or_hash)
    if point_or_hash.nil?
      return nil
    elsif point_or_hash.is_a?(Point)
      return point_or_hash.mongoize
    elsif point_or_hash.is_a?(Hash)
      return point_or_hash
    end
  end

  def Point.demongoize(point_or_hash)
    if point_or_hash.nil?
      return nil
    elsif point_or_hash.is_a?(Point)
      return point_or_hash
    elsif point_or_hash.is_a?(Hash)
      return Point.new(point_or_hash[:coordinates][0], point_or_hash[:coordinates][1])
    end
  end

  def Point.evolve(point_or_hash)
    Point.mongoize(point_or_hash)
  end
end
