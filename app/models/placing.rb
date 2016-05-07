class Placing
  attr_accessor :name, :place
  @name = nil
  @place = nil

  def initialize(name, place)
    @name = name
    @place = place
  end

  def mongoize
    {name: @name, place: @place}
  end

  def Placing.mongoize(placing_or_hash)
    if placing_or_hash.nil?
      return nil
    elsif placing_or_hash.is_a?(Placing)
      return placing_or_hash.mongoize
    elsif placing_or_hash.is_a?(Hash)
      return placing_or_hash
    end
  end

  def Placing.demongoize(placing_or_hash)
    if placing_or_hash.nil?
      return nil
    elsif placing_or_hash.is_a?(Placing)
      return placing_or_hash
    elsif placing_or_hash.is_a?(Hash)
      return Placing.new(placing_or_hash[:name], placing_or_hash[:place])
    end
  end

  def Placing.evolve(placing_or_hash)
    Placing.mongoize(placing_or_hash)
  end
end
