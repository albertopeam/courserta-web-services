class LegResult
  include Mongoid::Document
  field :secs, type: Float

  embedded_in :entrant
  embeds_one :event, as: :parent

  validates :event, presence: true

  after_initialize do |doc|
    calc_ave
  end

  def calc_ave
  end

  def secs= value
    self[:secs] = value
    calc_ave
  end
end
