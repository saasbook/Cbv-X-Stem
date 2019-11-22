module UserActivitiesHelper

  # log the user user_activities to user_activities database
  def log_change_to_user_activities(category, mode, actor_holder, receiver_holder, previous_item, new_item)
    actor = actor_holder.first_name + " " + actor_holder.last_name + (actor_holder.user.is_doctor ? " (Doctor)": "")
    # byebug
    new_item.keys.each do |col_name|
      if new_item[col_name] != previous_item[col_name] && col_name != "created_at" && col_name != "updated_at" then
        receiver_holder.user_activities.create(category: category, actor: actor, action: mode, field: col_name, original_val: previous_item[col_name], new_val: new_item[col_name])
      end
    end
  end
  def log_create_delete_to_user_activities(category, mode, actor_holder, receiver_holder)
    actor = actor_holder.first_name + " " + actor_holder.last_name + (actor_holder.user.is_doctor ? " (Doctor)": "")
    receiver_holder.user_activities.create(category: category, actor: actor, action: mode, field: "All", original_val: "New " + category + " " + mode + "d")
  end



end
