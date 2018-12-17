class WorkshopImage < ActiveRecord::Base
    belongs_to :workshop
    include Imageable

    validates :image, :presence => true
end