class Notification < ApplicationRecord
	belongs_to :user_holder
end

class EmailNotif < Notification
	belongs_to :user_holder
end

class WhatsappNotif < Notification
	belongs_to :user_holder
end

class WebsiteNotif < Notification
	belongs_to :user_holder
end
