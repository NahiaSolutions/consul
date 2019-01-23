class ZonalAdministration < ActiveRecord::Base
    has_many :houses, :dependent => :destroy

    #Validaciones
    validates :name, :presence => true, format: {with: /\A^[a-zA-Zñáéíóú\s]+$\Z/i}
end
