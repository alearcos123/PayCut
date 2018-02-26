class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :barber, index: true
      t.timestamps
    end
  end
end
