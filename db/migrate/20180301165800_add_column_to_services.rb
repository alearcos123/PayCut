class AddColumnToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :date_id, :date
  end
end
