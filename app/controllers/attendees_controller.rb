class AttendeesController < ApplicationController
  before_action :check_session
  def index
    render json: Attendee.where(meeting_id: params[:meeting_id]), status: :ok
  end
end
