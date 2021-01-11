class PostsTag

  include ActiveModel::Model
  attr_accessor :title, :url, :text, :name, :image, :user_id

  with_options presence: true do
    validates :title
  end

  def save
    post = Post.create(title: title, url: url, text: text, image: image)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    PostTagRelation.create(post_id: post.id, tag_id: tag.id)
  end

end