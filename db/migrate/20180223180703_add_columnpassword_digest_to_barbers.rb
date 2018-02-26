class AddColumnpasswordDigestToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :password_digest, :string
  end
end
