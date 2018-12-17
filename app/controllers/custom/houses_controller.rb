class HousesController < ApplicationController
    skip_authorization_check
    skip_authorization_check only: :json_data

    def index
        @zonal_administration = ZonalAdministration.all.order('id asc')
        @houses = House.all.order('id desc')
        @houses_coordinates = MapLocation.where(house_id: @houses).map { |l| l.json_data }
        @ageOptions = HousesAgeRange.all.order('id desc')
        #@workshops = Workshop.select(:name, :short_description, :id_age_range, :photo).distinct
        @workshops = Workshop.all.order('id desc')
    end

    def show
        @house = House.find_by_id(params[:houseid])
        @house_coordinates = MapLocation.where(house_id: @house).map { |l| l.json_data }
        @ageOptions = HousesAgeRange.find_by_sql(['select distinct houses_age_ranges.id, houses_age_ranges.name  from houses_age_ranges, workshops 
        where workshops.id_age_range = houses_age_ranges.id AND house_id = ? ORDER BY houses_age_ranges.id desc', params[:houseid]])
        if params[:option] == 'houses'
            @houseNews = @house.house_news
        end
        @workshop = Workshop.find_by_id(params[:workshopid])
        if params[:option] == 'workshop'
            @workshopWor = Workshop.find_by_name(params[:workshopname])
            @workshopAgeRange = HousesAgeRange.find_by_id(@workshopWor.id_age_range)
            @otherHouses = Workshop.find_by_sql(['SELECT * FROM houses where id IN (SELECT house_id from workshops where name = ? and id <> ? ORDER BY random() limit 3)', 
            @workshopWor.name,@workshopWor.id])
            @otherWorkshops = Workshop.find_by_sql(['SELECT distinct name, short_description, photo from workshops where id_age_range = (SELECT id_age_range FROM workshops where id = ? ) AND id <> ? AND name <> (SELECT name FROM workshops where id = ?) limit 3', 
            @workshopWor.id, @workshopWor.id, @workshopWor.id])
        end

        if params[:workshopid] != nil
            @workshopAgeRange = HousesAgeRange.find_by_id(@workshop.id_age_range)
            @otherHouses = Workshop.find_by_sql(['SELECT * FROM houses where id IN (SELECT house_id from workshops where name = ? and id <> ? ORDER BY random() limit 3)', 
            @workshop.name, params[:workshopid]])
            @otherWorkshops = Workshop.find_by_sql(['SELECT * from workshops where id_age_range = (SELECT id_age_range FROM workshops where id = ? ) AND id <> ? AND name <> (SELECT name FROM workshops where id = ?) ORDER BY random() limit 3', 
            params[:workshopid], params[:workshopid], params[:workshopid]])
        end

        if user_signed_in?
            @workshop_user = WorkshopUser.where(:workshop_id => params[:workshopid], :id_user => current_user.id).first
        end

        if params[:register] == 'reg' && @workshop_user.blank?
            WorkshopUser.register(current_user.id, params[:workshopid])
            Workshop.register(params[:workshopid])
        end

        if params[:register] == 'erase' && @workshop_user.present?
            WorkshopUser.erase(current_user.id, params[:workshopid])
            Workshop.erase(params[:workshopid])
        end
    end

    def json_data
        house =  House.find(params[:id])
        data = {
          house_id: house.id,
          house_name: house.name
        }.to_json
  
        respond_to do |format|
          format.json { render json: data }
        end
    end

end
