class AddCoverUrlToSeriesbooks < ActiveRecord::Migration[6.1]
  def change
    add_column :seriesbooks, :cover_url, :string
  end
end
