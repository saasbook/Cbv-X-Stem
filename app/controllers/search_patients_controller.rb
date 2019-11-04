class SearchPatientsController < ApplicationController
    def searchPatients
    end

    def findResults
        @name = params[:searchPatients]
        params[:searchPatients] = Profile.where(first_name: @name).to_json
    end
end
