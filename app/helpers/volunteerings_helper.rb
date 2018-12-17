module VolunteeringsHelper
    def namespaced_volunteering_path(program, options = {})
        @namespaced_volunteering_path ||= namespace

        case @namespace_volunteering_path
        when "management"
            management_volunteering_path(program, options)
        else
            volunteering_path(program, options)
        end
    end 
end