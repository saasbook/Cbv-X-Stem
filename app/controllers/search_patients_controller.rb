class SearchPatientsController < ApplicationController
    def searchPatients
        if !current_user.is_doctor?
            flash[:error] = "Only Doctor can access this page"
            redirect_to root_path
        end
        # Not working. If you really want to have role in profile, set it in the initializer. But it is not a good idea of putting authority info in profile (profile is changable)
        @patients_list = User.where("role='patient' and email != 'testuser01@testuser.com' and email != 'guest@guest.com' and email != 'testuser02@testuser.com' and first_name != 'TestUser'").pluck(:id)
        @patients = Profile.where(user_holder_id: UserHolder.where(user_id: @patients_list).pluck(:id))
        @patients = @patients.where.not(email: "tp1@gmail.com")
        @patients = filter_by_params(@patients)
        if (!params[:sort].nil? && !params[:sort].empty?)
            @patients = sort_users(@patients)
        end
    end
end