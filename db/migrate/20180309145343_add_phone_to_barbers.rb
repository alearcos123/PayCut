class AddPhoneToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :phone, :string
  end
end
