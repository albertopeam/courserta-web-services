class Event
  include Mongoid::Document
  field :o, as: :order,type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  embedded_in :parent, polymorphic: true, touch: true

  validates :order, presence: true
  validates :name, presence: true

  def meters
    return nil if distance.nil? || units.nil?
    if units.eql?("meters")
      return distance
    elsif units.eql?("miles")
      return distance * 1609.344;
    elsif units.eql?("kilometers")
      return distance * 1000
    elsif units.eql?("yards")
      return distance * 0.9144
    end
    nil
  end

  def miles
    return nil if distance.nil? || units.nil?
    if units.eql?("miles")
      return distance
    elsif units.eql?("kilometers")
      return distance * 0.621371
    elsif units.eql?("meters")
      return distance * 0.000621371
    elsif units.eql?("yards")
      return distance * 0.000568182
    end
    nil
  end
end
