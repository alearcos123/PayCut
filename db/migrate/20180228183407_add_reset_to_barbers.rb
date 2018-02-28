class AddResetToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :reset_digest, :string
    add_column :barbers, :reset_sent_at, :datetime
  end
end
