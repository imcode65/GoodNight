class UsersController < ApplicationController
  before_action :set_base_scope

  def index
    follower_counts  = Follow.where(following_user_id: @base_scope.pluck(:id)).group(:following_user_id).count
    following_counts = Follow.where(follower_id: @base_scope.pluck(:id)).group(:follower_id).count
    sleeps           = Sleep.group(:user_id).count
    @users           = @base_scope.map do |user|
      { user_id:         user.id,
        user_name:       user.name,
        sleep_count:     sleeps[user.id] || 0,
        followers_count: follower_counts[user.id] || 0,
        following_count: following_counts[user.id] || 0 }
    end
  end

  private

  def set_base_scope
    user        = if params[:user_id].present?
                    User.find_by(id: params[:user_id])
                  else
                    current_user
                  end
    @base_scope = if params[:view] == 'followers'
                    user.followers
                  elsif params[:view] == 'followings'
                    user.followings
                  else
                    user.followings
                  end
  end
end
