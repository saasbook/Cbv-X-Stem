class PatientInfoController < ApplicationController
    include ProfileHelper
    include UserActivitiesHelper
    include ApplicationHelper
    skip_authorize_resource
    def show
        if not is_doctor?
            go_to_root
        else
            @current_profile = Profile.find(params[:id])
            params[:patient_name] = @current_profile.first_name + " " + @current_profile.last_name
            params[:patient_id] = @current_profile.user_holder_id
            render 'patient_info'
        end
    end
end
