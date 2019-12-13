class PatientInfoController < ApplicationController
    include ProfileHelper
    include UserActivitiesHelper
    include ApplicationHelper
    skip_authorize_resource
    def show
        check_login_as_doctor('patient_info')
    end
end
