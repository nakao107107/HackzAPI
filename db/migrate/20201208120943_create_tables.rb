class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings, id: :string do |t|
      t.string :user_id
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

    create_table :users, id: :string do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :access_token
      t.string :plan
      t.timestamps
    end
  end
end
