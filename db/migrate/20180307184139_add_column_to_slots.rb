class AddColumnToSlots < ActiveRecord::Migration[5.1]
  def change
    add_column :slots, :day_schedule_id, :integer 
  end
end
