json.extract! event, :id, :name, :venue, :FB_link, :date, :created_at, :updated_at
json.url event_url(event, format: :json)
