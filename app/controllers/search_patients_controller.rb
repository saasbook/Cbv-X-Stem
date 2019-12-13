class SearchPatientsController < ApplicationController
    def searchPatients
        if !current_user.is_doctor?
            flash[:error] = "Only Doctor can access this page"
            redirect_to root_path
        end


        # Not working. If you really want to have role in profile, set it in the initializer.
        # But it is not a good idea of putting authority info in profile (profile is changable)
        # @patients = Profile.where(role: "patient")
        @patients_list = User.where("role='patient' and email != 'testuser01@testuser.com' and email != 'guest@guest.com' and email != 'testuser02@testuser.com'").pluck(:id)
        @patients = Profile.where(user_holder_id: UserHolder.where(user_id: @patients_list).pluck(:id))

        @patients = @patients.where.not(email: "tp1@gmail.com")
        if (!params[:search_first_name].nil? && !params[:search_first_name].empty?)
            @patients = @patients.where('lower(first_name) = ? ', params[:search_first_name].downcase)
        end
        if (!params[:search_last_name].nil? && !params[:search_last_name].empty?)
            @patients = @patients.where('lower(last_name) = ? ', params[:search_last_name].downcase)
        end

        if (!params[:search_id].nil? && !params[:search_id].empty?)
            @patients = find_by_email(@patients)
        end

        if (!params[:sort].nil? && !params[:sort].empty?)
            @patients = sort_users(@patients)
        end
    end

end
