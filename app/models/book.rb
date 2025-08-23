class Book < ApplicationRecord
  belongs_to :seriesbook
  belongs_to :store
  validates :store, presence: true
  validates :volume_number, presence: true
  validates :volume_number, uniqueness: { scope: [:seriesbook_id, :store_id], message: "はこのストアですでに登録されています" }
end
