class SearchPatientsController < ApplicationController
    def searchPatients
        @patients = Profile.all
        puts(params[:searchPatients])
        if params[:searchPatients]
            @patients = Profile.where(first_name: params[:searchPatients]) + Profile.where(last_name: params[:searchPatients])
        end
        puts(@patients.to_json)
    end

    def findResults
        redirect_to searchPatients_path :searchPatients => params[:searchPatients]
    end
end
