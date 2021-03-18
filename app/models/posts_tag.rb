class PostsTag
  include ActiveModel::Model

  attr_accessor :title, :url, :text, :genre_id, :name, :image, :user_id, :tag_names

  with_options presence: true do
    validates :title
    validates :split_tag_names

  end
  
  delegate :persisted?, to: :post

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      tags = split_tag_names.map {|name| Tag.find_or_create_by!(name: name) }
      post.update(title: title, url: url, text: text, genre_id: genre_id, image: image, user_id: user_id)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    post
  end

  private

  attr_reader :post

  def default_attributes
    {
      title: post.title,
      url: post.url,
      text: post.text,
      genre_id: post.genre_id,
      image: post.image,
      user_id: post.user_id,
      tag_names: post.tags.pluck(:name).join(',')
    }
  end

  def split_tag_names
    tag_names.split(',')
  end
end