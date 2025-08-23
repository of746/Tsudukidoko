class Store < ApplicationRecord
  belongs_to :user, optional: true
  has_many :books, dependent: :destroy
  validates :store_name, presence: true, uniqueness: true
end
