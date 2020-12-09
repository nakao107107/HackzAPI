class MeetingsController < ApplicationController
  before_action :check_session
  before_action :set_meeting, only: [:show]
  def index
    render json: Meeting.all, status: :ok
  end

  def show
    render json: @meeting, status: :ok
  end

  def create
    meeting = Meeting.create(meeting_params.merge({user_id: @user.id}))
    render json: meeting, status: :created
  end

  private
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end
  def meeting_params
    params.permit(:topic, :start_time, :end_time)
  end
end
