class AddActivationToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :activation_digest, :string
    add_column :barbers, :activated, :boolean, default: false
    add_column :barbers, :activated_at, :datetime
  end
end
