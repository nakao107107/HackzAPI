class AttendeesController < ApplicationController
  before_action :check_session
  def index
    render json: Attendee.joins(:user).select('attendees.*, users.name').all.map{|attendee| attendee.attributes}, status: :ok
  end
end
