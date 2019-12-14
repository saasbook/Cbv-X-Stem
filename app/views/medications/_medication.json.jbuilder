json.extract! medication, :id, :name, :provider, :directions, :days, :description, :user_holder_id, :created_at, :updated_at
json.url medication_url(medication, format: :json)
