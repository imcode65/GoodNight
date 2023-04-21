class SleepsController < ApplicationController
  before_action :filter, only: [:index]
  before_action :set_sleep, only: [:show,:update, :destroy]

  def index
    @sleeps = current_user.sleeps.where(@filter)
  end

  def show

  end

  def create
    @sleep = current_user.sleeps.new(sleep_params)
    unless @sleep.save
      render json: { error: true, message: @sleep.errors.to_hash }, status: :unprocessable_entity
    end
  end

  def update
    unless @sleep.update(sleep_params)
      render json: { error: true, message: @sleep.errors.to_hash }, status: :unprocessable_entity
    end
  end

  def destroy
    if @sleep.destroy
      render json: { message: "Sleep deleted successfully!" }
    else
      render json: { error: true, message: @sleep.errors.to_hash }, status: :unprocessable_entity
    end
  end

  def sleep_reports
    @reports = current_user.followings.sleep_report
  end

  private

  def set_sleep
    @sleep = current_user.sleeps.find_by(id: params[:id])
    return if @sleep.present?
    render json: { error: true, message: "Sleep not found!" }, status: :not_found
  end

  def sleep_params
    params.permit(:start_time, :end_time)
  end

  def filter
    @filter = {}
    @filter.merge!(created_at: helpers.parse_date(params[:from])..helpers.parse_date(params[:to])) if params[:from].present? && params[:to].present?
  end
end
