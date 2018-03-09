class AddBarberNameToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :barberName, :string
  end
end
