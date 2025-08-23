class Seriesbook < ApplicationRecord
  has_one_attached :cover_image
  belongs_to :user
  has_many :books, dependent: :destroy
  accepts_nested_attributes_for :books, allow_destroy: true
  validates :title, presence: true
end
