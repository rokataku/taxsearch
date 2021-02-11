class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :posts
  has_many :comments
  has_many :sns_credentials
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      name: auth.info.name,
      email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

  def likable_for?(post)
    post && post.user != self && !likes.exists?(post_id: post.id)
  end

  def deletable_for?(post)
    post && post.user != self && likes.exists?(post_id: post.id)
  end

end
