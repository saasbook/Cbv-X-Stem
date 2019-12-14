class AdminController < ApplicationController
    skip_authorize_resource
    def admin
        if !current_user.role.eql? 'admin'
            go_to_root("Only Admin can go to adminitration page")
        end
    end

    def new
        if !current_user.role.eql? 'admin'
            go_to_root("Only Admin can create a doctor")
        end
        @new_doctor = User.new
    end

    def delete
        if !current_user.role.eql? 'admin'
            go_to_root("Only Admin can delete doctors")
        end
        @doctor_list = User.where("role='doctor'").pluck(:id)
        @doctors = Profile.where(user_holder_id: UserHolder.where(user_id: @doctor_list).pluck(:id))
        @doctors = filter_by_params(@doctors)
        
        if (!params[:sort].nil? && !params[:sort].empty?)
            @doctors = sort_users(@doctors)
        end
    end

    def check_empty(new_doctor, i)
        err = ""
        if @new_doctor.first_name.empty?
            err << "#{(i += 1).to_s}. First Name can't be empty  "
        end
        if @new_doctor.last_name.empty?
            err << "#{(i += 1).to_s}. Last Name can't be empty  "
        end
        if @new_doctor.email.empty?
            err << "#{(i += 1).to_s}. Email can't be empty  "
        end
        err
    end 

    def check_error(new_doctor)
        err = ""
        i = 0
        if User.where(email: @new_doctor.email).present?
            err <<  "#{(i += 1).to_s}. The email #{@new_doctor.email} has exsited  "
        end
        if !(@new_doctor.password.eql? @new_doctor.password_confirmation)
            err << "#{(i += 1).to_s}. Two passswords are not indetical  "
        end
        if @new_doctor.password.length < 6
            err << "#{(i += 1).to_s}. Password must be at lest 6 characters  "
        end
        empty_err = check_empty(@new_doctor, i)
        err << empty_err
        err
    end

    def try_save(new_doctor, format)
        if new_doctor.save
            new_user_holder = UserHolder.create!(first_name: new_doctor.first_name, last_name: new_doctor.last_name, email: new_doctor.email, user_id: new_doctor.id)
            newprofile = Profile.create!(first_name: new_doctor.first_name, last_name: new_doctor.last_name, email: new_doctor.email, role: new_doctor.role, user_holder_id: new_user_holder.id)
            format.html { redirect_to admin_path, notice: 'New doctor was successfully added.' }
        else
            format.html {  redirect_to create_doctor_path, notice: "The new doctor was not created" }
        end
    end


    # create new doctor and valid the input form
    def create
        if !current_user.role.eql? 'admin'
            go_to_root("Only Admin can create doctors")
        end
        @new_doctor = User.new(doctor_params)
        err = check_error(@new_doctor)
        if !err.empty?
            redirect_to create_doctor_path, notice: err
        else 
            @new_doctor.is_doctor = true
            @new_doctor.role = 'doctor'
            respond_to do |format|
                try_save(@new_doctor, format)
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
