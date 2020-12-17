class MeetingsController < ApplicationController
  before_action :check_session
  before_action :set_meeting, only: [:show, :attend]
  def index
    render json: Meeting.where(user_id: @user.id), status: :ok
  end

  def show
    render json: @meeting, status: :ok
  end

  def create
    meeting = Meeting.create(meeting_params.merge({user_id: @user.id}))
    render json: meeting, status: :created
  end

  def attend
    @user.attend_meeting(@meeting.id)
  end

  private
  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end
  def meeting_params
    params.permit(:topic, :start_time, :end_time)
  end
end
