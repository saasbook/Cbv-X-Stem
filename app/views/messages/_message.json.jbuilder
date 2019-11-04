json.extract! message, :id, :sender_name, :sender_email, :receiver_email, :subject, :body, :created_at, :updated_at
json.url message_url(message, format: :json)
