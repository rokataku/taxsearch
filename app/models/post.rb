class Post < ApplicationRecord
  validates :text, presence: true
  belongs_to :user, optional: true
  has_many :comments
  has_one_attached :image

  validates :url, presence: true, unless: :was_attached?

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
