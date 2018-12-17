class VoluntProgram < ActiveRecord::Base
    belongs_to :volunt_category
    has_many :volunt_users, :dependent => :destroy
    include Imageable

    validates :title, :presence => true, format: {with: /\A^[a-zA-Z0-9\s]+$\Z/i}
    validates :schedule, :presence => true, format: {with: /\A^[a-zA-Z0-9\s\/:.\-]+$\Z/i}
    validates :phone, :presence => true, format: {with: /\A^[0-9\/]+$\Z/i}
    validates :quota, :presence => true, :numericality => true
    validates :email, :presence => true, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :short_description, :presence => true
    validates :long_description, :presence => true

    def self.register(progid)
        program = VoluntProgram.find_by_id(progid)
        if program.quota > 0
            VoluntProgram.update(progid, :quota => program.quota - 1)
        end
    end

    def self.unregister(progid)
        program = VoluntProgram.find_by_id(progid)
        VoluntProgram.update(progid, :quota => program.quota + 1)
    end

end