class AddPhotoUrlToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :photoUrl, :string
  end
end
