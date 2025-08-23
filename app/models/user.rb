class User < ApplicationRecord
  has_many :seriesbooks
  has_many :books
  has_many :stores, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
