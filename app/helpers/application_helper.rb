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

  def go_to_root
    flash[:error] = "You are not authorized to view this page!"
    redirect_to root_path
  end

  def check_login_as_doctor(path)
    if (not is_doctor?) && params[:id] != @current_user.id.to_s
      go_to_root
    else
      user = User.find(params[:id])
      @current_profile = Profile.find_by_user_holder_id(user.user_holder.id)
      params[:patient_name] = @current_profile.first_name + " " + @current_profile.last_name
      params[:patient_id] = @current_profile.user_holder_id
      render path
    end
  end

  def redirect_from_cancan_access_denied(link, msg_)
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to link, notice: msg_ }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def general_controller_delete_with_log(actor_uh, receiver_uh, delete_object, delete_object_string, redirect_link)
      delete_object.destroy
      log_create_delete_to_user_activities(delete_object_string, 'delete', actor_uh, receiver_uh)
      respond_to do |format|
        format.html { redirect_to redirect_link, notice: delete_object_string.capitalize + ' was successfully destroyed.' }
        format.json { head :no_content }
      end
  end


end
