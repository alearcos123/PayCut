class CreateSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :slots do |t|
      t.timestamps
      t.date :date_id
      t.integer :barber_id
      t.integer :service_id
      t.integer :slot_number

    end
  end
end
