class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  belongs_to :user, optional: true

  has_many :comments
  has_many :post_tag_relations
  has_many :tags, through: :post_tag_relations
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  
  has_one_attached :image

  validates :text, presence: true
  validates :url, presence: true, unless: :was_attached?
  validates :genre_id, numericality: { other_than: 1 } 

  def self.search(search)
    if search != ""
      Post.where('text LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

  def was_attached?
    self.image.attached?
  end
end
