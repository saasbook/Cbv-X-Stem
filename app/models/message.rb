class Message < ApplicationRecord
	belongs_to :user_holder
	validates_presence_of :sender_name, :subject, :body
    validates_format_of :sender_email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
    validates_format_of :receiver_email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
end
