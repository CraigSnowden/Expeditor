class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :notes
      t.string :vend_id
      t.boolean :closed

      t.timestamps
    end
  end
end
