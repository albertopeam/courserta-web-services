class Address
  attr_accessor :city, :state, :location
  @city = nil
  @state = nil
  @location = nil

  def initialize
    @city = nil
    @state = nil
    @location = nil
  end

  def mongoize
    {city:@city, state:@state, loc: @location.mongoize}
  end

  def Address.mongoize(point_or_hash)
    if point_or_hash.nil?
      return nil
    elsif point_or_hash.is_a?(Address)
      return point_or_hash.mongoize
    elsif point_or_hash.is_a?(Hash)
      return point_or_hash
    end
  end

  def Address.demongoize(address_or_hash)
    if address_or_hash.nil?
      return nil
    elsif address_or_hash.is_a?(Address)
      return address_or_hash
    elsif address_or_hash.is_a?(Hash)
      location_hash = address_or_hash[:loc]
      longitude = nil
      latitude = nil
      if location_hash
        longitude = location_hash[:coordinates][0] if !location_hash[:coordinates].nil?
        latitude = location_hash[:coordinates][1] if !location_hash[:coordinates].nil?
      end
      location = Point.new(longitude, latitude)
      address = Address.new
      address.city = address_or_hash[:city]
      address.state = address_or_hash[:state]
      address.location = location
      return address
    end
  end

  def Address.evolve(point_or_hash)
    Address.mongoize(point_or_hash)
  end
end
