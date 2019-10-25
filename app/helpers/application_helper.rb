module ApplicationHelper

  def user_login_logout
    if current_user.nil? then
      render 'shared/log_in_sign_up'
    else
      render 'shared/user_pivotal_button'

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
