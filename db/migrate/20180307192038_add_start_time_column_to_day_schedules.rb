class AddStartTimeColumnToDaySchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :day_schedules, :start_time, :integer
  end
end
