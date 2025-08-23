class AddStoreIdToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :store_id, :integer
  end
end
