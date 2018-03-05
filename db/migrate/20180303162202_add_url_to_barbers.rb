class AddUrlToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :url, :string
  end
end
