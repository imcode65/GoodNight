json.id sleep.id
json.start_time sleep.start_time
json.end_time sleep.end_time
json.user_id sleep.user_id
json.record_started_at sleep.created_at
json.total_sleep_time "#{((sleep.end_time - sleep.start_time) / 60 / 60.0).round(2)} hours"
