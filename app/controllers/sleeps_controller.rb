class SleepsController < ApplicationController
  include Docs::SleepsControllerDocs
  before_action :filter, only: [:index]
  before_action :set_sleep, only: [:show, :update, :destroy]

  def_param_group :sleeps_record do
    param :id, String, required: true, uniqueness: true
    param :start_time, DateTime, required: true
    param :end_time, DateTime, required: true
    param :user_id, String, required: true
    param :record_started_at, DateTime, required: true
    param :total_sleep_time, String, required: true
  end

  api :GET, '/sleeps', "List of Sleeps of current user"
  error code: 500, desc: 'Internal Server Error'
  returns array_of: :sleeps_record, code: 200, desc: "List of Sleeps of current user"
  sleeps_index

  def index
    @sleeps = current_user.sleeps.where(@filter)
  end

  api :GET, '/sleeps/:id', "Details of a sleep"
  param :id, String, required: true, desc: "Id of the Sleep"
  error code: 500, desc: 'Internal Server Error'
  error code: 404, desc: "Not Found"
  returns :sleeps_record, code: 200, desc: "Details of a sleep"
  sleeps_show

  def show

  end

  api :POST, '/sleeps', "Create a sleep"
  param :start_time, DateTime, desc: 'Start time of the sleep', required: true
  param :end_time, DateTime, desc: 'End time of the sleep', required: true
  error code: 400, desc: 'Bad request'
  error code: 422, desc: "Unprocessable Entity"
  error code: 500, desc: 'Internal server error'
  returns :sleeps_record, code: 200, desc: "Sleep Created"
  sleeps_create

  def create
    @sleep = current_user.sleeps.new(sleep_params)
    unless @sleep.save
      render json: { error: true, message: @sleep.errors.to_hash }, status: :unprocessable_entity
    end
  end

  api :PATCH, '/sleeps/:id', "Update a sleep"
  param :id, String, desc: "Id of the Sleep", required: true
  param :start_time, DateTime, desc: 'Start time of the sleep', required: true
  param :end_time, DateTime, desc: 'End time of the sleep', required: true
  error code: 400, desc: 'Bad request'
  error code: 422, desc: "Unprocessable Entity"
  error code: 404, desc: "Not Found"
  error code: 500, desc: 'Internal server error'
  returns :sleeps_record, code: 200, desc: "Sleep Updated"
  sleeps_update

  def update
    unless @sleep.update(sleep_params)
      render json: { error: true, message: @sleep.errors.to_hash }, status: :unprocessable_entity
    end
  end

  api :DELETE, '/sleeps/:id', "Delete a sleep"
  param :id, String, desc: "Id of the Sleep", required: true
  error code: 400, desc: 'Bad request'
  error code: 404, desc: "Not Found"
  error code: 500, desc: 'Internal server error'
  sleep_destroy
  def destroy
    if @sleep.destroy
      render json: { message: "Sleep deleted successfully!" }
    else
      render json: { error: true, message: @sleep.errors.to_hash }, status: :unprocessable_entity
    end
  end

  api :GET, '/sleep_reports', "Last 7 days sleeps of current user followings"
  error code: 400, desc: 'Bad request'
  error code: 500, desc: 'Internal server error'
  sleep_sleep_reports
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
