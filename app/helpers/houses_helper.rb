module HousesHelper
    def namespaced_house_path(house, options = {})
        @namespaced_house_path ||= namespace

        case @namespace_house_path
        when "management"
            management_house_path(house, options)
        else
            house_path(house, options)
        end
    end 
end
