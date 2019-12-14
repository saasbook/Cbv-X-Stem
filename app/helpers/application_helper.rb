module ApplicationHelper
  require 'digest/sha1'

  # LEGACY:: For backward compatency - remove if no function using it
  # - One-to-One initializer moved to one_to_one_relationship_initializer_concern
  def getUserHolderWithDefaultCreation
    @user_holder = current_user.user_holder
  end

  def user_login_logout
    if current_user.role == 'guest' then
      render 'shared/log_in_sign_up'
    else
      render 'shared/patient_doctor_button'
    end
  end

  def nav_items
    [
      {
        url: root_path,
        title: 'Home'
      },
      {
        url: about_me_path,
        title: 'About'
      },
      {
        url: contact_path,
        title: 'Contact'
      },
    ]
  end

  def gender_is_female?
    current_user.role == 'guest'  || Guess.gender(current_user.first_name)[:gender] != "male"
  end

  def active? path
    "active" if current_page? path
  end

  def nav_helper style, tag_type
    nav_links = ''

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' style='color: #000;' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
  end

  def profile_name_format(first_name, last_name)
    if Guess.gender(first_name)[:gender] != "male" then
      name_formatted = "<span class='bond_name_female'>#{first_name + " " + last_name}</span>" + " Info"
    else
      name_formatted = "<span class='bond_name_male'>#{first_name + " " + last_name}</span>" + " Info"
    end
    name_formatted.html_safe
  end

  def delete_doctor_format(first_name, last_name)
    if Guess.gender(first_name)[:gender] != "male" then
      name_formatted = "Delete  " + "<span class='bond_name_female'>#{first_name + " " + last_name}</span>"
    else
      name_formatted = "Delete  " + "<span class='bond_name_male'>#{first_name + " " + last_name}</span>"
    end
    name_formatted.html_safe
  end

  def filter_by_params(users)
    if (!params[:search_first_name].nil? && !params[:search_first_name].empty?)
      users = users.where('lower(first_name) = ? ', params[:search_first_name].downcase)
    end
    if (!params[:search_last_name].nil? && !params[:search_last_name].empty?)
      users = users.where('lower(last_name) = ? ', params[:search_last_name].downcase)
    end

    if (!params[:search_id].nil? && !params[:search_id].empty?)
      users = find_by_email(users)
    end
    users
  end

  def hashForUserHolder(user)
    if user.nil? then
      "unavaliable"
    else
      hashForEmailInFive(user.email)
    end
  end

  def hashForEmailInFive(email)
    Digest::SHA1.hexdigest(email)[0..6]
  end

  def redirect_with_userid(user_holder_id)
    @current_profile = Profile.find_by_user_holder_id(user_holder_id)

    params[:patient_name] = @current_profile.first_name + " " + @current_profile.last_name
    params[:patient_id] = @current_profile.user_holder_id
  end

  def go_to_root(msg)
    flash[:error] = msg
    redirect_to root_path
  end

  def check_login_as_doctor(path)
    if (not is_doctor?) && params[:id] != @current_user.id.to_s
      go_to_root ("You are not authorized to view this page!")
    else
      user = User.find(params[:id])
      @current_profile = Profile.find_by_user_holder_id(user.user_holder.id)
      params[:patient_name] = @current_profile.first_name + " " + @current_profile.last_name
      params[:patient_id] = @current_profile.user_holder_id
      render path
    end
  end

  def find_by_email(users)
    temp_users = []
    matched_email_list = UserHolder.pluck(:email).select {|email| hashForEmailInFive(email) == params[:search_id]}
    matched_email_list.each do |e|
      user_holder_id = UserHolder.find_by_email(e).id
      temp_users = temp_users + users.where('user_holder_id = ? ', user_holder_id)
    end
    temp_users
  end

  def sort_users(users)
    case params[:sort]
    when 'first_name'
        @first_name_class = 'bg-warning hilite'
    when 'last_name'
        @last_name_class = 'bg-warning hilite'
    when 'user_holder_id'
        @user_id_class = 'bg-warning hilite'
    end
    users.order(params[:sort] => :asc)
  end

  def redirect_from_cancan_access_denied(link, msg_)
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to link, notice: msg_ }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def general_controller_delete_with_log(actor_uh, receiver_uh, delete_object, redirect_link)
      delete_object_string = delete_object.class.to_s
      delete_object.destroy
      log_create_delete_to_user_activities(delete_object_string.downcase, 'delete', actor_uh, receiver_uh)
      respond_to do |format|
        format.html { redirect_to redirect_link, notice: delete_object_string.capitalize + ' was successfully destroyed.' }
        format.json { head :no_content }
      end
  end

  def general_controller_index
    gon.whatsapp_action = flash[:a] if flash[:a] == 'created' || flash[:a] == 'updated'
    gon.whatsapp_num = @user_holder.profile.whatsapp
    redirect_with_userid(params[:user_holder_id])
  end


  def general_controller_create_with_log_notification(create_object, activity, redirect_link)
    respond_to do |format|
      if create_object.save
        flash[:notice] = [activity.capitalize + ' was successfully created.' ]
        if @user_holder.user_setting.nil?
          @user_holder.user_setting = UserSetting.create(:user_holder_id => @user_holder.user_id)
        end
        send_email_notif(activity, "created")
        send_whatsapp_notif(activity, "created")
        format.html { redirect_to redirect_link}
        format.json { render :show, status: :created, location: object }
        log_create_delete_to_user_activities(activity, 'create', current_user.user_holder, @user_holder)
      else
        format.html { render :new }
        format.json { render json: create_object.errors, status: :unprocessable_entity }
      end
    end
  end

  def general_controller_update_with_log_notification(update_object, update_object_params, activity, redirect_link)
    respond_to do |format|
      temp_object = update_object.as_json
      if update_object.update(update_object_params)
        flash[:notice] = [activity.capitalize + ' was successfully updated.']
        if @user_holder.user_setting.nil?
          @user_holder.user_setting = UserSetting.create(:user_holder_id => @user_holder.user_id)
        end
        send_email_notif(activity, "updated")
        send_whatsapp_notif(activity, "updated")
        format.html { redirect_to redirect_link}
        format.json { render :show, status: :ok, location: update_object }
        log_change_to_user_activities(activity, 'edit', current_user.user_holder, @user_holder, temp_object, update_object.as_json)
      else
        format.html { render :edit }
        format.json { render json: update_object.errors, status: :unprocessable_entity }
      end
    end
  end


end
