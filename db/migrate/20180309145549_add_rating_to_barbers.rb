class AddRatingToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :rating, :float
  end
end
