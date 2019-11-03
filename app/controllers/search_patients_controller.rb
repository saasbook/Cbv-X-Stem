class SearchPatientsController < ApplicationController
    def searchPatients
    end

    def findResults
        params[:searchPatients] = params[:searchPatients] + " CS169"
    end
end
