class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.integer :time_slots
      t.integer :price
      t.string :description
      t.integer :barber_id
      t.datetime :date_id
      t.timestamps
    end
  end
end
