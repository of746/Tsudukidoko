class ChangeDefaultForIsLockedInStores < ActiveRecord::Migration[6.1]
  def change
    change_column_default :stores, :is_locked, from: nil, to: false
    change_column_null :stores, :is_locked, false, false
  end
end
