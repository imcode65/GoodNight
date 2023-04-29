class UsersController < ApplicationController
  include Docs::UsersControllerDocs
  before_action :set_user, :set_base_scope

  def_param_group :users_record do
    param :user_id, String, required: true, uniqueness: true
    param :user_name, String, required: true
    param :sleep_count, Integer, required: true
    param :followers_count, Integer, required: true
    param :following_count, Integer, required: true
  end
  api :GET, "/users", "Followers or Following users list with their details"
  param :view, ['followers', 'followings'], required: false, desc: "Type of the view (default: view = followings)"
  error code: 500, desc: 'Internal Server Error'
  returns array_of: :users_record, code: 200, desc: "Users list with their sleeps, followers and followings count"
  users_index

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

  def set_user
    @user = if params[:user_id].present?
              User.find_by(id: params[:user_id])
            else
              current_user
            end
    return if @user.present?
    render json: { error: true, message: "User not found!"}, status: :not_found
  end

  def set_base_scope
    @base_scope = if params[:view] == 'followers'
                    @user.followers
                  elsif params[:view] == 'followings'
                    @user.followings
                  else
                    @user.followings
                  end
  end
end
