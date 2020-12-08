class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings, id: false do |t|
      t.string :id
      t.string :topic
      t.datetime :start_time
      t.datetime :end_time
      t.string :chime_meeting_id
      t.timestamps
    end

    create_table :attendees do |t|
      t.string :meeting_id
      t.string :user_id
      t.string :chime_attendee_id
      t.timestamps
    end
  end
end
