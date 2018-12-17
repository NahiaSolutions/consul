class VoluntUser < ActiveRecord::Base
    belongs_to :volunt_program

    def self.register(userid, progid)
        VoluntUser.create(:id_user => userid, :volunt_program_id => progid)
    end

end
