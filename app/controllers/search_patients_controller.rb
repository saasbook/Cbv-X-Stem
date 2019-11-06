class SearchPatientsController < ApplicationController
    def searchPatients
        @patients = Profile.all
        if !params[:searchPatients].nil? && !params[:searchPatients].empty? 
            puts("hh")
            @patients = Profile.where(first_name: params[:searchPatients]) + Profile.where(last_name: params[:searchPatients])
        end
    end

    def findResults
        redirect_to searchPatients_path :searchPatients => params[:searchPatients]
    end
end
