class AddStripeToBarbers < ActiveRecord::Migration[5.1]
  def change
    add_column :barbers, :stripe_uid, :string
  end
end
