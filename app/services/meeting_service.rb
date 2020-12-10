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

  def fetch_room
    chime_service = ChimeService.new
    room = chime_service.get_meeting(@meeting.chime_meeting_id)
    room
  end

  def fetch_attendee(user_id)
    chime_service = ChimeService.new
    attendee_id = Attendee.find_by_user_id_and_meeting_id(user_id, @meeting.id).chime_attendee_id
    attendee = chime_service.get_attendee(@meeting.chime_meeting_id, attendee_id)
    attendee
  end
end