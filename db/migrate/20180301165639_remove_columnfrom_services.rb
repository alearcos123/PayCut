class RemoveColumnfromServices < ActiveRecord::Migration[5.1]
  def change
    remove_column :services, :date_id
  end
end
