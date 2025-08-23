class AddUserIdToSeriesbooks < ActiveRecord::Migration[6.1]
  def change
    add_column :seriesbooks, :user_id, :integer
  end
end
