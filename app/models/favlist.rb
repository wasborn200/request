class Favlist < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :microposts
  has_many :favorites
  has_many :favposts, through: :favorites, source: :micropost
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :memo, length: { maximum: 140 }


  def like(micropost)
    favorites.find_or_create_by(micropost_id: micropost.id)
  end

  def unlike(micropost)
    favorite = favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end

  def favpost?(micropost)
    self.favposts.include?(micropost)
  end

end
