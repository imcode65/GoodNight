json.data do
  json.array! @users do |user|
    json.id user[:user_id]
    json.name user[:user_name]
    json.sleeps user[:sleep_count]
    json.followers user[:followers_count]
    json.followings user[:following_count]
  end
end