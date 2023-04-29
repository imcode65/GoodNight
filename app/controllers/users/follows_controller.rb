class Users::FollowsController < ApplicationController
  include Docs::Users::FollowsControllerDocs
  before_action :set_user
  before_action :valid_user?, only: [:create, :destroy]
  before_action :set_follow,  only: [:destroy]

  def_param_group :user_details do
    param :followers, Integer, required: true
    param :followings, Integer, required: true
    param :sleeps, Integer, required: true
  end

  api :GET, '/users/:user_id/follows', "Users details"
  param :user_id, String, required: true, desc: "Id of the user"
  error code: 500, desc: 'Internal Server Error'
  error code: 404, desc: "Not Found"
  returns :user_details, code: 200, desc: "List of Sleeps of current user"
  user_follows_user_details
  def user_details
    @followers  = @user.followers.count
    @followings = @user.followings.count
    @sleeps     = @user.sleeps.count
  end

  api :POST, 'users/:user_id/follows', 'Follow a user'
  param :user_id, String, required: true, desc: "Id of the follower"
  param :following_user_id, String, required: true, desc: "Id of the following user"
  error code: 404, desc: "Not Found"
  error code: 422, desc: "Unprocessable Entity"
  error code: 500, desc: 'Internal Server Error'
  user_follows_create
  def create
    @follow = @user.given_follows.new(create_params)
    if @follow.save
      render json: { message: "You started following #{@follow.following_user.name}" }
    else
      render json: { error: true, message: @follow.errors.to_hash }, status: :unprocessable_entity
    end
  end

  api :DELETE, 'users/:user_id/follows', 'Unfollow a user'
  param :user_id, String, required: true, desc: "Id of the follower"
  param :id, String, required: true, desc: "Id of the following user"
  error code: 404, desc: "Not Found"
  error code: 422, desc: "Unprocessable Entity"
  error code: 500, desc: 'Internal Server Error'
  user_follows_destroy
  def destroy
    if @follow.destroy
      render json: { message: "You have unfollowed #{@follow.following_user.name}" }
    else
      render json: { error: true, message: @follow.errors.to_hash }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    return if @user.present?
    render json: { error: true, message: 'User not found!' }, status: :not_found
  end

  def create_params
    params.permit(:following_user_id)
  end

  def set_follow
    @follow = @user.given_follows.find_by(following_user_id: params[:id])
    return if @follow.present?
    render json: { error: true, message: "Can't unfollow a non-following user" }, status: :not_found
  end

  def valid_user?
    return if current_user.id == params[:user_id]
    render json: { error: true, message: "You cannot make any changes to another user" }, status: :unprocessable_entity
  end
end
