class ZonalAdministration < ActiveRecord::Base
    has_many :houses, :dependent => :destroy

    #Validaciones
    validates :name, :presence => true, format: {with: /\A^[a-zA-Z0-9ñáéíóú\s]+$\Z/i}
end
