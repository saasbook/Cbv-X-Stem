class AdminController < ApplicationController
    skip_authorize_resource
    def admin
        if !current_user.role.eql? 'admin'
            flash[:error] = "Only Admin can go to adminitration page"
            redirect_to root_path
        end
    end

    def new
        @new_doctor = User.new
    end

    def delete
        if !current_user.role.eql? 'admin'
            flash[:error] = "Only Admin can delete doctors"
            redirect_to root_path
        end
        @doctor_list = User.where("role='doctor'").pluck(:id)
        @doctors = Profile.where(user_holder_id: UserHolder.where(user_id: @doctor_list).pluck(:id))

        if (!params[:search_first_name].nil? && !params[:search_first_name].empty?)
            @doctors = @doctors.where('lower(first_name) = ? ', params[:search_first_name].downcase)
        end
        if (!params[:search_last_name].nil? && !params[:search_last_name].empty?)
            @doctors = @doctors.where('lower(last_name) = ? ', params[:search_last_name].downcase)
        end

        temp_patient = []
        if (!params[:search_id].nil? && !params[:search_id].empty?)
            # @doctors = @doctors.where(:user_holder_id => params[:search_id])

            matched_email_list = UserHolder.pluck(:email).select {|email| hashForEmailInFive(email) == params[:search_id]}
            matched_email_list.each do |e|
              user_holder_id = UserHolder.find_by_email(e).id
              temp_doctor = temp_doctor+ @doctors.where('user_holder_id = ? ', user_holder_id)
            end
            @doctors = temp_patient
        end

        if (!params[:sort].nil? && !params[:sort].empty?)
            case params[:sort]
            when 'first_name'
                @first_name_class = 'bg-warning hilite'
            when 'last_name'
                @last_name_class = 'bg-warning hilite'
            when 'user_holder_id'
                @doctor_id_class = 'bg-warning hilite'
            end
            @doctors = @doctors.order(params[:sort] => :asc)
        end
    end

    # create new doctor and valid the input form
    def create
        if !current_user.is_doctor?
            flash[:error] = "Only Admin or Doctor can create doctors"
            redirect_to root_path
        end
        @new_doctor = User.new(doctor_params)
        err = ""
        i = 0
        if User.where(email: @new_doctor.email).present?
            err <<  "#{(i += 1).to_s}. The email #{@new_doctor.email} has exsited  "
        end
        if @new_doctor.first_name.empty?
            err << "#{(i += 1).to_s}. First Name can't be empty  "
        end
        if @new_doctor.last_name.empty?
            err << "#{(i += 1).to_s}. Last Name can't be empty  "
        end
        if @new_doctor.email.empty?
            err << "#{(i += 1).to_s}. Email can't be empty  "
        end
        if !(@new_doctor.password.eql? @new_doctor.password_confirmation)
            err << "#{(i += 1).to_s}. Two passswords are not indetical  "
        end
        if @new_doctor.password.length < 6
        end
        if i > 0
            redirect_to create_doctor_path, notice: err
        else 
            @new_doctor.is_doctor = true
            @new_doctor.role = 'doctor'
            respond_to do |format|
                if @new_doctor.save
                    new_user_holder = UserHolder.create!(first_name: @new_doctor.first_name,
                        last_name: @new_doctor.last_name,
                        email: @new_doctor.email,
                        user_id: @new_doctor.id)
                    newprofile = Profile.create!(first_name: @new_doctor.first_name,
                        last_name: @new_doctor.last_name,
                        email: @new_doctor.email,
                        role: @new_doctor.role,
                        user_holder_id: new_user_holder.id)
                    format.html { redirect_to admin_path, notice: 'New doctor was successfully added.' }
                    # format.json { render :show, status: :created, location: @new_doctor }
                else
                    format.html {  redirect_to create_doctor_path, notice: "The new doctor was not created" }
                    # format.json { render json: @new_doctor.errors, status: :unprocessable_entity }
                end
            end
        end
    end

    def delete_single
        @delete_doctor = User.where(id: params[:id]).first
        User.delete(params[:id])
        UserHolder.delete(params[:id])
        Profile.delete(params[:id])
        redirect_to delete_doctor_path, notice: "#{@delete_doctor.first_name} #{@delete_doctor.last_name} was deleted"
    end

    private
    def doctor_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
