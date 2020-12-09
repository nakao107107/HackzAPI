class ChimeService
  def initialize
    region_name = 'us-east-1'
    credentials = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    @client = Aws::Chime::Client.new(
        region: region_name,
        credentials: credentials
    )
  end

  # chime上でのmeetingを作成する
  def create_meeting(external_meeting_id)
    token = SecureRandom.hex(8)
    resp = @client.create_meeting({
                                      client_request_token: token,
                                      external_meeting_id: external_meeting_id
                                  })
    resp.to_h
  rescue StandardError
    raise StandardError, 'meetingの作成に失敗しました'
  end

  # 特定meetingに対してattendeeを作成する
  def create_attendee(chime_meeting_id, attendee_id)
    resp = @client.create_attendee({
                                       meeting_id: chime_meeting_id,
                                       external_user_id: attendee_id
                                   })
    resp.to_h
  end

  # 特定idのmeetingが存在するか調べる
  def check_meeting_presence(meeting_id)
    get_meeting(meeting_id)
    true
  rescue StandardError
    false
  end

  # 特定のmeetingを取得する
  def get_meeting(meeting_id)
    resp = @client.get_meeting({
                                   meeting_id: meeting_id
                               })
    resp.to_h
  rescue StandardError
    raise StandardError, 'meetingの取得に失敗しました'
  end

  # 特定meetingの削除を行う
  def delete_meeting(meeting_id)
    @client.delete_meeting({
                               meeting_id: meeting_id
                           })
  rescue StandardError
    raise StandardError, 'meetingの削除に失敗しました'
  end

  # 特定のattendeeを取得する
  def get_attendee(meeting_id, attendee_id)
    resp = @client.get_attendee({
                                    meeting_id: meeting_id,
                                    attendee_id: attendee_id
                                })
    resp.to_h
  rescue StandardError
    raise StandardError, '参加者の取得に失敗しました'
  end

  # 特定idのattendeeが存在するか調べる
  def check_attendee_presence(meeting_id, attendee_id)
    get_attendee(meeting_id, attendee_id)
    true
  rescue StandardError
    false
  end
end