module ApplicationHelper
  def login_helper style = ''
    if current_user.nil?
      (link_to "Register", new_user_registration_path, class: style) +
      " ".html_safe +
      (link_to "Login", new_user_session_path, class: style)
    else
      link_to "Logout", destroy_user_session_path, method: :delete, class: style
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
      {
        url: patient_profile_path,
        title: 'Profile'
      },
    ]
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

end
