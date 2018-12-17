class HouseImage < ActiveRecord::Base
    belongs_to :house
    include Imageable

    validates :image, :presence => true
end