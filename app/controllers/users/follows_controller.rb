class Users::FollowsController < ApplicationController
  before_action :set_user
  before_action :set_follow, only: [:destroy]

  def index
    @followers  = @user.followers.count
    @followings = @user.followings.count
    @sleeps     = @user.sleeps.count
  end

  def create
    @follow = @user.given_follows.new(create_params)
    if @follow.save
      render json: { message: "You started following #{@follow.following_user.name}" }
    else
      render json: { error: true, message: @follow.errors.to_hash }, status: :unprocessable_entity
    end
  end

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
end
