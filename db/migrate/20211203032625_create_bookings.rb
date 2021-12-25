class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.datetime :date
      t.integer :instructor_id
      t.integer :event_id

      t.timestamps
    end
  end
end
