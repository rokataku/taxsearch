class PostsTag

  include ActiveModel::Model
  attr_accessor :title, :url, :text, :genre_id, :name, :image, :user_id

  with_options presence: true do
    validates :title
    validates :name
  end

  def initialize(attribute = {})
    if !(attribute[:id] == nil)
      @post = Post.find(attribute[:id])
      @tag = PostTagRelation.find(attribute[:tag_id])
      if !(self.title = attribute[:title])
        self.title = @post.title
      else
        self.title = attribute[:title]
      end
      if !(self.name = attribute[:name])
        self.name = @tag.name 
      else
        self.name = attribute[:name]
      end
    else
      super(attribute)
    end
  end

  def persisted?
    if @post.nil? 
      return false 
    else
       return @post.persisted?
    end
  end

  def save
    post = Post.create(title: title, url: url, text: text, genre_id: genre_id, image: image, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    PostTagRelation.create(post_id: post.id, tag_id: tag.id)
  end

  def update
    @post.update(title: title, url: url, text: text, genre_id: genre_id, image: image, user_id: user_id)
    @tag.update(name: name).first_or_initialize
  end

end