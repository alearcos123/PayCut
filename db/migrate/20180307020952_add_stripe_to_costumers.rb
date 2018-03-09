class AddStripeToCostumers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :stripe_uid, :string
  end
end
