json.extract! music_event, :id, :title, :body, :created_at, :updated_at
json.url music_event_url(music_event, format: :json)
