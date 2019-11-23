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
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
  end

  def profile_name_format(first_name, last_name)
    if Guess.gender(first_name)[:gender] != "male" then
      name_formatted = "<span class='bond_name_female'>#{first_name + " " + last_name}</span>" + " profile"
    else
      name_formatted = "<span class='bond_name_male'>#{first_name + " " + last_name}</span>" + " profile"
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

end
