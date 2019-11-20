class SearchPatientsController < ApplicationController
  skip_authorize_resource
    def searchPatients
        if current_user.nil?
            flash[:error] = "You must login as doctor to access this page"
            redirect_to root_path
        elsif not is_doctor?
            flash[:error] = "Only Doctor can access this page"
            redirect_to root_path
        end
        @patients = Profile.all
        if (!params[:search_first_name].nil? && !params[:search_first_name].empty?)
            @patients = @patients.where('lower(first_name) = ? ', params[:search_first_name].downcase)
        end
        if (!params[:search_last_name].nil? && !params[:search_last_name].empty?)
            @patients = @patients.where('lower(last_name) = ? ', params[:search_last_name].downcase)
        end

        temp_patient = []
        if (!params[:search_id].nil? && !params[:search_id].empty?)
            # @patients = @patients.where(:user_holder_id => params[:search_id])

            matched_email_list = UserHolder.pluck(:email).select {|email| hashForEmailInFive(email) == params[:search_id]}
            matched_email_list.each do |e|
              user_holder_id = UserHolder.find_by_email(e).id
              temp_patient = temp_patient + @patients.where('user_holder_id = ? ', user_holder_id)
            end
            @patients = temp_patient
        end

        if (!params[:sort].nil? && !params[:sort].empty?)
            case params[:sort]
            when 'first_name'
                @first_name_class = 'bg-warning hilite'
            when 'last_name'
                @last_name_class = 'bg-warning hilite'
            when 'user_holder_id'
                @parent_id_class = 'bg-warning hilite'
            end
            @patients = @patients.order(params[:sort] => :asc)
        end
    end

end
