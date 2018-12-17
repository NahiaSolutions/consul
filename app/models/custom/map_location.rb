class MapLocation < ActiveRecord::Base

  belongs_to :house, touch: true
  belongs_to :proposal, touch: true
  belongs_to :investment, class_name: Budget::Investment, touch: true

  validates :longitude, :latitude, :zoom, presence: true, numericality: true

  def available?
    latitude.present? && longitude.present? && zoom.present?
  end

  def json_data
    {
      house_id: house_id,
      investment_id: investment_id,
      proposal_id: proposal_id,
      lat: latitude,
      long: longitude
    }
  end

end
