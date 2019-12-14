module MessagesHelper
  def send_email_notif(aactivity, action)
    if action == "created" then aaction = "create" else aaction = "change" end
    activity = rename(aactivity)
    notif_setting = @user_holder.user_setting.public_send(aaction + "_" + activity + "_email_notification")
    if notif_setting == "Always notify me" || notif_setting == "Only notifiy me when specified" && params[:email_notif]        
        @message = @user_holder.messages.new(:sender_name => current_user.first_name + " " + current_user.last_name,
                                           :receiver_email => @user_holder.email,
                                           :sender_email => current_user.user_holder.email,
                                           :subject => "A " + aactivity + " was " + action + " by " + current_user.first_name + " " + current_user.last_name,
                                           :body => "A " + aactivity + " was " + action + " by " + current_user.first_name + " " + current_user.last_name)
        if @message.save
          MessageMailer.general_notification(@message, aactivity, action).deliver
        end
    elsif notif_setting == "Never notify me" && params[:email_notif]
        flash[:notice] << "The patient has selected to never notify him or her by email when a " + aactivity + " is " + action + " so the email is not sent."
    end
  end

  def send_whatsapp_notif(aactivity, action)
    if action == "created" then aaction = "create" else aaction = "change" end
    activity = rename(aactivity)
    notif_setting = @user_holder.user_setting.public_send(aaction +  "_" + activity + "_whatsapp_notification")
    flash[:a] = ''
    if !@user_holder.profile || !@user_holder.profile.whatsapp
      flash[:notice] << "The patient doesn't have a WhatsApp number."
    elsif notif_setting == "Always notify me" || notif_setting == "Only notifiy me when specified" && params[:whatsapp_notif]
      flash[:a] = action
    elsif notif_setting == "Never notify me" && params[:whatsapp_notif]
      flash[:notice] << "The patient has selected to never notify him or her through WhatsApp when a " + aactivity + " is " + action + " so the message is not sent."
    end
  end

  def rename(aactivity)
  	if aactivity == "treatment" 
    	"tre" 
    elsif aactivity == "medication"
    	"med"
    else
    	"doc"
    end
  end
end
