class AddColumnToDaySchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :day_schedules, :date_id, :date
  end
end
