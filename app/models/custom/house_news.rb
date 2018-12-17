class HouseNews < ActiveRecord::Base
    belongs_to :house
    include Imageable

    validates :title, :presence => true
    validates :link, :presence => true, :format => URI::regexp(%w(http https))
    validates :image, :presence => true
end
