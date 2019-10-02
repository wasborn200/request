class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :favorites, foreign_key: 'micropost_id', dependent: :destroy
  has_many :favlists, through: :favorites
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  validates :title, presence: true, length: { maximum: 30 }

  private

  def self.create_all_ranks
    Micropost.find(Like.group(:micropost_id).order('count(micropost_id)desc').limit(5).pluck(:micropost_id))
  end

    # アップロードされたファイルのサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
