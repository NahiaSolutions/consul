class HousesAgeRange < ActiveRecord::Base
    has_many :workshops

    #Validaciones
    validates :name, :presence => true, uniqueness:

    def self.age_options
        HousesAgeRange.all.order(:name).pluck(:name, :id)
    end

end
