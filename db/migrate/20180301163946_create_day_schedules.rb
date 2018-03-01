class CreateDaySchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :day_schedules do |t|
      t.integer :time_slots
      t.integer :barber_id
      t.datetime :date_id
      t.timestamps
    end
  end
end
