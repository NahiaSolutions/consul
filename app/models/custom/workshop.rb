class Workshop < ActiveRecord::Base
    belongs_to :house
    belongs_to :houses_age_range
    has_many :workshop_users, :dependent => :destroy
    has_many :workshop_images, :dependent => :destroy
    include Imageable

    validates :name, :presence => true, format: {with: /\A^[a-zA-Z0-9\s]+$\Z/i}
    validates :teacher, :presence => true, format: {with: /\A^[a-zA-Z\s.]+$\Z/i}
    validates :schedule, :presence => true, format: {with: /\A^[a-zA-Z0-9\s\/:.\-]+$\Z/i}
    validates :quota, :presence => true, :numericality => true
    validates :short_description, :presence => true
    validates :long_description, :presence => true
    validates :id_age_range, :presence => true
    validates :status, :presence => true

    def self.register(workshopid)
        workshop = Workshop.find_by_id(workshopid)
        Workshop.update(workshopid, :quota => workshop.quota - 1)
    end

    def self.erase(workshopid)
        workshop = Workshop.find_by_id(workshopid)
        Workshop.update(workshopid, :quota => workshop.quota + 1)
    end

end
