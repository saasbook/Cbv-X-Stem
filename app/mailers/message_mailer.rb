class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.new_message.subject
  #
  default from: "kelly1129ding@gmail.com"

  def new_message(message)
    @message = message

    mail to: @message.receiver_email, 
         subject: "New Message from Cbv X Stem"
  end
end
