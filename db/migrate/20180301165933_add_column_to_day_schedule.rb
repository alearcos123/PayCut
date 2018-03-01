class AddColumnToDaySchedule < ActiveRecord::Migration[5.1]
  def change
    remove_column :day_schedules, :date_id, :date

  end
end
