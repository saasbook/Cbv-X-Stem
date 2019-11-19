json.extract! user_activity, :id, :actor, :action, :category, :original_val, :new_val, :string, :user_holder_id, :created_at, :updated_at
json.url user_activity_url(user_activity, format: :json)
