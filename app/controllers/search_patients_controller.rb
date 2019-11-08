class SearchPatientsController < ApplicationController
    def searchPatients
        @patients = Profile.all
        if (!params[:search_first_name].nil? && !params[:search_first_name].empty?) 
            @patients = @patients.where('lower(first_name) = ? ', params[:search_first_name].downcase)
        end
        if (!params[:search_last_name].nil? && !params[:search_last_name].empty?)
            @patients = @patients.where('lower(last_name) = ? ', params[:search_last_name].downcase)
        end
        if (!params[:search_id].nil? && !params[:search_id].empty?)
            @patients = @patients.where(:user_holder_id => params[:search_id])
        end
    end

    def getProfileById
        @current_profile = Profile.where(:user_holder_id => params[:search_id])
        puts("hhhh\n")
        redirect_to patient_profile_path
    end
end
