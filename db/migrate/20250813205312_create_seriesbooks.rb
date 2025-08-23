class CreateSeriesbooks < ActiveRecord::Migration[6.1]
  def change
    create_table :seriesbooks do |t|
      t.string :title
      t.string :author

      t.timestamps
    end
  end
end
