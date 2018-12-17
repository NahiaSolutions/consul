class ZonalAdministration < ActiveRecord::Base
    has_many :houses, :dependent => :destroy

    #Validaciones
    validates :name, :presence => true, format: {with: /\A^[a-zA-Z\s]+$\Z/i}
end
