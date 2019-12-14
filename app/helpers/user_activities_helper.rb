module UserActivitiesHelper
  # Note: The only modes used currently are 'create', 'edit', 'Edit', and 'delete'

  # log the user user_activities to user_activities database
  def log_change_to_user_activities(category, mode, actor_holder, receiver_holder, previous_item, new_item)
    actor = actor_name_to_s(actor_holder)
    fields, formers, new_vals = "", "", ""

    # Concatenate items into strings that can be split by ';'
    new_item.keys.each do |col_name|
      if new_item[col_name] != previous_item[col_name] && col_name != "created_at" && col_name != "updated_at" then
        fields = fields + col_name + ";"
        formers = formers + (previous_item[col_name].nil? ? "" : previous_item[col_name]).to_s + ";"
        new_vals = new_vals + new_item[col_name].to_s + ";"
      end
    end

    # Check that changes were made (i.e. fields is no longer an empty String)
    if fields != ""
      receiver_holder.user_activities.create!(category: category, actor: actor, action: mode, field: fields, original_val: formers, new_val: new_vals)
    end
  end

  # log the creation or deletion of an item
  def log_create_delete_to_user_activities(category, mode, actor_holder, receiver_holder)
    actor = actor_name_to_s(actor_holder)
    prefix = mode == "create" ? "New " : "One "
    receiver_holder.user_activities.create(category: category, actor: actor, action: mode, field: "All", original_val: prefix + category + " " + mode + "d")
  end

  def actor_name_to_s(actor_holder)
    return actor_holder.first_name + " " + actor_holder.last_name + (actor_holder.user.is_doctor ? " (Doctor)": "")
  end


end
