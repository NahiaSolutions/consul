class WorkshopUser < ActiveRecord::Base
    belongs_to :workshop
    validates :status, :presence => true
    
    def self.register(userid, workshopid)
        workshop = Workshop.find_by_id(workshopid)
        if workshop.quota > 0
            WorkshopUser.create(:id_user => userid, :workshop_id => workshopid, :status => 1)
        elsif workshop.quota <= 0
            WorkshopUser.create(:id_user => userid, :workshop_id => workshopid, :status => 0)
        end
    end

    def self.erase(userid, workshopid)
        workshop = Workshop.find_by_id(workshopid)
        userQueueid = WorkshopUser.find_by_sql(['SELECT id FROM public.workshop_users where workshop_id = ? and status = 0 limit 1;', workshopid])
        user = WorkshopUser.find_by_id(userQueueid)
        if userQueueid.any?
            user.update(status: 1)
        end
        WorkshopUser.where(:id_user => userid, :workshop_id => workshopid).destroy_all
    end

    def self.unregister(userid, workshopid)
        workshop = Workshop.find_by_id(workshopid)
        userQueueid = WorkshopUser.find_by_sql(['SELECT id FROM public.workshop_users where workshop_id = ? and status = 0 limit 1;', workshopid])
        user = WorkshopUser.find_by_id(userQueueid)
        if userQueueid.any?
            user.update(status: 1)
        end
    end

end
