class VoluntCategory < ActiveRecord::Base
    has_many :volunt_programs, :dependent => :destroy

    #Validaciones
    validates :name, :presence => true, format: {with: /\A^[a-zA-Z\s]+$\Z/i}
end