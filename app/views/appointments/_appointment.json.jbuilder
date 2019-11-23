json.extract! appointment, :id, :patient, :location, :start, :end, :user_holder_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
