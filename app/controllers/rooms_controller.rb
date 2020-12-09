class RoomsController < ApplicationController
  before_action :check_session
  before_action :set_meeting

  def create
    meeting_service.create_room
  end

  private

  def meeting_service
    @meeting_service ||= MeetingService.new(@meeting)
  end

  def set_meeting
    #TODO 自分が作ったものに限定する
    @meeting = Meeting.find(params[:meeting_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'meetingが存在しません' }, status: :not_found
  end
end