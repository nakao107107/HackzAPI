class User < ApplicationRecord
  before_create :set_id
  has_secure_password
  has_one :attendee
  def attend_meeting(meeting_id)
    chime_service = ChimeService.new
    resp = chime_service.create_attendee(Meeting.find(meeting_id).chime_meeting_id, id)
    Attendee
        .find_or_create_by({meeting_id: meeting_id, user_id: id})
        .update!(chime_attendee_id: resp[:attendee][:attendee_id])
  end

  def set_id
    self.id = 'us' + SecureRandom.alphanumeric(10) while id.blank? || self.class.find_by(id: id).present?
  end

  def login
    self.access_token = SecureRandom.hex
    save!
  end
end
