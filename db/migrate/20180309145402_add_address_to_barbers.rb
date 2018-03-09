class AddAddressToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :address, :string
  end
end
