class Favlist < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :memo, length: { maximum: 140 }
end
