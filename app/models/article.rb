class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user   # 👈 nuevo
  has_many_attached :images

  def owned_by?(user)
    self.user == user
  end

  def comments_count
    comments.size
  end

  def likes_count
    likes.size
  end

  def image_urls
    images.map { |img| Rails.application.routes.url_helpers.rails_blob_path(img, only_path: true) }
  end
end