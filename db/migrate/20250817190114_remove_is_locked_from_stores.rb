class RemoveIsLockedFromStores < ActiveRecord::Migration[6.1]
  def change
    remove_column :stores, :is_locked, :boolean
  end
end
