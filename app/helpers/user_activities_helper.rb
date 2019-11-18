module UserActivitiesHelper

  # log the user user_activities to user_activities database
  def log_change_to_user_activities(category, mode, user_for_user_holder, previous_item, new_item)
    actor = user_for_user_holder.first_name + " " + user_for_user_holder.last_name + (user_for_user_holder.is_doctor ? " (Doctor)": "")
    # byebug
    new_item.keys.each do |col_name|
      if new_item[col_name] != previous_item[col_name]
        user_for_user_holder.user_holder.user_activities.create(category: category, actor: actor, action: mode, original_val: previous_item[col_name], new_val: new_item[col_name])
      end
    end
  end
end
