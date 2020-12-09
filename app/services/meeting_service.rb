class MeetingService

  def initialize(meeting)
    @meeting = meeting
  end

  def create_room
    chime_service = ChimeService.new
    # すでに有効なroomが作られていた場合は何もしない
    return if chime_service.check_meeting_presence(@meeting.chime_meeting_id)

    response = chime_service.create_meeting(@meeting.id)
    @meeting.update!(chime_meeting_id: response[:meeting][:meeting_id])
  end
end