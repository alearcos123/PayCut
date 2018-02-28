class AddRememberDigestToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :remember_digest, :string
  end
end
