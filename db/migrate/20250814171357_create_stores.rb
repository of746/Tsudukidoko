class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :store_name
      t.boolean :is_locked

      t.timestamps
    end
  end
end
